package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.dto.UserDto;
import com.director_appraisal.submission_service.client.AuthUserClient;
import com.director_appraisal.submission_service.service.SubmissionService;

import com.director_appraisal.submission_service.model.SubmissionAuditorAssignment;
import com.director_appraisal.submission_service.repository.SubmissionAuditorAssignmentRepository;
import com.director_appraisal.submission_service.service.ReportExportService;
import com.director_appraisal.submission_service.util.SchoolUtils;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Stream;

@Slf4j
@RestController
@RequestMapping("/api/submissions")
@RequiredArgsConstructor
@CrossOrigin
public class SubmissionController {


    private final SubmissionService submissionService;
    private final AuthUserClient authUserClient;
    private final SubmissionAuditorAssignmentRepository submissionAuditorAssignmentRepository;
    private final ReportExportService reportExportService;
    private final jakarta.servlet.http.HttpServletRequest httpRequest;

    @Value("${app.upload.local-path:./uploads}")
    private String uploadLocalPath;

    @Value("${app.storage-service-url:${STORAGE_SERVICE_URL:http://storage-service:9004}}")
    private String storageServiceUrl;

    @Value("${app.public-base-url:${PUBLIC_BASE_URL:}}")
    private String configuredPublicBaseUrl;

    private String getCurrentUserEmail() {
        if (httpRequest != null) {
            String headerEmail = httpRequest.getHeader("X-User-Email");
            if (headerEmail != null && !headerEmail.isBlank()) {
                return headerEmail.trim().toLowerCase();
            }
            String authHeader = httpRequest.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                try {
                    String token = authHeader.substring(7).trim();
                    int firstDot = token.indexOf('.');
                    int secondDot = token.indexOf('.', firstDot + 1);
                    if (firstDot > 0 && secondDot > firstDot) {
                        String payload = new String(java.util.Base64.getUrlDecoder().decode(token.substring(firstDot + 1, secondDot)), java.nio.charset.StandardCharsets.UTF_8);
                        com.fasterxml.jackson.databind.JsonNode jsonNode = new com.fasterxml.jackson.databind.ObjectMapper().readTree(payload);
                        if (jsonNode.has("sub")) {
                            return jsonNode.get("sub").asText().trim().toLowerCase();
                        }
                    }
                } catch (Exception ignored) {}
            }
        }
        return "iqac@dypiu.ac.in";
    }

    private UserDto safeGetUserByEmail(String email) {
        if (email == null || email.isBlank()) return null;
        try {
            return authUserClient.getUserByEmail(email.trim());
        } catch (Exception ignored) {
            return null;
        }
    }

    private UserDto getCurrentUserDetails() {
        String email = getCurrentUserEmail();
        String roleFromContext = null;
        String schoolFromContext = null;
        String nameFromContext = null;
        String postFromContext = null;
        String categoryFromContext = null;

        if (httpRequest != null) {
            String headerRole = httpRequest.getHeader("X-User-Role");
            if (headerRole != null && !headerRole.isBlank()) roleFromContext = headerRole.trim();
            String headerSchool = httpRequest.getHeader("X-User-School");
            if (headerSchool != null && !headerSchool.isBlank()) schoolFromContext = headerSchool.trim();
            String headerName = httpRequest.getHeader("X-User-Name");
            if (headerName != null && !headerName.isBlank()) nameFromContext = headerName.trim();

            String authHeader = httpRequest.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                try {
                    String token = authHeader.substring(7).trim();
                    int firstDot = token.indexOf('.');
                    int secondDot = token.indexOf('.', firstDot + 1);
                    if (firstDot > 0 && secondDot > firstDot) {
                        String payload = new String(java.util.Base64.getUrlDecoder().decode(token.substring(firstDot + 1, secondDot)), java.nio.charset.StandardCharsets.UTF_8);
                        com.fasterxml.jackson.databind.JsonNode jsonNode = new com.fasterxml.jackson.databind.ObjectMapper().readTree(payload);
                        if (jsonNode.has("role") && (roleFromContext == null || roleFromContext.isBlank())) {
                            roleFromContext = jsonNode.get("role").asText();
                        }
                        if (jsonNode.has("school") && (schoolFromContext == null || schoolFromContext.isBlank())) {
                            schoolFromContext = jsonNode.get("school").asText();
                        }
                        if (jsonNode.has("name") && (nameFromContext == null || nameFromContext.isBlank())) {
                            nameFromContext = jsonNode.get("name").asText();
                        }
                        if (jsonNode.has("post") && (postFromContext == null || postFromContext.isBlank())) {
                            postFromContext = jsonNode.get("post").asText();
                        }
                        if (jsonNode.has("category") && (categoryFromContext == null || categoryFromContext.isBlank())) {
                            categoryFromContext = jsonNode.get("category").asText();
                        }
                    }
                } catch (Exception ignored) {}
            }
        }

        if (email != null && !email.isBlank()) {
            UserDto u = safeGetUserByEmail(email);
            if (u != null) {
                if ((u.getRole() == null || u.getRole().isBlank()) && roleFromContext != null) {
                    u.setRole(roleFromContext);
                }
                if ((u.getSchool() == null || u.getSchool().isBlank()) && schoolFromContext != null) {
                    u.setSchool(schoolFromContext);
                }
                if ((u.getName() == null || u.getName().isBlank()) && nameFromContext != null) {
                    u.setName(nameFromContext);
                }
                if ((u.getPost() == null || u.getPost().isBlank()) && postFromContext != null) {
                    u.setPost(postFromContext);
                }
                if ((u.getCategory() == null || u.getCategory().isBlank()) && categoryFromContext != null) {
                    u.setCategory(categoryFromContext);
                }
                return u;
            }
        }

        return UserDto.builder()
                .email(email)
                .name(nameFromContext != null ? nameFromContext : "User")
                .role(roleFromContext != null ? roleFromContext : "director")
                .school(schoolFromContext)
                .post(postFromContext)
                .category(categoryFromContext)
                .build();
    }




    @GetMapping("/my-draft")
    public ResponseEntity<?> getMyDraft(
            @RequestParam(required = false) String auditType,
            @RequestParam(required = false) String academicYear,
            @RequestParam(required = false) String auditCycle,
            @RequestParam(required = false) String cycleId,
            @RequestParam(required = false, defaultValue = "false") boolean includeSubmitted,
            @RequestParam(required = false, defaultValue = "false") boolean includeApproved,
            @RequestParam(required = false, defaultValue = "false") boolean includeHistorical,
            @RequestParam(required = false, defaultValue = "false") boolean shared) {
        try {
            UserDto user = getCurrentUserDetails();
            String normalizedAuditType = resolveAuditTypeForCaller(user, auditType);
            String requestedYear = firstNonBlank(academicYear, auditCycle, cycleId);

            boolean includeNonDrafts = includeSubmitted || includeApproved || includeHistorical;

            log.info("getMyDraft: email={}, role={}, post={}, auditType={}, requestedYear={}, shared={}",
                    user.getEmail(), user.getRole(), user.getPost(), normalizedAuditType, requestedYear, shared);

            Submission draft = submissionService.getDraftForUser(
                    user,
                    normalizedAuditType,
                    requestedYear,
                    includeNonDrafts,
                    shared
            );
            if (draft != null) {
                submissionService.populatePermissions(draft, user);
            }
            return ResponseEntity.ok(draft);
        } catch (Exception e) {
            log.error("Error in getMyDraft: {}", e.getMessage(), e);
            throw e;
        }
    }


    private String firstNonBlank(String... values) {
        if (values == null) return null;
        for (String v : values) {
            if (v != null && !v.isBlank() && !"null".equalsIgnoreCase(v.trim()) && !"undefined".equalsIgnoreCase(v.trim())) {
                return v.trim();
            }
        }
        return null;
    }

    @GetMapping("/administrative/{cycleId}/status")
    public ResponseEntity<Object> getAdministrativeStatus(@PathVariable String cycleId) {
        Submission submission = submissionService.getOrCreateSharedAdministrativeDraftForCycle(cycleId);
        return ResponseEntity.ok(submission.getSubmittedByForJson());
    }

    @PostMapping("/administrative/{cycleId}/submit")
    public ResponseEntity<Submission> submitAdministrativePart(@PathVariable String cycleId) {
        UserDto caller = getCurrentUserDetails();
        Submission submitted = submissionService.submitAdministrativePart(cycleId, caller);
        return ResponseEntity.ok(submitted);
    }

    private String resolveAuditTypeForCaller(UserDto user, String requestAuditType) {
        if (requestAuditType != null && !requestAuditType.isBlank() && !"null".equalsIgnoreCase(requestAuditType.trim()) && !"undefined".equalsIgnoreCase(requestAuditType.trim())) {
            return requestAuditType.trim().toLowerCase();
        }
        if (user != null) {
            String role = user.getRole() != null ? user.getRole().trim().toLowerCase() : "";
            if ("director".equals(role)) {
                return "academic";
            }
            if ("administrative".equals(role)) {
                return "administrative";
            }
            if (user.getCategory() != null && !user.getCategory().isBlank()) {
                return user.getCategory().trim().toLowerCase();
            }
        }
        return "academic";
    }

    private void validateAuditTypeForRole(String role, String auditType) {
        if (role == null || auditType == null) {
            return;
        }
        String roleLower = role.trim().toLowerCase();
        String typeLower = auditType.trim().toLowerCase();
        
        if (roleLower.contains("auditor")) {
            if (roleLower.contains("academic") && !"academic".equals(typeLower)) {
                throw new IllegalArgumentException("Academic auditors can only audit academic forms");
            }
            if (roleLower.contains("administrative") && !"administrative".equals(typeLower)) {
                throw new IllegalArgumentException("Administrative auditors can only audit administrative forms");
            }
            return;
        }
        
        if ("director".equals(roleLower) && !"academic".equals(typeLower)) {
            throw new IllegalArgumentException("Academic Directors can only submit academic audits");
        }
        if ("administrative".equals(roleLower) && !"administrative".equals(typeLower)) {
            throw new IllegalArgumentException("Administrative users can only submit administrative audits");
        }
        if (List.of("vice-chancellor", "iqac").contains(roleLower)) {
            throw new IllegalArgumentException("Reviewers (VC & IQAC) cannot create or submit audits");
        }
    }

    @PostMapping("/save-draft")
    public ResponseEntity<Submission> saveDraft(@RequestBody(required = false) FormSubmissionRequest request) {
        String email = getCurrentUserEmail();
        UserDto user = getCurrentUserDetails();
        String auditType = resolveAuditTypeForCaller(user, request != null ? request.getAuditType() : null);
        validateAuditTypeForRole(user.getRole(), auditType);
        if ("administrative".equalsIgnoreCase(auditType)) {
            return ResponseEntity.ok(submissionService.saveSharedAdministrativeContribution(user, request != null ? request.getContributorPost() : null,
                    request != null ? request.getSections() : null, request != null ? request.getValuesData() : null, request != null ? request.getTablesData() : null, request != null ? request.getAttachments() : null, false));
        }
        Submission saved = submissionService.saveDraft(
                email,
                auditType,
                user.getSchool(),
                user.getName(),
                request != null ? request.getValuesData() : null,
                request != null ? request.getTablesData() : null,
                request != null ? request.getAttachments() : null
        );
        return ResponseEntity.ok(saved);
    }

    @PostMapping("/submit")
    public ResponseEntity<Submission> submitForm(@RequestBody(required = false) FormSubmissionRequest request) {
        String email = getCurrentUserEmail();
        UserDto user = getCurrentUserDetails();
        String auditType = resolveAuditTypeForCaller(user, request != null ? request.getAuditType() : null);
        validateAuditTypeForRole(user.getRole(), auditType);
        if ("administrative".equalsIgnoreCase(auditType)) {
            return ResponseEntity.ok(submissionService.saveSharedAdministrativeContribution(user, request != null ? request.getContributorPost() : null,
                    request != null ? request.getSections() : null, request != null ? request.getValuesData() : null, request != null ? request.getTablesData() : null, request != null ? request.getAttachments() : null, true));
        }
        Submission submitted = submissionService.submitForm(
                email,
                auditType,
                user.getSchool(),
                user.getName(),
                request != null ? request.getValuesData() : null,
                request != null ? request.getTablesData() : null,
                request != null ? request.getAttachments() : null
        );
        return ResponseEntity.ok(submitted);
    }

    @PutMapping("/save-draft")
    public ResponseEntity<Submission> updateDraft(@RequestBody(required = false) FormSubmissionRequest request) {
        return saveDraft(request);
    }

    @PutMapping("/submit")
    public ResponseEntity<Submission> updateAndSubmitForm(@RequestBody(required = false) FormSubmissionRequest request) {
        return submitForm(request);
    }


    @PutMapping("/{id}")
    public ResponseEntity<Submission> updateSubmission(@PathVariable Long id, @RequestBody FormSubmissionRequest request) {
        UserDto user = getCurrentUserDetails();
        if (request.getAuditType() != null && !List.of("vice-chancellor", "iqac").contains(user.getRole().toLowerCase())) {
            validateAuditTypeForRole(user.getRole(), request.getAuditType());
        }
        if ("administrative".equalsIgnoreCase(request.getAuditType()) && !List.of("vice-chancellor", "iqac").contains(user.getRole().toLowerCase()) && !user.getRole().toLowerCase().contains("auditor")) {
            Submission updated = submissionService.updateSharedAdministrativeContribution(
                    id,
                    user,
                    request.getAction(),
                    request.getContributorPost(),
                    request.getSections(),
                    request.getValuesData(),
                    request.getTablesData(),
                    request.getAttachments()
            );
            return ResponseEntity.ok(updated);
        }
        List<String> selectedKeys = request.getCorrectionAssignmentKeys();
        if (selectedKeys == null || selectedKeys.isEmpty()) {
            selectedKeys = request.getAuditorAssignmentKeys();
        }
        if (selectedKeys == null || selectedKeys.isEmpty()) {
            selectedKeys = request.getAssignmentKeys();
        }
        if (selectedKeys == null || selectedKeys.isEmpty()) {
            selectedKeys = request.getReturnedAuditorAssignmentKeys();
        }

        log.info("PUT /api/submissions/{} called by {}: status={}, forwardedAuditorType={}, effectiveIds={}, effectiveEmails={}",
                id, user.getEmail(), request.getStatus(), request.getEffectiveAuditorType(), request.getEffectiveAuditorIds(), request.getEffectiveAuditorEmails());

        Submission updated = submissionService.updateSubmission(
                id,
                user,
                request.getStatus(),
                request.getEffectiveAuditorType(),
                request.getEffectiveAuditCategory(),
                request.getEffectiveAuditorIds(),
                request.getEffectiveAuditorNames(),
                request.getEffectiveAuditorEmails(),
                request.getValuesData(),
                request.getTablesData(),
                request.getAttachments(),
                request.getForwardedAdministrativePosts(),
                request.getForwardedToAuditorPosts(),
                request.getAuditorCorrectionRequested(),
                request.getCorrectionRequestedForAuditor(),
                request.getRequiresAuditorResubmission(),
                request.getAuditorCorrectionMessage(),
                request.getAuditorCorrectionRequestedBy(),
                request.getAuditorCorrectionRequestedByRole(),
                request.getAuditorCorrectionRequestedOn(),
                request.getAuditorResubmittedAt(),
                request.getRemarks(),
                selectedKeys
        );
        return ResponseEntity.ok(updated);
    }


    @PostMapping("/{id}/auditor-submit")
