package com.director_appraisal.form_data_service.controller.config;

import com.director_appraisal.form_data_service.dto.config.CompiledSchemaDto;
import com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto;
import com.director_appraisal.form_data_service.model.config.University;
import com.director_appraisal.form_data_service.service.config.FormConfigService;
import com.director_appraisal.form_data_service.service.config.UniversityService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.*;

@Slf4j
@RestController
@RequestMapping("/api/config")
@CrossOrigin
public class ClientConfigController {

    private final FormConfigService formConfigService;
    private final UniversityService universityService;
    private final ObjectMapper objectMapper;

    private static final Set<String> ALLOWED_BRANDING_ROLES = Set.of(
            "iqac",
            "admin",
            "super_admin",
            "super-admin",
            "platform_admin",
            "platform-admin"
    );

    public ClientConfigController(FormConfigService formConfigService, UniversityService universityService) {
        this(formConfigService, universityService, new ObjectMapper());
    }

    @Autowired
    public ClientConfigController(FormConfigService formConfigService, UniversityService universityService, ObjectMapper objectMapper) {
        this.formConfigService = formConfigService;
        this.universityService = universityService;
        this.objectMapper = objectMapper != null ? objectMapper : new ObjectMapper();
    }

    @GetMapping("/active")
    public ResponseEntity<CompiledSchemaDto> getActiveSchema(
            @RequestParam(required = false, defaultValue = "academic") String auditType,
            @RequestParam(required = false) String universityCode,
            @RequestParam(required = false) Long universityId,
            @RequestParam(required = false) String school,
            @RequestHeader(value = "X-University-Code", required = false) String headerUniversityCode,
            @RequestHeader(value = "X-University-Id", required = false) Long headerUniversityId,
            @RequestHeader(value = "X-User-School", required = false) String headerSchool) {

        String code = universityCode != null && !universityCode.isBlank() ? universityCode : headerUniversityCode;
        Long uId = universityId != null ? universityId : headerUniversityId;
        if ((code == null || code.isBlank()) && uId != null) {
            code = universityService.getById(uId).map(University::getCode).orElse(null);
        }
        if (code == null || code.isBlank()) {
            code = universityService.getAllUniversities().stream().findFirst().map(University::getCode).orElse(null);
        }

        String schoolToUse = (school != null && !school.isBlank()) ? school : headerSchool;
        CompiledSchemaDto compiled = formConfigService.getActiveCompiledSchema(code, auditType, schoolToUse);
        return ResponseEntity.ok(compiled);
    }

    @GetMapping("/version/{versionId}")
    public ResponseEntity<CompiledSchemaDto> getSchemaByVersion(@PathVariable Long versionId) {
        CompiledSchemaDto compiled = formConfigService.getCompiledSchemaByVersion(versionId);
        return ResponseEntity.ok(compiled);
    }

    @GetMapping("/branding")
    public ResponseEntity<Map<String, Object>> getBranding(
            @RequestParam(required = false) String universityCode,
            @RequestParam(required = false) Long universityId,
            @RequestHeader(value = "X-University-Code", required = false) String headerUniversityCode,
            @RequestHeader(value = "X-University-Id", required = false) Long headerUniversityId) {

        String code = universityCode != null && !universityCode.isBlank() ? universityCode : headerUniversityCode;
        Long uId = universityId != null ? universityId : headerUniversityId;

        University u = null;
        if (code != null && !code.isBlank()) {
            u = universityService.getByCode(code).orElse(null);
        } else if (uId != null) {
            u = universityService.getById(uId).orElse(null);
        }
        if (u == null) {
            u = universityService.getAllUniversities().stream().findFirst().orElse(null);
        }

        return ResponseEntity.ok(toBrandingMap(u));
    }

