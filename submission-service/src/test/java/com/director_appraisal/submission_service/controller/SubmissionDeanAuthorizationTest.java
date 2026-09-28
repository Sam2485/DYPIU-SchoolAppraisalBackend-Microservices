package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.client.AuthUserClient;
import com.director_appraisal.submission_service.dto.UserDto;
import com.director_appraisal.submission_service.model.AcademicYear;
import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.repository.AcademicYearRepository;
import com.director_appraisal.submission_service.repository.SubmissionAuditorAssignmentRepository;
import com.director_appraisal.submission_service.repository.SubmissionRepository;
import com.director_appraisal.submission_service.service.ReportExportService;
import com.director_appraisal.submission_service.service.SubmissionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Dean Role Read-Only & Authorization Security Tests")
class SubmissionDeanAuthorizationTest {

    @Mock
    private SubmissionService submissionService;
    @Mock
    private AuthUserClient authUserClient;
    @Mock
    private SubmissionAuditorAssignmentRepository submissionAuditorAssignmentRepository;
    @Mock
    private ReportExportService reportExportService;
    @Mock
    private HttpServletRequest httpRequest;
    @Mock
    private HttpServletResponse httpResponse;
    @Mock
    private SubmissionRepository submissionRepository;
    @Mock
    private AcademicYearRepository academicYearRepository;

    private SubmissionController submissionController;
    private AuditCycleController auditCycleController;

    private UserDto deanUser;
    private Submission soaaSubmission;
    private Submission sodSubmission;
    private Submission adminSubmission;

    @BeforeEach
    void setUp() {
        submissionController = new SubmissionController(
                submissionService,
                authUserClient,
                submissionAuditorAssignmentRepository,
                reportExportService,
                httpRequest
        );

        auditCycleController = new AuditCycleController(
                submissionService,
                submissionRepository,
                academicYearRepository
        );
        ReflectionTestUtils.setField(auditCycleController, "httpRequest", httpRequest);

        deanUser = UserDto.builder()
                .id(99L)
                .email("dean.engg@dypiu.ac.in")
                .name("Dean Engineering")
                .role("dean")
                .accountType("dean")
                .category("academic")
                .schools(List.of("SOAA", "SOCE"))
                .build();

        soaaSubmission = Submission.builder()
                .id(1L)
                .email("director.soaa@dypiu.ac.in")
                .school("SOAA")
                .auditType("academic")
                .academicYear("2026-2027")
                .status("SUBMITTED")
                .valuesData("{\"field\": \"value\"}")
                .build();

        sodSubmission = Submission.builder()
                .id(2L)
                .email("director.sod@dypiu.ac.in")
                .school("SOD")
                .auditType("academic")
                .academicYear("2026-2027")
                .status("SUBMITTED")
                .valuesData("{\"field\": \"value\"}")
                .build();

        adminSubmission = Submission.builder()
                .id(3L)
                .email("shared.admin@dypiu.ac.in")
                .school("DYPIU")
                .auditType("administrative")
                .academicYear("2026-2027")
                .status("SUBMITTED")
                .valuesData("{\"field\": \"value\"}")
                .build();
    }

    private void mockDeanCaller() {
        when(httpRequest.getHeader("X-User-Email")).thenReturn("dean.engg@dypiu.ac.in");
        when(httpRequest.getHeader("X-User-Role")).thenReturn("dean");
        when(httpRequest.getHeader("X-User-Account-Type")).thenReturn("dean");
        when(authUserClient.getUserByEmail("dean.engg@dypiu.ac.in")).thenReturn(deanUser);
    }