public ResponseEntity<?> submitAuditorReview(@PathVariable Long id, @RequestBody AuditorSubmitRequest request) {
        UserDto user = getCurrentUserDetails();
        Object response = submissionService.submitAuditorReview(id, user, request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/all")
public ResponseEntity<List<Submission>> getAllSubmissions(
            @RequestParam(required = false) String academicYear,
            @RequestParam(required = false) String auditCycle,
            @RequestParam(required = false) String cycleId) {
        UserDto user = getCurrentUserDetails();
        String requestedYear = firstNonBlank(academicYear, auditCycle, cycleId);
        List<Submission> submissions = submissionService.getAllSubmissionsForUser(user, requestedYear);
        submissions.forEach(sub -> submissionService.populatePermissions(sub, user));
        return ResponseEntity.ok(submissions);
    }

    @GetMapping("/previous-reports")
public ResponseEntity<List<Submission>> getPreviousReports(@RequestParam(required = false) String academicYear) {
        return ResponseEntity.ok(submissionService.getPreviousReports(getCurrentUserDetails(), academicYear));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Submission> getSubmissionById(@PathVariable Long id) {
        String email = getCurrentUserEmail();
        UserDto user = getCurrentUserDetails();
        Submission submission = submissionService.getSubmissionById(id)
                .orElseThrow(() -> new IllegalArgumentException("Submission not found with ID: " + id));

        if (!"APPROVED".equalsIgnoreCase(submission.getStatus()) && !"FINAL".equalsIgnoreCase(submission.getStatus())) {
            if (submission.getEmail() != null) {
                java.util.Optional<UserDto> submitter = java.util.Optional.ofNullable(safeGetUserByEmail(submission.getEmail().trim().toLowerCase()));
                if (submitter.isPresent() && Boolean.TRUE.equals(submitter.get().getDeleted())) {

                    String currentYear = submissionService.getCurrentAcademicYearLabel();
                    if (submissionService.isSameAcademicYear(currentYear, submission.getAcademicYear()) || submissionService.isSameAcademicYear(currentYear, submission.getAuditCycle())) {
                        throw new IllegalArgumentException("Submission not found with ID: " + id);
                    }
                }
            }
        }

        boolean isOwner = submission.getEmail().equalsIgnoreCase(email);
        boolean isIqac = "iqac".equalsIgnoreCase(user.getRole());
        boolean isVc = "vice-chancellor".equalsIgnoreCase(user.getRole());
        boolean isAuditor = user.getRole().toLowerCase().contains("auditor") || "auditor".equalsIgnoreCase(user.getAccountType());
        boolean isAdministrativeContributor = "administrative".equalsIgnoreCase(user.getRole())
                && "administrative".equalsIgnoreCase(submission.getAuditType());
        
        boolean isAssignedAuditor = isAuditor && (submissionService.isAuditorAssigned(user, submission) || submissionService.isAuditorFallbackMatch(user, submission));

        if (isVc) {
            boolean statusAllowed = List.of("AUDITOR_COMPLETED", "APPROVED", "FINAL").contains(submission.getStatus().toUpperCase());
            if (!statusAllowed) {
                return ResponseEntity.status(403).build();
            }
        }

        if (!isOwner && !isIqac && !isVc && !isAssignedAuditor && !isAdministrativeContributor) {
            return ResponseEntity.status(403).build();
        }

        submissionService.populatePermissions(submission, user);
        return ResponseEntity.ok(submission);
    }

    @PostMapping("/{id}/review")
public ResponseEntity<Submission> reviewSubmission(
            @PathVariable Long id,
            @RequestBody ReviewRequest request) {
        UserDto reviewer = getCurrentUserDetails();
        Submission updated = submissionService.reviewSubmission(
                id,
                request.getStatus(),
                request.getRemarks(),
                request.getReportCategory(),
                request.getAuditCycle(),
                request.getVersion(),
                request.getValuesData(),
                request.getTablesData(),
                request.getAttachments(),
                reviewer
        );
        return ResponseEntity.ok(updated);
    }

    @PostMapping("/{id}/next-cycle")
public ResponseEntity<Submission> createNextCycle(
            @PathVariable Long id,
            @RequestBody NextCycleRequest request) {
        UserDto caller = getCurrentUserDetails();
        Submission nextSubmission = submissionService.createNextCycle(
                id,
                caller,
                request.isPreserveApprovedVersion(),
                request.getPreviousApprovedSubmissionId(),
                request.getNextVersion(),
                request.getNextAuditorType()
        );
        return ResponseEntity.ok(nextSubmission);
    }

    @GetMapping("/{id}/snapshots")
    public ResponseEntity<Map<String, Object>> getSnapshots(@PathVariable Long id) {
        String email = getCurrentUserEmail();
        UserDto user = getCurrentUserDetails();
        Submission submission = submissionService.getSubmissionById(id)
                .orElseThrow(() -> new IllegalArgumentException("Submission not found with ID: " + id));

        boolean isOwner = submission.getEmail().equalsIgnoreCase(email);
        boolean isIqac = "iqac".equalsIgnoreCase(user.getRole());
        boolean isVc = "vice-chancellor".equalsIgnoreCase(user.getRole());
        boolean isAuditor = user.getRole().toLowerCase().contains("auditor") || "auditor".equalsIgnoreCase(user.getAccountType());
        boolean isAdministrativeContributor = "administrative".equalsIgnoreCase(user.getRole())
                && "administrative".equalsIgnoreCase(submission.getAuditType());
        
        boolean isAssignedAuditor = isAuditor && (submissionService.isAuditorAssigned(user, submission) || submissionService.isAuditorFallbackMatch(user, submission));

        if (!isOwner && !isIqac && !isVc && !isAssignedAuditor && !isAdministrativeContributor) {
            return ResponseEntity.status(403).build();
        }

        return ResponseEntity.ok(Map.of("data", submissionService.getVersionHistoryForSubmission(id)));
    }

    @Data
    @com.fasterxml.jackson.annotation.JsonIgnoreProperties(ignoreUnknown = true)
    public static class FormSubmissionRequest {
        private String auditType;
        private String academicYear;
        private String auditCycle;
        private String cycleId;
        private String valuesData;
        private String tablesData;
        private String attachments;
        private String status;
        private boolean sharedAdministrativeForm;
        private String action;
        private String contributorPost;
        private List<String> sections;
        private String forwardedAuditorType;
        private String auditorType;
        private String forwardedAuditCategory;
        private String auditCategory;
        private List<Long> forwardedToAuditorIds;
        private List<Long> auditorIds;
        private Long forwardedToAuditorId;
        private Long auditorId;
        private List<String> forwardedToAuditorNames;
        private List<String> auditorNames;
        private String forwardedToAuditorName;
        private String auditorName;
        private List<String> forwardedToAuditorEmails;
        private List<String> auditorEmails;
        private String forwardedToAuditorEmail;
        private String auditorEmail;
        private List<String> forwardedAdministrativePosts;
        private List<String> forwardedToAuditorPosts;
        private List<String> assignmentKeys;
        private List<String> auditorAssignmentKeys;
        private List<String> correctionAssignmentKeys;
        private List<String> returnedAuditorAssignmentKeys;
        private Boolean auditorCorrectionRequested;
        private Boolean correctionRequestedForAuditor;
        private Boolean requiresAuditorResubmission;
        private String auditorCorrectionMessage;
        private String auditorCorrectionRequestedBy;
        private String auditorCorrectionRequestedByRole;
        private String auditorCorrectionRequestedOn;
        private String auditorResubmittedAt;
        private String remarks;

        public List<Long> getEffectiveAuditorIds() {
            List<Long> ids = new java.util.ArrayList<>();
            if (forwardedToAuditorIds != null) ids.addAll(forwardedToAuditorIds);
            if (auditorIds != null) ids.addAll(auditorIds);
            if (forwardedToAuditorId != null) ids.add(forwardedToAuditorId);
            if (auditorId != null) ids.add(auditorId);
            return ids.stream().filter(java.util.Objects::nonNull).distinct().toList();
        }

        public List<String> getEffectiveAuditorEmails() {
            List<String> emails = new java.util.ArrayList<>();
            if (forwardedToAuditorEmails != null) emails.addAll(forwardedToAuditorEmails);
            if (auditorEmails != null) emails.addAll(auditorEmails);
            if (forwardedToAuditorEmail != null && !forwardedToAuditorEmail.isBlank()) emails.add(forwardedToAuditorEmail);
            if (auditorEmail != null && !auditorEmail.isBlank()) emails.add(auditorEmail);
            return emails.stream().filter(s -> s != null && !s.isBlank()).distinct().toList();
        }

        public List<String> getEffectiveAuditorNames() {
            List<String> names = new java.util.ArrayList<>();
            if (forwardedToAuditorNames != null) names.addAll(forwardedToAuditorNames);
            if (auditorNames != null) names.addAll(auditorNames);
            if (forwardedToAuditorName != null && !forwardedToAuditorName.isBlank()) names.add(forwardedToAuditorName);
            if (auditorName != null && !auditorName.isBlank()) names.add(auditorName);
            return names.stream().filter(s -> s != null && !s.isBlank()).distinct().toList();
        }

        public String getEffectiveAuditorType() {
            if (forwardedAuditorType != null && !forwardedAuditorType.isBlank()) return forwardedAuditorType.trim();
            if (auditorType != null && !auditorType.isBlank()) return auditorType.trim();
            return "internal";
        }

        public String getEffectiveAuditCategory() {
            if (forwardedAuditCategory != null && !forwardedAuditCategory.isBlank()) return forwardedAuditCategory.trim();
            if (auditCategory != null && !auditCategory.isBlank()) return auditCategory.trim();
            if (auditType != null && !auditType.isBlank()) return auditType.trim();
            return "academic";
        }
    }


    @Data
    public static class ReviewRequest {
        private String status; // APPROVED/FINAL, UNDER_REVIEW
        private String remarks;
        private String reportCategory;
        private String auditCycle;
        private Integer version;
        private String valuesData;
        private String tablesData;
        private String attachments;
    }

    @Data
    public static class NextCycleRequest {
        private boolean preserveApprovedVersion = true;
        private Long previousApprovedSubmissionId;
        private Integer nextVersion;
        private String nextAuditorType;
    }

    public void downloadAttachments(@PathVariable Long id, jakarta.servlet.http.HttpServletResponse response) throws java.io.IOException {
        downloadAttachments(id, false, response);
    }

    @GetMapping("/{id}/attachments/download")
    public void downloadAttachments(@PathVariable Long id,
                                    @RequestParam(required = false, defaultValue = "false") boolean includeAllContributors,
                                    jakarta.servlet.http.HttpServletResponse response) throws java.io.IOException {
        UserDto user = getCurrentUserDetails();
        Submission submission = submissionService.getSubmissionById(id)
                .orElseThrow(() -> new com.director_appraisal.submission_service.exception.NotFoundException("Submission not found with ID: " + id));

        boolean isIqac = "iqac".equalsIgnoreCase(user.getRole());
        boolean isVc = "vice-chancellor".equalsIgnoreCase(user.getRole());
        if (!isIqac && !isVc) {
            throw new SecurityException("Only IQAC or VC may download attachments");
        }

        String subStatus = submission.getStatus() != null ? submission.getStatus().toUpperCase() : "SUBMITTED";
        if (isVc) {
            boolean statusAllowed = List.of(
                    "SUBMITTED", "UNDER_REVIEW", "FORWARDED_TO_INTERNAL_AUDITOR", "INTERNAL_AUDITOR_COMPLETED",
                    "FORWARDED_TO_EXTERNAL_AUDITOR", "AUDITOR_COMPLETED", "EXTERNAL_AUDITOR_COMPLETED",
                    "APPROVED", "FINAL"
            ).contains(subStatus);
            if (!statusAllowed) {
                throw new SecurityException("Unauthorized access to submission in status: " + subStatus);
            }
        }

        // Collect all attachments belonging strictly to this submission
        List<ExtractedAttachment> attachments = new java.util.ArrayList<>();
        com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();

        try {
            if (submission.getAttachments() != null && !submission.getAttachments().isBlank()) {
                collectAttachments(mapper.readTree(submission.getAttachments()), attachments, "General");
            }
            String defaultContext = null;
            if ("administrative".equalsIgnoreCase(submission.getAuditType())
                    && submission.getAdministrativePost() != null
                    && !submission.getAdministrativePost().isBlank()) {
                defaultContext = formatAdministrativePost(submission.getAdministrativePost());
            }

            if (submission.getTablesData() != null && !submission.getTablesData().isBlank()) {
                collectAttachments(mapper.readTree(submission.getTablesData()), attachments, defaultContext);
            }
            if (submission.getValuesData() != null && !submission.getValuesData().isBlank()) {
                collectAttachments(mapper.readTree(submission.getValuesData()), attachments, defaultContext);
            }
            if (submissionAuditorAssignmentRepository != null) {
                List<SubmissionAuditorAssignment> assignments =
                        submissionAuditorAssignmentRepository.findBySubmissionId(submission.getId());
                if (assignments != null) {
                    for (SubmissionAuditorAssignment assignment : assignments) {
                        String audType = assignment.getAuditorType() != null && !assignment.getAuditorType().isBlank()
                                ? assignment.getAuditorType().trim()
                                : "Review";
                        String audSec = "Auditor-" + capitalizeWord(audType);
                        if (assignment.getPost() != null && !assignment.getPost().isBlank() && !"academic".equalsIgnoreCase(assignment.getCategory())) {
                            audSec = audSec + "/" + formatAdministrativePost(assignment.getPost());
                        }
                        if (assignment.getAttachments() != null && !assignment.getAttachments().isBlank()) {
                            collectAttachments(mapper.readTree(assignment.getAttachments()), attachments, audSec);
                        }
                        if (assignment.getTablesData() != null && !assignment.getTablesData().isBlank()) {
                            collectAttachments(mapper.readTree(assignment.getTablesData()), attachments, audSec);
                        }
                        if (assignment.getValuesData() != null && !assignment.getValuesData().isBlank()) {
                            collectAttachments(mapper.readTree(assignment.getValuesData()), attachments, audSec);
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.warn("Error collecting attachments for submission {}: {}", id, e.getMessage());
        }

        attachments = deduplicateAttachments(attachments, submission.getAuditType());

        String zipFileName = getZipFileName(submission);

        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFileName + "\"");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Access-Control-Expose-Headers", "Content-Disposition");

        if (attachments.isEmpty()) {
            try (java.util.zip.ZipOutputStream zos = new java.util.zip.ZipOutputStream(response.getOutputStream())) {
                java.util.zip.ZipEntry readmeEntry = new java.util.zip.ZipEntry("README.txt");
                zos.putNextEntry(readmeEntry);
                String info = "Appraisal Attachments Archive\n"
                        + "============================\n"
                        + "Submission ID: " + submission.getId() + "\n"
                        + "Audit Type: " + submission.getAuditType() + "\n"
                        + "Cycle / Year: " + (submission.getAuditCycle() != null ? submission.getAuditCycle() : submission.getAcademicYear()) + "\n"
                        + "Entity: " + ("academic".equalsIgnoreCase(submission.getAuditType()) ? submission.getSchool() : "Administrative Office") + "\n"
                        + "Status: " + submission.getStatus() + "\n\n"
                        + "Notice: No attachments or uploaded files were found for this submission.\n";
                zos.write(info.getBytes(StandardCharsets.UTF_8));
                zos.closeEntry();
            }
            return;
        }

        java.util.Set<String> usedPaths = new java.util.HashSet<>();
        java.util.Set<String> successfullyWrittenFiles = new java.util.HashSet<>();
        List<String> missingCandidates = new java.util.ArrayList<>();

        try (java.util.zip.ZipOutputStream zos = new java.util.zip.ZipOutputStream(response.getOutputStream())) {
            for (ExtractedAttachment att : attachments) {
                if (att.url == null || att.url.isBlank()) {
                    continue;
                }

                String folderPath = getZipFolderPath(att, submission.getAuditType());
                String sanitizedName = sanitizeFilename(att.fileName);
                String zipEntryPath = folderPath + sanitizedName;

                // Skip if an identical file was already placed at this path
                if (usedPaths.contains(zipEntryPath)) {
                    continue;
                }

                try (InputStream is = openAttachmentInputStream(att.url, att.fileName)) {
                    if (is != null) {
                        usedPaths.add(zipEntryPath);
                        java.util.zip.ZipEntry entry = new java.util.zip.ZipEntry(zipEntryPath);
                        zos.putNextEntry(entry);
                        byte[] buffer = new byte[8192];
                        int bytesRead;
                        while ((bytesRead = is.read(buffer)) != -1) {
                            zos.write(buffer, 0, bytesRead);
                        }
                        zos.closeEntry();
                        successfullyWrittenFiles.add(sanitizedName.toLowerCase());
                        successfullyWrittenFiles.add(normalizeFilenameForSearch(sanitizedName));
                    } else {
                        log.warn("Could not locate file for attachment: {} ({})", att.fileName, att.url);
                        missingCandidates.add("File: " + att.fileName + ", URL: " + att.url + " - File not found on disk or storage service");
                    }
                } catch (Exception e) {
                    log.warn("Skipping inaccessible attachment: {} - {}", att.url, e.getMessage());
                    missingCandidates.add("File: " + att.fileName + ", URL: " + att.url + ", Error: " + e.getMessage());
                }
            }

            // Only report files as missing if they were NEVER successfully written anywhere in the zip
            List<String> trueMissingFiles = new java.util.ArrayList<>();
            for (String line : missingCandidates) {
                boolean found = false;
                for (String written : successfullyWrittenFiles) {
                    if (!written.isBlank() && line.toLowerCase().contains(written)) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    trueMissingFiles.add(line);
                }
            }

            if (!trueMissingFiles.isEmpty()) {
                java.util.zip.ZipEntry missingEntry = new java.util.zip.ZipEntry("missing-files.txt");
                zos.putNextEntry(missingEntry);
                String content = String.join("\n", trueMissingFiles);
                zos.write(content.getBytes(StandardCharsets.UTF_8));
                zos.closeEntry();
            }
        }
    }

    @GetMapping("/{id}/report/pdf")
    public void downloadPdfReport(@PathVariable Long id,
                                  jakarta.servlet.http.HttpServletRequest request,
                                  jakarta.servlet.http.HttpServletResponse response) throws Exception {
        UserDto user = getCurrentUserDetails();
        Submission submission = submissionService.getSubmissionById(id)
                .orElseThrow(() -> new com.director_appraisal.submission_service.exception.NotFoundException("Submission not found with ID: " + id));

        // Check role permissions: IQAC, VC, Submitter/Owner, Assigned Auditor, or Administrative Contributor
        boolean isOwner = submission.getEmail() != null && submission.getEmail().equalsIgnoreCase(user.getEmail());
        boolean isIqac = "iqac".equalsIgnoreCase(user.getRole());
        boolean isVc = "vice-chancellor".equalsIgnoreCase(user.getRole());
        boolean isAuditor = user.getRole() != null && (user.getRole().toLowerCase().contains("auditor") || "auditor".equalsIgnoreCase(user.getAccountType()));
        boolean isAdministrativeContributor = "administrative".equalsIgnoreCase(user.getRole())
                && "administrative".equalsIgnoreCase(submission.getAuditType());
        boolean isAssignedAuditor = isAuditor && (submissionService.isAuditorAssigned(user, submission) || submissionService.isAuditorFallbackMatch(user, submission));

        if (!isOwner && !isIqac && !isVc && !isAssignedAuditor && !isAdministrativeContributor) {
            throw new SecurityException("Access denied: You do not have permission to download this report");
        }

        String pdfFileName = getReportFileName(submission, "pdf");
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + pdfFileName + "\"");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Access-Control-Expose-Headers", "Content-Disposition");

        String publicBaseUrl = resolvePublicBaseUrl(request);
        reportExportService.generatePdfReport(submission, response, publicBaseUrl);
    }

    @GetMapping("/{id}/report/excel")
    public void downloadExcelReport(@PathVariable Long id,
                                    jakarta.servlet.http.HttpServletRequest request,
                                    jakarta.servlet.http.HttpServletResponse response) throws Exception {
        UserDto user = getCurrentUserDetails();
        Submission submission = submissionService.getSubmissionById(id)
                .orElseThrow(() -> new com.director_appraisal.submission_service.exception.NotFoundException("Submission not found with ID: " + id));

        // Check role permissions: IQAC, VC, Submitter/Owner, Assigned Auditor, or Administrative Contributor
        boolean isOwner = submission.getEmail() != null && submission.getEmail().equalsIgnoreCase(user.getEmail());
        boolean isIqac = "iqac".equalsIgnoreCase(user.getRole());
        boolean isVc = "vice-chancellor".equalsIgnoreCase(user.getRole());
        boolean isAuditor = user.getRole() != null && (user.getRole().toLowerCase().contains("auditor") || "auditor".equalsIgnoreCase(user.getAccountType()));
        boolean isAdministrativeContributor = "administrative".equalsIgnoreCase(user.getRole())
                && "administrative".equalsIgnoreCase(submission.getAuditType());
        boolean isAssignedAuditor = isAuditor && (submissionService.isAuditorAssigned(user, submission) || submissionService.isAuditorFallbackMatch(user, submission));

        if (!isOwner && !isIqac && !isVc && !isAssignedAuditor && !isAdministrativeContributor) {
            throw new SecurityException("Access denied: You do not have permission to download this report");
        }

        String excelFileName = getReportFileName(submission, "xlsx");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + excelFileName + "\"");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Access-Control-Expose-Headers", "Content-Disposition");

        String publicBaseUrl = resolvePublicBaseUrl(request);
        reportExportService.generateExcelReport(submission, response, publicBaseUrl);
    }

    private String getReportFileName(Submission submission, String extension) {
        String uniPrefix = "";

        String type = "academic".equalsIgnoreCase(submission.getAuditType()) ? "Academic" : "Administrative";
        String entityName;
        if ("academic".equalsIgnoreCase(submission.getAuditType())) {
            entityName = SchoolUtils.canonicalizeSchool(submission.getSchool());
            if (entityName == null || entityName.isBlank()) {
                entityName = "School";
            }
        } else {
            if (submission.getAdministrativePost() != null && !submission.getAdministrativePost().isBlank()) {
                entityName = formatAdministrativePost(submission.getAdministrativePost());
            } else {
                entityName = "Administrative_Office";
            }
        }
        entityName = entityName.replaceAll("[^A-Za-z0-9._-]", "_");

        String cycle = submission.getAuditCycle() != null && !submission.getAuditCycle().isBlank()
                ? submission.getAuditCycle()
                : (submission.getAcademicYear() != null ? submission.getAcademicYear() : submissionService.getCurrentAcademicYearLabel());
        cycle = cycle.replaceAll("[^A-Za-z0-9._-]", "_");

        String suffix = "pdf".equalsIgnoreCase(extension) ? "_Official_Report.pdf" : "_Report.xlsx";
        return uniPrefix + type + "_" + entityName + "_" + cycle + suffix;
    }

    public String resolvePublicBaseUrl(jakarta.servlet.http.HttpServletRequest request) {
        if (configuredPublicBaseUrl != null && !configuredPublicBaseUrl.isBlank()) {
            String base = configuredPublicBaseUrl.trim();
            return base.endsWith("/") ? base.substring(0, base.length() - 1) : base;
        }
        jakarta.servlet.http.HttpServletRequest req = request != null ? request : httpRequest;
        if (req == null) {
            return "";
        }

        String xForwardedProto = req.getHeader("X-Forwarded-Proto");
        String xForwardedHost = req.getHeader("X-Forwarded-Host");
        String xForwardedPort = req.getHeader("X-Forwarded-Port");

        if (xForwardedHost != null && !xForwardedHost.isBlank()) {
            String proto = (xForwardedProto != null && !xForwardedProto.isBlank()) ? xForwardedProto.trim() : "http";
            String host = xForwardedHost.trim();
            if (xForwardedPort != null && !xForwardedPort.isBlank() && !host.contains(":")) {
                if (!("http".equalsIgnoreCase(proto) && "80".equals(xForwardedPort))
                        && !("https".equalsIgnoreCase(proto) && "443".equals(xForwardedPort))) {
                    host = host + ":" + xForwardedPort.trim();
                }
            }
            return proto + "://" + host;
        }

        String origin = req.getHeader("Origin");
        if (origin != null && !origin.isBlank() && (origin.startsWith("http://") || origin.startsWith("https://"))) {
            return origin.endsWith("/") ? origin.substring(0, origin.length() - 1) : origin;
        }

        String referer = req.getHeader("Referer");
        if (referer != null && !referer.isBlank() && (referer.startsWith("http://") || referer.startsWith("https://"))) {
            try {
                java.net.URI refUri = java.net.URI.create(referer.trim());
                String scheme = refUri.getScheme();
                String host = refUri.getHost();
                int port = refUri.getPort();
                if (host != null) {
                    if (port > 0 && !(("http".equalsIgnoreCase(scheme) && port == 80) || ("https".equalsIgnoreCase(scheme) && port == 443))) {
                        return scheme + "://" + host + ":" + port;
                    }
                    return scheme + "://" + host;
                }
            } catch (Exception ignored) {}
        }

        String host = req.getHeader("Host");
        if (host != null && !host.isBlank()) {
            String scheme = req.getScheme() != null ? req.getScheme() : "http";
            return scheme + "://" + host.trim();
        }

        try {
            StringBuffer reqUrl = req.getRequestURL();
            if (reqUrl != null) {
                java.net.URI uri = java.net.URI.create(reqUrl.toString());
                String scheme = uri.getScheme();
                String h = uri.getHost();
                int port = uri.getPort();
                if (h != null) {
                    if (port > 0 && !(("http".equalsIgnoreCase(scheme) && port == 80) || ("https".equalsIgnoreCase(scheme) && port == 443))) {
                        return scheme + "://" + h + ":" + port;
                    }
                    return scheme + "://" + h;
                }
            }
        } catch (Exception ignored) {}

        return "";
    }

    private InputStream openAttachmentInputStream(String fileUrl, String originalFileName) {
        if (fileUrl == null || fileUrl.isBlank()) {
            return null;
        }

        String candidateKey = extractCleanObjectName(fileUrl);

        // 1. Try local filesystem
        InputStream localStream = tryOpenLocalFile(candidateKey, fileUrl, originalFileName);
        if (localStream != null) {
            return localStream;
        }

        // 2. Try remote storage-service via HTTP
        InputStream remoteStream = tryOpenRemoteFile(fileUrl, candidateKey, originalFileName);
        if (remoteStream != null) {
            return remoteStream;
        }

        return null;
    }

    private InputStream tryOpenLocalFile(String candidateKey, String rawUrl, String originalFileName) {
        List<Path> searchRoots = new java.util.ArrayList<>();
        if (uploadLocalPath != null && !uploadLocalPath.isBlank()) {
            searchRoots.add(Paths.get(uploadLocalPath).toAbsolutePath().normalize());
        }
        Path appUploads = Paths.get("/app/uploads").toAbsolutePath().normalize();
        Path dotUploads = Paths.get("./uploads").toAbsolutePath().normalize();
        Path parentUploads = Paths.get("../uploads").toAbsolutePath().normalize();

        if (!searchRoots.contains(appUploads)) searchRoots.add(appUploads);
        if (!searchRoots.contains(dotUploads)) searchRoots.add(dotUploads);
        if (!searchRoots.contains(parentUploads)) searchRoots.add(parentUploads);

        List<String> relativePathsToTry = new java.util.ArrayList<>();
        if (candidateKey != null && !candidateKey.isBlank()) {
            relativePathsToTry.add(candidateKey);
        }
        if (rawUrl != null && !rawUrl.isBlank()) {
            String sanitized = rawUrl.replace("\\", "/");
            int qMark = sanitized.indexOf('?');
            if (qMark >= 0) sanitized = sanitized.substring(0, qMark);
            if (sanitized.contains("/uploads/")) {
                sanitized = sanitized.substring(sanitized.indexOf("/uploads/") + "/uploads/".length());
            } else if (sanitized.startsWith("/")) {
                sanitized = sanitized.substring(1);
            }
            relativePathsToTry.add(sanitized);
        }

        for (Path root : searchRoots) {
            if (!Files.exists(root)) continue;

            for (String rel : relativePathsToTry) {
                Path direct = root.resolve(rel).normalize();
                if (direct.startsWith(root) && Files.isRegularFile(direct)) {
                    try {
                        return Files.newInputStream(direct);
                    } catch (Exception ignored) {}
                }
            }

            // Fallback: search recursively by candidate filename (up to 6 levels deep)
            List<String> targetNames = new java.util.ArrayList<>();
            if (originalFileName != null && !originalFileName.isBlank()) {
                targetNames.add(originalFileName.trim());
            }
            if (candidateKey != null && candidateKey.contains("/")) {
                targetNames.add(candidateKey.substring(candidateKey.lastIndexOf('/') + 1));
            }

            for (String targetName : targetNames) {
                if (targetName.isBlank()) continue;
                String normTarget = normalizeFilenameForSearch(targetName);
                try (Stream<Path> walk = Files.walk(root, 6)) {
                    Optional<Path> match = walk
                            .filter(Files::isRegularFile)
                            .filter(p -> {
                                String fname = p.getFileName().toString();
                                return fname.equalsIgnoreCase(targetName)
                                        || (!normTarget.isEmpty() && normalizeFilenameForSearch(fname).equalsIgnoreCase(normTarget));
                            })
                            .findFirst();
                    if (match.isPresent()) {
                        return Files.newInputStream(match.get());
                    }
                } catch (Exception ignored) {}
            }
        }
        return null;
    }

    private InputStream tryOpenRemoteFile(String rawUrl, String candidateKey, String originalFileName) {
        String base = storageServiceUrl != null && !storageServiceUrl.isBlank()
                ? storageServiceUrl.trim()
                : "http://storage-service:9004";
        if (base.endsWith("/")) base = base.substring(0, base.length() - 1);

        List<String> urlsToTry = new java.util.ArrayList<>();
        if (candidateKey != null && !candidateKey.isBlank()) {
            urlsToTry.add(candidateKey);
        }
        if (rawUrl != null && !rawUrl.isBlank()) {
            urlsToTry.add(rawUrl);
        }

        for (String targetUrl : urlsToTry) {
            try {
                String downloadEndpoint = base + "/api/attachments/download?url="
                        + URLEncoder.encode(targetUrl, StandardCharsets.UTF_8)
                        + (originalFileName != null && !originalFileName.isBlank()
                            ? "&filename=" + URLEncoder.encode(originalFileName, StandardCharsets.UTF_8)
                            : "")
                        + "&inline=false";

                java.net.URI uri = java.net.URI.create(downloadEndpoint);
                java.net.HttpURLConnection conn = (java.net.HttpURLConnection) uri.toURL().openConnection();
                conn.setRequestMethod("GET");
                conn.setConnectTimeout(4000);
                conn.setReadTimeout(15000);
                conn.setInstanceFollowRedirects(true);

                int code = conn.getResponseCode();
                if (code >= 200 && code < 300) {
                    return conn.getInputStream();
                }
            } catch (Exception ignored) {}
        }
        return null;
    }

    private String extractCleanObjectName(String url) {
        if (url == null || url.isBlank()) {
            return "";
        }
        String clean = url.trim();
        if (clean.contains("url=")) {
            int qIdx = clean.indexOf("url=");
            String paramVal = clean.substring(qIdx + 4);
            int ampIdx = paramVal.indexOf('&');
            if (ampIdx >= 0) {
                paramVal = paramVal.substring(0, ampIdx);
            }
            try {
                clean = URLDecoder.decode(paramVal, StandardCharsets.UTF_8);
            } catch (Exception ignored) {}
        }

        int qMark = clean.indexOf('?');
        if (qMark >= 0) {
            clean = clean.substring(0, qMark);
        }

        if (clean.contains("users/")) {
            clean = clean.substring(clean.indexOf("users/"));
        } else if (clean.contains("/uploads/")) {
            clean = clean.substring(clean.indexOf("/uploads/") + "/uploads/".length());
        } else if (clean.contains("uploads/")) {
            clean = clean.substring(clean.indexOf("uploads/") + "uploads/".length());
        }

        if (clean.startsWith("/")) {
            clean = clean.substring(1);
        }
        return clean;
    }

    private String normalizeFilenameForSearch(String str) {
        if (str == null) return "";
        String cleaned = str.replaceAll("^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}-", "");
        return cleaned.toLowerCase().replaceAll("[^a-z0-9.]", "");
    }

    private void collectAttachments(com.fasterxml.jackson.databind.JsonNode node, List<ExtractedAttachment> list) {
        collectAttachments(node, list, null);
    }

    private void collectAttachments(com.fasterxml.jackson.databind.JsonNode node, List<ExtractedAttachment> list, String sectionContext) {
        if (node == null || node.isNull()) return;

        if (node.isTextual()) {
            String text = node.asText().trim();
            if (isAttachmentUrlOrPath(text)) {
                ExtractedAttachment att = new ExtractedAttachment();
                att.url = text;
                att.objectKey = extractCleanObjectName(text);
                att.sectionId = sectionContext;
                att.fileName = extractFileNameFromUrlOrPath(text, null);
                list.add(att);
            }
            return;
        }

        if (node.isObject()) {
            String currentSection = sectionContext;
            String url = extractUrlFromObject(node);

            if (url != null && !url.isBlank() && isAttachmentUrlOrPath(url)) {
                ExtractedAttachment att = new ExtractedAttachment();
                att.url = url;
                att.objectKey = extractCleanObjectName(url);
                att.sectionId = currentSection;

                String fn = null;
                if (node.has("fileName") && node.get("fileName").isTextual()) {
                    fn = node.get("fileName").asText();
                } else if (node.has("name") && node.get("name").isTextual()) {
                    fn = node.get("name").asText();
                } else if (node.has("filename") && node.get("filename").isTextual()) {
                    fn = node.get("filename").asText();
                } else if (node.has("originalFilename") && node.get("originalFilename").isTextual()) {
                    fn = node.get("originalFilename").asText();
                } else if (node.has("originalName") && node.get("originalName").isTextual()) {
                    fn = node.get("originalName").asText();
                }
                att.fileName = extractFileNameFromUrlOrPath(url, fn);

                if (node.has("sectionId") && node.get("sectionId").isTextual()) {
                    att.sectionId = node.get("sectionId").asText();
                } else if (node.has("section") && node.get("section").isTextual()) {
                    att.sectionId = node.get("section").asText();
                }

                if (node.has("tableId") && node.get("tableId").isTextual()) {
                    att.tableId = node.get("tableId").asText();
                }
                if (node.has("rowIndex") && node.get("rowIndex").isNumber()) {
                    att.rowIndex = node.get("rowIndex").asInt();
                }
                if (node.has("column") && node.get("column").isTextual()) {
                    att.column = node.get("column").asText();
                }
                if (node.has("id") && node.get("id").isTextual()) {
                    att.id = node.get("id").asText();
                }
                if (node.has("checksum") && node.get("checksum").isTextual()) {
                    att.checksum = node.get("checksum").asText();
                } else if (node.has("sha256") && node.get("sha256").isTextual()) {
                    att.checksum = node.get("sha256").asText();
                }
                if (node.has("size") && node.get("size").isTextual()) {
                    att.size = node.get("size").asText();
                } else if (node.has("fileSize") && node.get("fileSize").isTextual()) {
                    att.size = node.get("fileSize").asText();
                }
                list.add(att);
                return;
            }

            node.fields().forEachRemaining(entry ->
                    collectAttachments(entry.getValue(), list, resolveAttachmentSectionContext(entry.getKey(), currentSection)));
        } else if (node.isArray()) {
            for (com.fasterxml.jackson.databind.JsonNode item : node) {
                collectAttachments(item, list, sectionContext);
            }
        }
    }

    private boolean isAttachmentUrlOrPath(String str) {
        if (str == null || str.isBlank()) return false;
        String clean = str.trim();
        String lower = clean.toLowerCase();
        if (lower.contains("/uploads/") || lower.contains("/attachments/") || lower.contains("users/")
                || lower.contains("storage.googleapis.com") || lower.startsWith("http://") || lower.startsWith("https://")) {
            return true;
        }
        if (clean.contains("/") || clean.contains("\\")) {
            return lower.endsWith(".pdf") || lower.endsWith(".docx") || lower.endsWith(".doc")
                    || lower.endsWith(".xlsx") || lower.endsWith(".xls") || lower.endsWith(".csv")
                    || lower.endsWith(".png") || lower.endsWith(".jpg") || lower.endsWith(".jpeg")
                    || lower.endsWith(".webp") || lower.endsWith(".zip") || lower.endsWith(".txt");
        }
        return false;
    }

    private String extractUrlFromObject(com.fasterxml.jackson.databind.JsonNode node) {
        String[] fields = {"url", "publicUrl", "downloadUrl", "fileUrl", "path", "filePath", "storagePath",
                "key", "objectKey", "storageObjectKey", "file_url", "download_url", "public_url"};
        for (String f : fields) {
            if (node.has(f) && node.get(f).isTextual() && !node.get(f).asText().isBlank()) {
                return node.get(f).asText();
            }
        }
        return null;
    }

    private String extractFileNameFromUrlOrPath(String url, String candidateName) {
        if (candidateName != null && !candidateName.isBlank()
                && !"attachment.pdf".equalsIgnoreCase(candidateName)
                && !"file.pdf".equalsIgnoreCase(candidateName)) {
            return sanitizeFilename(candidateName);
        }
        if (url == null || url.isBlank()) {
            return "attachment.pdf";
        }
        String clean = url.trim();
        if (clean.contains("fileName=")) {
            int idx = clean.indexOf("fileName=");
            String val = clean.substring(idx + 9);
            int amp = val.indexOf('&');
            if (amp >= 0) val = val.substring(0, amp);
            try {
                return sanitizeFilename(URLDecoder.decode(val, StandardCharsets.UTF_8));
            } catch (Exception ignored) {}
        }
        int qMark = clean.indexOf('?');
        if (qMark >= 0) clean = clean.substring(0, qMark);
        int lastSlash = clean.lastIndexOf('/');
        String base = lastSlash >= 0 ? clean.substring(lastSlash + 1) : clean;
        base = base.replaceAll("^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}-", "");
        return sanitizeFilename(base);
    }

    private String resolveAttachmentSectionContext(String key, String currentSection) {
        if (key == null || key.isBlank()) {
            return currentSection;
        }

        // 1. Scoped table key format: role__instance__sectionKey__baseKey or instance__sectionKey__baseKey
        if (key.contains("__")) {
            String[] tokens = key.split("__");
            if (tokens.length >= 4) {
                String role = tokens[0].trim().toLowerCase();
                String secKey = tokens[2].trim();
                String part = formatDynamicPartName(secKey);

                if (role.contains("ext")) {
                    return !part.isBlank() ? "Auditor-External/" + part : "Auditor-External";
                }
                if (role.contains("int") || role.contains("audit")) {
                    return !part.isBlank() ? "Auditor-Internal/" + part : "Auditor-Internal";
                }
                if (currentSection != null && !currentSection.isBlank()) {
                    return !part.isBlank() ? currentSection + "/" + part : currentSection;
                }
                return !part.isBlank() ? part : currentSection;
            } else if (tokens.length == 3) {
                String secKey = tokens[1].trim();
                String part = formatDynamicPartName(secKey);
                if (currentSection != null && !currentSection.isBlank()) {
                    return !part.isBlank() ? currentSection + "/" + part : currentSection;
                }
                return !part.isBlank() ? part : currentSection;
            }
        }

        // 2. Direct dynamic part detection in key (e.g. part_1, part_2, part_a, part-3, sec_4)
        String detectedPart = formatDynamicPartName(key);
        if (detectedPart.startsWith("Part-") || detectedPart.startsWith("Section-")) {
            if (currentSection != null && !currentSection.isBlank()) {
                String lowerCur = currentSection.toLowerCase();
                if (!lowerCur.contains("part-") && !lowerCur.contains("part_") && !lowerCur.contains("section-")) {
                    return currentSection + "/" + detectedPart;
                }
            }
            return detectedPart;
        }

        // 3. Auditor context detection
        String lowerKey = key.toLowerCase();
        if (lowerKey.contains("external_auditor") || lowerKey.contains("externalauditor") || lowerKey.contains("auditor_external")) {
            return currentSection != null && currentSection.startsWith("Auditor-External") ? currentSection : "Auditor-External";
        }
        if (lowerKey.contains("internal_auditor") || lowerKey.contains("internalauditor") || lowerKey.contains("auditor_internal")) {
            return currentSection != null && currentSection.startsWith("Auditor-Internal") ? currentSection : "Auditor-Internal";
        }
        if (lowerKey.contains("auditor")) {
            return currentSection != null && currentSection.startsWith("Auditor-") ? currentSection : "Auditor-Review";
        }

        // 4. Administrative roles / posts detection
        if (lowerKey.contains("registrar")) {
            return currentSection != null && currentSection.contains("Registrar") ? currentSection : "Registrar";
        }
        if (lowerKey.contains("finance") || lowerKey.contains("account") || lowerKey.contains("budget")) {
            return currentSection != null && currentSection.contains("Finance") ? currentSection : "Finance";
        }
        if (lowerKey.contains("faculty") || lowerKey.contains("staff") || lowerKey.contains("bogmom") || lowerKey.contains("hr")) {
            return currentSection != null && currentSection.contains("HR") ? currentSection : "HR";
        }
        if (lowerKey.contains("welfare") || lowerKey.contains("student") || lowerKey.contains("cultural") || lowerKey.contains("sports")) {
            return currentSection != null && currentSection.contains("Dean-Student-Welfare") ? currentSection : "Dean-Student-Welfare";
        }
        if (lowerKey.contains("placement") || lowerKey.contains("training") || lowerKey.contains("industry")) {
            return currentSection != null && currentSection.contains("Dean-Placement") ? currentSection : "Dean-Placement";
        }
        if (lowerKey.contains("exam") || lowerKey.contains("controller")) {
            return currentSection != null && currentSection.contains("Exam-Controller") ? currentSection : "Exam-Controller";
        }

        // 5. Legacy keyword fallbacks (for backward compatibility)
        String normalized = lowerKey.replaceAll("[^a-z0-9]", "");
        if (normalized.contains("scholarship") || normalized.contains("coursesoffered")
                || normalized.contains("studentstatistics") || normalized.contains("statutory")
                || normalized.contains("auditrecords")) {
            return "Registrar/Part-A";
        }
        if (normalized.contains("infrastructure") || normalized.contains("library")
                || normalized.contains("eresource") || normalized.contains("researchresource")) {
            return "Registrar/Part-C";
        }

        return currentSection;
    }

    private List<ExtractedAttachment> deduplicateAttachments(List<ExtractedAttachment> attachments, String auditType) {
        java.util.Set<String> seenKeys = new java.util.HashSet<>();
        List<ExtractedAttachment> deduped = new java.util.ArrayList<>();
        for (ExtractedAttachment attachment : attachments) {
            List<String> keys = attachmentIdentityKeys(attachment, auditType);
            if (keys.isEmpty()) {
                continue;
            }
            boolean matched = keys.stream().anyMatch(seenKeys::contains);
            if (matched) {
                continue;
            }
            seenKeys.addAll(keys);
            deduped.add(attachment);
        }
        return deduped;
    }

    private List<String> attachmentIdentityKeys(ExtractedAttachment attachment, String auditType) {
        List<String> keys = new java.util.ArrayList<>();
        if (notBlank(attachment.objectKey)) {
            keys.add("key:" + normalizeAttachmentUrl(attachment.objectKey));
        }
        if (notBlank(attachment.url)) {
            keys.add("url:" + normalizeAttachmentUrl(attachment.url));
            String stripped = stripDomain(attachment.url);
            if (!stripped.equalsIgnoreCase(attachment.url)) {
                keys.add("url:" + normalizeAttachmentUrl(stripped));
            }
        }
        if (notBlank(attachment.fileName)) {
            String folder = getZipFolderPath(attachment, auditType);
            String cleanName = sanitizeFilename(attachment.fileName).toLowerCase();
            keys.add("entry:" + folder.toLowerCase() + cleanName);
        }
        if (notBlank(attachment.checksum) && attachment.checksum.length() >= 16) {
            keys.add("checksum:" + attachment.checksum.trim().toLowerCase());
        }
        return keys;
    }

    private String stripDomain(String url) {
        if (url == null) return "";
        String clean = url.trim();
        int idx = clean.indexOf("://");
        if (idx >= 0) {
            int slash = clean.indexOf('/', idx + 3);
            if (slash >= 0) {
                return clean.substring(slash);
            }
        }
        return clean;
    }

    private String extractObjectKey(String url) {
        return extractCleanObjectName(url);
    }

    private String normalizeAttachmentUrl(String value) {
        String normalized = value == null ? "" : value.trim().replace("\\", "/");
        while (normalized.endsWith("/") && normalized.length() > 1) {
            normalized = normalized.substring(0, normalized.length() - 1);
        }
        return normalized.toLowerCase();
    }

    private boolean notBlank(String value) {
        return value != null && !value.isBlank();
    }

    private String getZipFileName(Submission submission) {
        String uniPrefix = "";

        String type = "academic".equalsIgnoreCase(submission.getAuditType()) ? "Academic" : "Administrative";
        String entityName;
        if ("academic".equalsIgnoreCase(submission.getAuditType())) {
            entityName = SchoolUtils.canonicalizeSchool(submission.getSchool());
            if (entityName == null || entityName.isBlank()) {
                entityName = "School";
            }
        } else {
            if (submission.getAdministrativePost() != null && !submission.getAdministrativePost().isBlank()) {
                entityName = formatAdministrativePost(submission.getAdministrativePost());
            } else {
                entityName = "Administrative_Office";
            }
        }
        entityName = entityName.replaceAll("[^A-Za-z0-9._-]", "_");

        String cycle = submission.getAuditCycle() != null && !submission.getAuditCycle().isBlank()
                ? submission.getAuditCycle()
                : (submission.getAcademicYear() != null ? submission.getAcademicYear() : submissionService.getCurrentAcademicYearLabel());
        cycle = cycle.replaceAll("[^A-Za-z0-9._-]", "_");

        return uniPrefix + type + "_" + entityName + "_" + cycle + ".zip";
    }

    private String formatAdministrativePost(String post) {
        if (post == null || post.isBlank()) {
            return "Administrative_Office";
        }
        return capitalizeWord(post.trim().replace('-', '_').replace(' ', '_')).replace('-', '_');
    }

    private String formatDynamicPartName(String raw) {
        if (raw == null || raw.isBlank()) return "";
        String clean = raw.trim();

        // Check for scoped keys like "role__instance__part_1__base"
        if (clean.contains("__")) {
            String[] tokens = clean.split("__");
            if (tokens.length >= 3) {
                clean = tokens.length >= 4 ? tokens[2] : tokens[1];
            }
        }

        // Match "part_1", "part-2", "part 3", "part_a", "part-f", "part12", etc.
        java.util.regex.Matcher mPart = java.util.regex.Pattern
                .compile("(?i)(?:^|[_-])part[_-]?([0-9a-zA-Z]+)").matcher(clean);
        if (mPart.find()) {
            return "Part-" + mPart.group(1).toUpperCase();
        }

        // Match "sec_1", "section_2", etc.
        java.util.regex.Matcher mSec = java.util.regex.Pattern
                .compile("(?i)(?:^|[_-])sec(?:tion)?[_-]?([0-9a-zA-Z]+)").matcher(clean);
        if (mSec.find()) {
            return "Section-" + mSec.group(1).toUpperCase();
        }

        return capitalizeWord(clean.replaceAll("[^a-zA-Z0-9_-]", "_"));
    }

    private String capitalizeWord(String str) {
        if (str == null || str.isBlank()) return "";
        String clean = str.trim().replace('-', '_').replace(' ', '_');
        String[] parts = clean.split("_");
        StringBuilder sb = new StringBuilder();
        for (String p : parts) {
            if (!p.isBlank()) {
                if (!sb.isEmpty()) sb.append("-");
                sb.append(Character.toUpperCase(p.charAt(0)));
                if (p.length() > 1) {
                    sb.append(p.substring(1).toLowerCase());
                }
            }
        }
        return !sb.isEmpty() ? sb.toString() : str;
    }

    private String getZipFolderPath(ExtractedAttachment att, String auditType) {
        String sec = att.sectionId != null ? att.sectionId.trim() : "";
        if ((sec.isBlank() || "general".equalsIgnoreCase(sec)) && att.tableId != null && !att.tableId.isBlank()) {
            sec = resolveAttachmentSectionContext(att.tableId, null);
        } else if (!sec.isBlank() && att.tableId != null && !att.tableId.isBlank()) {
            String lowerSec = sec.toLowerCase();
            if (!lowerSec.contains("part-") && !lowerSec.contains("part_") && !lowerSec.contains("section-")) {
                String tablePart = formatDynamicPartName(att.tableId);
                if (tablePart.startsWith("Part-") || tablePart.startsWith("Section-")) {
                    sec = sec + "/" + tablePart;
                }
            }
        }

        if (sec == null || sec.isBlank() || "general".equalsIgnoreCase(sec)) {
            return "academic".equalsIgnoreCase(auditType) ? "Supporting-Documents/" : "Administrative-Documents/";
        }

        // Split hierarchical path by / or \ to sanitize each dynamic segment
        String[] segments = sec.replace('\\', '/').split("/");
        StringBuilder folderPath = new StringBuilder();
        for (String segment : segments) {
            String cleanSegment = segment.trim();
            if (cleanSegment.isEmpty()) continue;

            cleanSegment = formatDynamicPartName(cleanSegment);
            cleanSegment = cleanSegment.replaceAll("[^A-Za-z0-9._-]", "_");

            if (!cleanSegment.isEmpty()) {
                folderPath.append(cleanSegment).append("/");
            }
        }

        if (folderPath.length() == 0) {
            return "academic".equalsIgnoreCase(auditType) ? "Supporting-Documents/" : "Administrative-Documents/";
        }

        return folderPath.toString();
    }

    private String sanitizeFilename(String filename) {
        if (filename == null || filename.isBlank()) {
            return "attachment.pdf";
        }
        filename = filename.replace("\\", "/");
        int lastSlash = filename.lastIndexOf('/');
        String base = lastSlash >= 0 ? filename.substring(lastSlash + 1) : filename;
        base = base.replace("..", "_");
        String clean = base.replaceAll("[^A-Za-z0-9._-]", "_");
        return clean.isBlank() ? "attachment.pdf" : clean;
    }

    @Data
    public static class ExtractedAttachment {
        private String fileName;
        private String url;
        private String sectionId;
        private String tableId;
        private Integer rowIndex;
        private String column;
        private String id;
        private String objectKey;
        private String checksum;
        private String size;
    }

    @GetMapping({"/university/{universityId}/count", "/count"})
    public ResponseEntity<Map<String, Object>> getSubmissionsCountByUniversity(@PathVariable(required = false) Long universityId) {
        long count = submissionService.getSubmissionsCountByUniversity(universityId);
        return ResponseEntity.ok(Map.of("count", count));
    }

    @Data
    public static class AuditorSubmitRequest {
        private Long auditorId;
        private String auditorName;
        private String auditorEmail;
        private String auditorType;
        private String auditCategory;
        private List<String> postsSubmitted;
        private List<String> submittedPosts;
        private List<String> administrativePosts;
        private List<String> assignedPosts;
        private List<String> posts;
        private List<String> assignmentKeys;
        private String submittedAt;
        private String reviewStatus;
        private String valuesData;
        private String tablesData;
        private String attachments;
        private Boolean auditorCorrectionRequested;
        private Boolean correctionRequestedForAuditor;
        private Boolean requiresAuditorResubmission;
    }
}