    @PutMapping("/branding")
    public ResponseEntity<?> updateBranding(
            @RequestBody UpdateBrandingRequestDto req,
            @RequestHeader(value = "X-User-Role", required = false) String headerUserRole,
            @RequestHeader(value = "X-University-Code", required = false) String headerUniversityCode,
            @RequestHeader(value = "X-University-Id", required = false) Long headerUniversityId,
            @RequestHeader(value = "Authorization", required = false) String authHeader) {

        // 1. Resolve role & university claims from headers or JWT claims
        String role = headerUserRole;
        String code = headerUniversityCode;
        Long uId = headerUniversityId;

        if (role == null || role.isBlank() || ((code == null || code.isBlank()) && uId == null)) {
            Map<String, Object> claims = parseJwtClaims(authHeader);
            if (role == null || role.isBlank()) {
                Object r = claims.get("role");
                if (r != null) role = r.toString();
            }
            if ((code == null || code.isBlank()) && uId == null) {
                Object c = claims.get("universityCode");
                if (c != null && !c.toString().isBlank()) code = c.toString();
                Object idVal = claims.get("universityId");
                if (idVal != null) {
                    try {
                        uId = Long.valueOf(idVal.toString());
                    } catch (NumberFormatException ignored) {}
                }
            }
        }

        // 2. Authorize: role iqac, super-admin, platform-admin, admin. Reject every other role with 403.
        if (!isAuthorizedBrandingRole(role)) {
            log.warn("[SECURITY] Unauthorized branding update attempt by role: '{}'", role);
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
                    "message", "Access denied. Role '" + (role != null ? role : "anonymous") + "' is not authorized to update university branding."
            ));
        }

        // 3. Resolve target university strictly from caller JWT claim — never trust client-supplied identifier
        University target = null;
        if (code != null && !code.isBlank()) {
            target = universityService.getByCode(code).orElse(null);
        } else if (uId != null) {
            target = universityService.getById(uId).orElse(null);
        }
        if (target == null) {
            target = universityService.getAllUniversities().stream().findFirst().orElse(null);
        }
        if (target == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
                    "message", "Target university could not be resolved from authentication claims."
            ));
        }

        // 4. Validation: universityName non-empty
        if (req == null || req.getUniversityName() == null || req.getUniversityName().trim().isBlank()) {
            return ResponseEntity.badRequest().body(Map.of(
                    "message", "University name is required and cannot be empty."
            ));
        }

        // Validation: logoUrl / iqacLogoUrl pointing to valid URL / uploads / data:image
        if (req.getLogoUrl() != null && !req.getLogoUrl().trim().isBlank() && !isValidLogoUrl(req.getLogoUrl())) {
            return ResponseEntity.badRequest().body(Map.of(
                    "message", "Invalid logoUrl: must be a well-formed URL, an uploaded attachment path (/uploads/...), or a data:image base64 URI."
            ));
        }
        if (req.getIqacLogoUrl() != null && !req.getIqacLogoUrl().trim().isBlank() && !isValidLogoUrl(req.getIqacLogoUrl())) {
            return ResponseEntity.badRequest().body(Map.of(
                    "message", "Invalid iqacLogoUrl: must be a well-formed URL, an uploaded attachment path (/uploads/...), or a data:image base64 URI."
            ));
        }

        // 5. Persistence: reuse existing updateUniversity logic behind PUT /api/universities/{id}
        University updateEntity = new University();
        updateEntity.setName(req.getUniversityName().trim());
        if (req.getDomain() != null) {
            updateEntity.setDomain(req.getDomain().trim());
        }
        if (req.getAddress() != null) {
            updateEntity.setAddress(req.getAddress().trim());
        }
        if (req.getAct() != null) {
            updateEntity.setEstablishmentAct(req.getAct().trim());
        }
        if (req.getLogoUrl() != null) {
            updateEntity.setLogoUrl(req.getLogoUrl().trim());
        }
        if (req.getIqacLogoUrl() != null) {
            updateEntity.setIqacLogoUrl(req.getIqacLogoUrl().trim());
        }

        University updated = universityService.updateUniversity(target.getId(), updateEntity);
        log.info("[BRANDING_UPDATE] University id={} code='{}' updated by role='{}'", target.getId(), target.getCode(), role);

        // 6. Response: return full updated branding object, same shape as GET response
        return ResponseEntity.ok(toBrandingMap(updated));
    }

    private boolean isAuthorizedBrandingRole(String role) {
        if (role == null || role.isBlank()) {
            return false;
        }
        String clean = role.trim().toLowerCase(Locale.ROOT);
        String underscore = clean.replace("-", "_");
        String hyphen = clean.replace("_", "-");
        return ALLOWED_BRANDING_ROLES.contains(clean) ||
               ALLOWED_BRANDING_ROLES.contains(underscore) ||
               ALLOWED_BRANDING_ROLES.contains(hyphen);
    }

    private boolean isValidLogoUrl(String url) {
        if (url == null || url.trim().isBlank()) {
            return true;
        }
        String trimmed = url.trim();
        if (trimmed.contains("<") || trimmed.contains(">") || trimmed.contains("\"") || trimmed.contains("'")) {
            return false;
        }
        if (trimmed.startsWith("data:image/")) {
            return trimmed.contains(";base64,") && trimmed.length() > "data:image/;base64,".length();
        }
        if (trimmed.contains("..") || trimmed.contains("\\")) {
            return false;
        }
        if (trimmed.startsWith("/uploads/") || trimmed.startsWith("uploads/")
                || trimmed.startsWith("/api/attachments/") || trimmed.startsWith("api/attachments/")
                || trimmed.startsWith("users/")) {
            return true;
        }
        try {
            URI uri = URI.create(trimmed);
            String scheme = uri.getScheme();
            if ("http".equalsIgnoreCase(scheme) || "https".equalsIgnoreCase(scheme)) {
                return uri.getHost() != null && !uri.getHost().isBlank();
            }
        } catch (Exception ignored) {
            return false;
        }
        return false;
    }

    private Map<String, Object> parseJwtClaims(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return Collections.emptyMap();
        }
        try {
            String token = authHeader.substring(7).trim();
            String[] parts = token.split("\\.");
            if (parts.length >= 2) {
                byte[] decoded = Base64.getUrlDecoder().decode(parts[1]);
                return objectMapper.readValue(decoded, new TypeReference<Map<String, Object>>() {});
            }
        } catch (Exception e) {
            log.warn("Failed to parse JWT payload from Authorization header: {}", e.getMessage());
        }
        return Collections.emptyMap();
    }

    private Map<String, Object> toBrandingMap(University u) {
        if (u == null) {
            return Map.of(
                    "universityName", "",
                    "code", "",
                    "address", "",
                    "act", "",
                    "logoUrl", "",
                    "iqacLogoUrl", ""
            );
        }

        Map<String, Object> map = new LinkedHashMap<>();
        map.put("id", u.getId());
        map.put("code", u.getCode() != null ? u.getCode() : "");
        map.put("universityName", u.getName() != null ? u.getName() : "");
        map.put("domain", u.getDomain() != null ? u.getDomain() : "");
        map.put("address", u.getAddress() != null ? u.getAddress() : "");
        map.put("act", u.getEstablishmentAct() != null ? u.getEstablishmentAct() : "");
        map.put("logoUrl", u.getLogoUrl() != null ? u.getLogoUrl() : "");
        map.put("iqacLogoUrl", u.getIqacLogoUrl() != null ? u.getIqacLogoUrl() : "");
        map.put("primaryColor", u.getPrimaryColor() != null ? u.getPrimaryColor() : "#1e3a8a");
        map.put("themeBranding", u.getThemeBranding() != null ? u.getThemeBranding() : "{}");
        return map;
    }
}

