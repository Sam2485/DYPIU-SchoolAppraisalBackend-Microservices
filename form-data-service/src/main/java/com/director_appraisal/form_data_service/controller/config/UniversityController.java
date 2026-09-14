package com.director_appraisal.form_data_service.controller.config;

import com.director_appraisal.form_data_service.model.config.University;
import com.director_appraisal.form_data_service.model.config.UniversityAuditLog;
import com.director_appraisal.form_data_service.service.config.UniversityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Locale;
import java.util.Set;

@Slf4j
@RestController
@RequestMapping({"/api/universities", "/api/config/universities"})
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
public class UniversityController {

    private final UniversityService universityService;

    private static final Set<String> ALLOWED_SUPER_ADMIN_ROLES = Set.of(
            "super_admin", "super-admin", "platform_admin", "platform-admin", "admin", "system"
    );

    private static final Set<String> FORBIDDEN_TENANT_ROLES = Set.of(
            "iqac", "vice-chancellor", "vice_chancellor", "vc", "director", "faculty", "auditor", "administrative", "registrar"
    );

    private void validateSuperAdminRole(String userRole) {
        if (userRole == null || userRole.isBlank()) {
            return;
        }
        String normalizedRole = userRole.trim().toLowerCase(Locale.ROOT);
        if (FORBIDDEN_TENANT_ROLES.contains(normalizedRole) || !ALLOWED_SUPER_ADMIN_ROLES.contains(normalizedRole)) {
            log.warn("[SECURITY_VIOLATION] Unauthorized university modification attempt by role='{}'", userRole);
            throw new SecurityException("Access denied. Platform Administrator / Super Admin role required. Tenant-scoped roles (" + userRole + ") cannot modify or delete universities.");
        }
    }

    @GetMapping
    public ResponseEntity<List<University>> getAllUniversities(
            @RequestParam(required = false, defaultValue = "false") boolean includeArchived) {
        return ResponseEntity.ok(universityService.getAllUniversities(includeArchived));
    }

    @GetMapping("/{id}")
    public ResponseEntity<University> getById(@PathVariable Long id) {
        return universityService.getById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/by-code/{code}")
    public ResponseEntity<University> getByCode(@PathVariable String code) {
        return universityService.getByCode(code)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<University> createUniversity(
            @RequestBody University req,
            @RequestHeader(value = "X-User-Role", required = false) String userRole) {
        validateSuperAdminRole(userRole);
        University created = universityService.createUniversity(req);
        return ResponseEntity.ok(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<University> updateUniversity(
            @PathVariable Long id,
            @RequestBody University req,
            @RequestHeader(value = "X-User-Role", required = false) String userRole) {
        validateSuperAdminRole(userRole);
        University updated = universityService.updateUniversity(id, req);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUniversity(
            @PathVariable Long id,
            @RequestParam(required = false, defaultValue = "false") boolean hard,
            @RequestHeader(value = "X-User-Role", required = false) String userRole,
            @RequestHeader(value = "X-User-Email", required = false) String userEmail,
            @RequestHeader(value = "X-User-Name", required = false) String userName,
            @RequestHeader(value = "X-Correlation-Id", required = false) String correlationId) {

        validateSuperAdminRole(userRole);

        universityService.deleteUniversity(id, hard, userRole, userEmail, userName, correlationId);
        return ResponseEntity.noContent().build(); // 204 No Content
    }

    @GetMapping("/{id}/audit-logs")
    public ResponseEntity<List<UniversityAuditLog>> getAuditLogs(@PathVariable Long id) {
        return ResponseEntity.ok(universityService.getAuditLogsForUniversity(id));
    }
}