    // 1. Mutating Submission Controller Endpoints Reject Dean
    @Test
    @DisplayName("Security: saveDraft explicitly rejects role=dean with 403 SecurityException")
    void testSaveDraftRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.saveDraft(null));
    }

    @Test
    @DisplayName("Security: submitForm explicitly rejects role=dean with 403 SecurityException")
    void testSubmitFormRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.submitForm(null));
    }

    @Test
    @DisplayName("Security: updateDraft explicitly rejects role=dean with 403 SecurityException")
    void testUpdateDraftRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.updateDraft(null));
    }

    @Test
    @DisplayName("Security: updateAndSubmitForm explicitly rejects role=dean with 403 SecurityException")
    void testUpdateAndSubmitFormRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.updateAndSubmitForm(null));
    }

    @Test
    @DisplayName("Security: submitAdministrativePart explicitly rejects role=dean with 403 SecurityException")
    void testSubmitAdministrativePartRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.submitAdministrativePart("2026-27"));
    }

    @Test
    @DisplayName("Security: updateSubmission (PUT /{id}) explicitly rejects role=dean with 403 SecurityException")
    void testUpdateSubmissionRejectsDean() {
        mockDeanCaller();
        SubmissionController.FormSubmissionRequest req = new SubmissionController.FormSubmissionRequest();
        assertThrows(SecurityException.class, () -> submissionController.updateSubmission(1L, req));
    }

    @Test
    @DisplayName("Security: submitAuditorReview explicitly rejects role=dean with 403 SecurityException")
    void testSubmitAuditorReviewRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.submitAuditorReview(1L, null));
    }

    @Test
    @DisplayName("Security: reviewSubmission (POST /{id}/review) explicitly rejects role=dean with 403 SecurityException")
    void testReviewSubmissionRejectsDean() {
        mockDeanCaller();
        SubmissionController.ReviewRequest req = new SubmissionController.ReviewRequest();
        assertThrows(SecurityException.class, () -> submissionController.reviewSubmission(1L, req));
    }

    @Test
    @DisplayName("Security: approveSubmission (POST /{id}/approve) explicitly rejects role=dean with 403 SecurityException")
    void testApproveSubmissionRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.approveSubmission(1L, null));
    }

    @Test
    @DisplayName("Security: rejectSubmission (POST /{id}/reject) explicitly rejects role=dean with 403 SecurityException")
    void testRejectSubmissionRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.rejectSubmission(1L, null));
    }

    @Test
    @DisplayName("Security: unlockSubmission (POST /{id}/unlock) explicitly rejects role=dean with 403 SecurityException")
    void testUnlockSubmissionRejectsDean() {
        mockDeanCaller();
        assertThrows(SecurityException.class, () -> submissionController.unlockSubmission(1L));
    }

    @Test
    @DisplayName("Security: createNextCycle explicitly rejects role=dean with 403 SecurityException")
    void testCreateNextCycleRejectsDean() {
        mockDeanCaller();
        SubmissionController.NextCycleRequest req = new SubmissionController.NextCycleRequest();
        assertThrows(SecurityException.class, () -> submissionController.createNextCycle(1L, req));
    }

    // 2. AuditCycleController Mutating Endpoint Rejects Dean
    @Test
    @DisplayName("Security: startNextAcademicYear explicitly rejects role=dean with 403 SecurityException")
    void testStartNextAcademicYearRejectsDean() {
        when(submissionService.getCurrentUserDetails(httpRequest)).thenReturn(deanUser);
        assertThrows(SecurityException.class, () -> auditCycleController.startNextAcademicYear(null));
    }

    // 3. Read Access Scoped to Assigned Schools
    @Test
    @DisplayName("Read: Dean can view submission details for assigned school (SOAA)")
    void testGetSubmissionByIdAllowedForAssignedSchool() {
        mockDeanCaller();
        when(submissionService.getSubmissionById(1L)).thenReturn(Optional.of(soaaSubmission));

        ResponseEntity<Submission> response = submissionController.getSubmissionById(1L);
        assertEquals(200, response.getStatusCode().value());
        assertEquals("SOAA", response.getBody().getSchool());
        verify(submissionService).populatePermissions(soaaSubmission, deanUser);
    }

    @Test
    @DisplayName("Read: Dean cannot view submission details for unassigned school (SOD) -> 403")
    void testGetSubmissionByIdForbiddenForUnassignedSchool() {
        mockDeanCaller();
        when(submissionService.getSubmissionById(2L)).thenReturn(Optional.of(sodSubmission));

        ResponseEntity<Submission> response = submissionController.getSubmissionById(2L);
        assertEquals(403, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Read: Dean can get snapshots for assigned school (SOAA)")
    void testGetSnapshotsAllowedForAssignedSchool() {
        mockDeanCaller();
        when(submissionService.getSubmissionById(1L)).thenReturn(Optional.of(soaaSubmission));
        when(submissionService.getVersionHistoryForSubmission(1L)).thenReturn(List.of());

        ResponseEntity<?> response = submissionController.getSnapshots(1L);
        assertEquals(200, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Read: Dean cannot get snapshots for unassigned school (SOD) -> 403")
    void testGetSnapshotsForbiddenForUnassignedSchool() {
        mockDeanCaller();
        when(submissionService.getSubmissionById(2L)).thenReturn(Optional.of(sodSubmission));

        ResponseEntity<?> response = submissionController.getSnapshots(2L);
        assertEquals(403, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Read: Dean can download PDF report for assigned school (SOAA)")
    void testDownloadPdfAllowedForAssignedSchool() throws Exception {
        mockDeanCaller();
        when(submissionService.getSubmissionById(1L)).thenReturn(Optional.of(soaaSubmission));

        assertDoesNotThrow(() -> submissionController.downloadPdfReport(1L, httpRequest, httpResponse));
        verify(reportExportService).generatePdfReport(eq(soaaSubmission), eq(httpResponse), any());
    }

    @Test
    @DisplayName("Read: Dean cannot download PDF report for unassigned school (SOD) -> SecurityException")
    void testDownloadPdfForbiddenForUnassignedSchool() {
        mockDeanCaller();
        when(submissionService.getSubmissionById(2L)).thenReturn(Optional.of(sodSubmission));

        assertThrows(SecurityException.class, () -> submissionController.downloadPdfReport(2L, httpRequest, httpResponse));
    }

    @Test
    @DisplayName("Read: Dean can download Excel report for assigned school (SOAA)")
    void testDownloadExcelAllowedForAssignedSchool() throws Exception {
        mockDeanCaller();
        when(submissionService.getSubmissionById(1L)).thenReturn(Optional.of(soaaSubmission));

        assertDoesNotThrow(() -> submissionController.downloadExcelReport(1L, httpRequest, httpResponse));
        verify(reportExportService).generateExcelReport(eq(soaaSubmission), eq(httpResponse), any());
    }

    @Test
    @DisplayName("Read: Dean cannot download Excel report for unassigned school (SOD) -> SecurityException")
    void testDownloadExcelForbiddenForUnassignedSchool() {
        mockDeanCaller();
        when(submissionService.getSubmissionById(2L)).thenReturn(Optional.of(sodSubmission));

        assertThrows(SecurityException.class, () -> submissionController.downloadExcelReport(2L, httpRequest, httpResponse));
    }
}
