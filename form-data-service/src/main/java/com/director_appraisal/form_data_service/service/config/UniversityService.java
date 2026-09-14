package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.model.config.*;
import com.director_appraisal.form_data_service.repository.config.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UniversityService {

    private final UniversityRepository universityRepository;
    private final DefaultSchemaTemplateService defaultSchemaTemplateService;
    private final UniversitySchoolRepository universitySchoolRepository;
    private final UniversityPostRepository universityPostRepository;
    private final FormSchemaRepository formSchemaRepository;
    private final FormConfigService formConfigService;
    private final UniversityAuditLogRepository auditLogRepository;

    @Value("${app.services.submission-url:http://localhost:9003}")
    private String submissionServiceUrl;

    @Value("${app.services.auth-url:http://localhost:9001}")
    private String authServiceUrl;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Transactional(readOnly = true)
    public List<University> getAllUniversities(boolean includeArchived) {
        if (includeArchived) {
            return universityRepository.findAll();
        }
        return universityRepository.findAllActive();
    }

    @Transactional(readOnly = true)
    public List<University> getAllUniversities() {
        return getAllUniversities(false);
    }

    @Transactional(readOnly = true)
    public Optional<University> getById(Long id) {
        return universityRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public Optional<University> getByCode(String code) {
        if (code == null || code.isBlank()) return Optional.empty();
        return universityRepository.findByCodeIgnoreCase(code.trim());
    }

    @Transactional
    public University createUniversity(University university) {
        if (university.getCode() == null || university.getCode().isBlank()) {
            throw new IllegalArgumentException("University code is required.");
        }
        String cleanCode = university.getCode().trim().toLowerCase();
        if (universityRepository.existsByCodeIgnoreCase(cleanCode)) {
            throw new IllegalArgumentException("University code '" + cleanCode + "' already exists.");
        }
        university.setCode(cleanCode);
        return universityRepository.save(university);
    }

    @Transactional
    public University updateUniversity(Long id, University req) {
        University existing = universityRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("University not found with ID: " + id));

        if (req.getName() != null && !req.getName().isBlank()) {
            existing.setName(req.getName());
        }
        if (req.getDomain() != null) {
            existing.setDomain(req.getDomain());
        }
        if (req.getAddress() != null) {
            existing.setAddress(req.getAddress());
        }
        if (req.getEstablishmentAct() != null) {
            existing.setEstablishmentAct(req.getEstablishmentAct());
        }
        if (req.getLogoUrl() != null) {
            existing.setLogoUrl(req.getLogoUrl());
        }
        if (req.getIqacLogoUrl() != null) {
            existing.setIqacLogoUrl(req.getIqacLogoUrl());
        }
        if (req.getPrimaryColor() != null) {
            existing.setPrimaryColor(req.getPrimaryColor());
        }
        if (req.getThemeBranding() != null) {
            existing.setThemeBranding(req.getThemeBranding());
        }
        if (req.getStatus() != null) {
            existing.setStatus(req.getStatus());
        }

        return universityRepository.save(existing);
    }

    /**
     * Delete or Archive a University with full tenant cascading and audit trail.
     *
     * @param id University ID
     * @param hardDelete When true, attempts permanent deletion (fails with 409 if historical submissions exist)
     * @param performedByRole Initiator role
     * @param performedByEmail Initiator email
     * @param performedByName Initiator display name
     * @param correlationId Request correlation ID
     */
    @Transactional
    public void deleteUniversity(
            Long id,
            boolean hardDelete,
            String performedByRole,
            String performedByEmail,
            String performedByName,
            String correlationId) {

        University university = universityRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("University not found with ID: " + id));

        String uniCode = university.getCode();
        String uniName = university.getName();

        if (hardDelete) {
            // 1. Check if submission-service has dependent historical submissions
            int submissionCount = checkDependentSubmissionsCount(id, uniCode);
            if (submissionCount > 0) {
                log.warn("[CONFLICT] Cannot hard delete university id={} code='{}': {} dependent submissions exist",
                        id, uniCode, submissionCount);
                throw new ResponseStatusException(HttpStatus.CONFLICT,
                        "Cannot hard-delete university '" + uniName + "' (" + uniCode + ") because " + submissionCount +
                        " dependent appraisal submission(s) exist. Appraisal submissions are immutable historical records. Please use soft-delete (archive) instead.");
            }

            // 2. Cascade hard-delete within form-data-service
            log.info("Cascading hard-delete for university '{}' (ID: {})", uniCode, id);
            formConfigService.deleteAllSchemasForUniversity(id);
            universitySchoolRepository.deleteByUniversityId(id);
            universityPostRepository.deleteByUniversityId(id);
            universityRepository.delete(university);

            // 3. Cascade delete users in auth-user-service
            notifyAuthServiceUserDeletion(id, true);

            // 4. Record audit log
            auditLogRepository.save(UniversityAuditLog.builder()
                    .universityId(id)
                    .universityCode(uniCode)
                    .universityName(uniName)
                    .action("HARD_DELETE")
                    .performedByEmail(performedByEmail != null ? performedByEmail : "system")
                    .performedByName(performedByName != null ? performedByName : "Platform Administrator")
                    .performedByRole(performedByRole != null ? performedByRole : "super_admin")
                    .correlationId(correlationId)
                    .details("Permanently deleted university and cascaded hard-deletion through schemas, schools, posts, and tenant users.")
                    .build());

            log.warn("[AUDIT] [UNIVERSITY_HARD_DELETED] id={} code='{}' name='{}' byEmail='{}' byRole='{}' corrId='{}'",
                    id, uniCode, uniName, performedByEmail, performedByRole, correlationId);

        } else {
            // Soft delete / Archive (Default & Recommended)
            log.info("Archiving university '{}' (ID: {})", uniCode, id);
            university.setStatus("ARCHIVED");
            universityRepository.save(university);

            // Cascade archive within form-data-service
            List<UniversitySchool> schools = universitySchoolRepository.findByUniversityIdOrderByDisplayOrderAscIdAsc(id);
            for (UniversitySchool s : schools) {
                s.setStatus("ARCHIVED");
                universitySchoolRepository.save(s);
            }

            List<UniversityPost> posts = universityPostRepository.findByUniversityIdOrderByDisplayOrderAscNameAsc(id);
            for (UniversityPost p : posts) {
                p.setStatus("ARCHIVED");
                universityPostRepository.save(p);
            }

            List<FormSchema> schemas = formSchemaRepository.findByUniversityId(id);
            for (FormSchema s : schemas) {
                s.setStatus("ARCHIVED");
                formSchemaRepository.save(s);
            }

            // Cascade archive/deactivate users in auth-user-service
            notifyAuthServiceUserDeletion(id, false);

            // Record audit log
            auditLogRepository.save(UniversityAuditLog.builder()
                    .universityId(id)
                    .universityCode(uniCode)
                    .universityName(uniName)
                    .action("ARCHIVED")
                    .performedByEmail(performedByEmail != null ? performedByEmail : "system")
                    .performedByName(performedByName != null ? performedByName : "Platform Administrator")
                    .performedByRole(performedByRole != null ? performedByRole : "super_admin")
                    .correlationId(correlationId)
                    .details("Archived university, deactivated schools, posts, schemas, and tenant users. Historical appraisal records preserved.")
                    .build());

            log.warn("[AUDIT] [UNIVERSITY_ARCHIVED] id={} code='{}' name='{}' byEmail='{}' byRole='{}' corrId='{}'",
                    id, uniCode, uniName, performedByEmail, performedByRole, correlationId);
        }
    }

    @Transactional(readOnly = true)
    public List<UniversityAuditLog> getAuditLogsForUniversity(Long universityId) {
        return auditLogRepository.findByUniversityIdOrderByTimestampDesc(universityId);
    }

    private int checkDependentSubmissionsCount(Long universityId, String universityCode) {
        try {
            String baseUrl = (submissionServiceUrl != null && !submissionServiceUrl.isBlank())
                    ? submissionServiceUrl.trim()
                    : "http://localhost:9003";
            URI uri = URI.create(baseUrl + "/api/submissions/university/" + universityId + "/count");
            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(2))
                    .build();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .timeout(Duration.ofSeconds(3))
                    .GET()
                    .build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() == 200 && response.body() != null) {
                JsonNode root = objectMapper.readTree(response.body());
                return root.path("count").asInt(0);
            }
        } catch (Exception e) {
            log.warn("Could not query submission-service for dependent submissions of universityId={}: {}", universityId, e.getMessage());
        }
        return 0;
    }

    private void notifyAuthServiceUserDeletion(Long universityId, boolean hardDelete) {
        try {
            String baseUrl = (authServiceUrl != null && !authServiceUrl.isBlank())
                    ? authServiceUrl.trim()
                    : "http://localhost:9001";
            URI uri = URI.create(baseUrl + "/api/users/university/" + universityId + "?hard=" + hardDelete);
            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(2))
                    .build();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(uri)
                    .timeout(Duration.ofSeconds(3))
                    .DELETE()
                    .build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            log.info("Notified auth-user-service of university {} deletion (hard={}): status={}", universityId, hardDelete, response.statusCode());
        } catch (Exception e) {
            log.warn("Could not notify auth-user-service of university {} deletion: {}", universityId, e.getMessage());
        }
    }
}
