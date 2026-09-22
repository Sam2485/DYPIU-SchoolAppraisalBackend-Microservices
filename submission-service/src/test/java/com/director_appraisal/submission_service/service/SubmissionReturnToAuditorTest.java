package com.director_appraisal.submission_service.service;

import com.director_appraisal.submission_service.client.AuthUserClient;
import com.director_appraisal.submission_service.client.FormDataClient;
import com.director_appraisal.submission_service.dto.UserDto;
import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.model.SubmissionAuditorAssignment;
import com.director_appraisal.submission_service.repository.AcademicYearRepository;
import com.director_appraisal.submission_service.repository.SnapshotRepository;
import com.director_appraisal.submission_service.repository.SubmissionAuditorAssignmentRepository;
import com.director_appraisal.submission_service.repository.SubmissionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Submission Service - Return to Auditor Workflow & Guard Tests")
class SubmissionReturnToAuditorTest {

    @Mock
    private SubmissionRepository submissionRepository;
    @Mock
    private SnapshotRepository snapshotRepository;
    @Mock
    private AuthUserClient authUserClient;
    @Mock
    private TableDataPromotionService tableDataPromotionService;
    @Mock
    private SubmissionAuditorAssignmentRepository auditorAssignmentRepository;
    @Mock
    private AcademicYearRepository academicYearRepository;
    @Mock
    private FormDataClient formDataClient;

    private SubmissionService submissionService;

    private UserDto iqacUser;
    private UserDto directorUser;
    private UserDto auditorUser1;
    private UserDto auditorUser2;
    private Submission activeSubmission;
    private SubmissionAuditorAssignment assignment1;
    private SubmissionAuditorAssignment assignment2;

    @BeforeEach
    void setUp() {
        submissionService = new SubmissionService(
                submissionRepository,
                snapshotRepository,
                authUserClient,
                tableDataPromotionService,
                auditorAssignmentRepository,
                academicYearRepository,
                formDataClient
        );

        iqacUser = UserDto.builder()
                .id(1L)
                .email("iqac@dypiu.ac.in")
                .name("IQAC Director")
                .role("iqac")
                .accountType("iqac")
                .build();

        directorUser = UserDto.builder()
                .id(2L)
                .email("director.soe@dypiu.ac.in")
                .name("Director SOE")
                .role("director")
                .school("School of Engineering")
                .build();

        auditorUser1 = UserDto.builder()
                .id(10L)
                .email("auditor1@dypiu.ac.in")
                .name("Internal Auditor 1")
                .role("auditor")
                .accountType("auditor")
                .auditorType("internal")
                .category("academic")
                .deleted(false)
                .status("active")
                .build();

        auditorUser2 = UserDto.builder()
                .id(11L)
                .email("auditor2@dypiu.ac.in")
                .name("Internal Auditor 2")
                .role("auditor")
                .accountType("auditor")
                .auditorType("internal")
                .category("academic")
                .deleted(false)
                .status("active")
                .build();

        activeSubmission = Submission.builder()
                .id(100L)
                .email("director.soe@dypiu.ac.in")
                .auditType("academic")
                .school("School of Engineering")
                .academicYear("2024-25")
                .auditCycle("2024-25")
                .status("UNDER_REVIEW")
                .forwardedAuditorType("internal")
                .reportCategory("academic")
                .valuesData("{\"q1\":\"initial answer\"}")
                .tablesData("{}")
                .attachments("[]")
                .build();

        assignment1 = SubmissionAuditorAssignment.builder()
                .id(501L)
                .submissionId(100L)
                .auditorId(10L)
                .auditorName("Internal Auditor 1")
                .auditorEmail("auditor1@dypiu.ac.in")
                .auditorType("internal")
                .category("academic")
                .post("School of Engineering")
                .status("COMPLETED")
                .reviewStatus("completed")
                .build();

        assignment2 = SubmissionAuditorAssignment.builder()
                .id(502L)
                .submissionId(100L)
                .auditorId(11L)
                .auditorName("Internal Auditor 2")
                .auditorEmail("auditor2@dypiu.ac.in")
                .auditorType("internal")
                .category("academic")
                .post("School of Engineering")
                .status("COMPLETED")
                .reviewStatus("completed")
                .build();
    }

    @Test
    @DisplayName("IQAC returns submission to auditor: targeted assignment reset to PENDING and correction flags set")
    void testReturnToAuditorSuccess() {
        when(submissionRepository.findById(100L)).thenReturn(Optional.of(activeSubmission));
        when(auditorAssignmentRepository.findBySubmissionId(100L)).thenReturn(List.of(assignment1, assignment2));
        when(authUserClient.getUserById(10L)).thenReturn(auditorUser1);
        when(authUserClient.getUserById(11L)).thenReturn(auditorUser2);
        when(submissionRepository.save(any(Submission.class))).thenAnswer(inv -> inv.getArgument(0));

        // Return specifically for auditor 1 using assignment key
        String assignmentKey = "100-10-School of Engineering";
        Submission updated = submissionService.updateSubmission(
                100L,
                iqacUser,
                "UNDER_REVIEW",
                "internal",
                "academic",
                null,
                null,
                null,
                activeSubmission.getValuesData(),
                activeSubmission.getTablesData(),
                activeSubmission.getAttachments(),
                null,
                null,
                true,  // auditorCorrectionRequested
                true,  // correctionRequestedForAuditor
                true,  // requiresAuditorResubmission
                "Please re-verify research output table numbers.",
                "iqac@dypiu.ac.in",
                "iqac",
                LocalDateTime.now().toString(),
                null,
                "Returned for correction",
                List.of(assignmentKey)
        );

        assertNotNull(updated);
        assertEquals("UNDER_REVIEW", updated.getStatus());
        assertTrue(updated.getAuditorCorrectionRequested());
        assertTrue(updated.getCorrectionRequestedForAuditor());
        assertTrue(updated.getRequiresAuditorResubmission());
        assertEquals("Please re-verify research output table numbers.", updated.getAuditorCorrectionMessage());

        // Verify assignment1 was reset to PENDING
        ArgumentCaptor<SubmissionAuditorAssignment> captor = ArgumentCaptor.forClass(SubmissionAuditorAssignment.class);
        verify(auditorAssignmentRepository).save(captor.capture());
        SubmissionAuditorAssignment savedAssignment = captor.getValue();
        assertEquals(501L, savedAssignment.getId());
        assertEquals("PENDING", savedAssignment.getStatus());
        assertEquals("pending", savedAssignment.getReviewStatus());
        assertTrue(savedAssignment.getRequiresAuditorResubmission());
        assertTrue(savedAssignment.getAuditorCorrectionRequested());

        // Verify assignment2 was NOT saved/reset because it wasn't selected
        assertEquals("COMPLETED", assignment2.getStatus());
        assertEquals("completed", assignment2.getReviewStatus());
    }

    @Test
    @DisplayName("Return to auditor matches by requestForwardedToAuditorIds when keys are not provided")
    void testReturnToAuditorMatchedByIds() {
        when(submissionRepository.findById(100L)).thenReturn(Optional.of(activeSubmission));
        when(auditorAssignmentRepository.findBySubmissionId(100L)).thenReturn(List.of(assignment1, assignment2));
        when(authUserClient.getUserById(10L)).thenReturn(auditorUser1);
        when(authUserClient.getUserById(11L)).thenReturn(auditorUser2);
        when(submissionRepository.save(any(Submission.class))).thenAnswer(inv -> inv.getArgument(0));

        submissionService.updateSubmission(
                100L,
                iqacUser,
                "UNDER_REVIEW",
                "internal",
                "academic",
                List.of(10L), // Auditor 1 ID
                null,
                null,
                activeSubmission.getValuesData(),
                null,
                null,
                null,
                null,
                true,
                false,
                false,
                "Please fix section 2",
                "iqac@dypiu.ac.in",
                "iqac",
                null,
                null,
                "Return note",
                null
        );

        verify(auditorAssignmentRepository).save(argThat(a -> a.getId().equals(501L) && "PENDING".equals(a.getStatus())));
    }

    @Test
    @DisplayName("Return to auditor throws IllegalStateException if assigned auditor account is deleted/inactive")
    void testReturnToAuditorThrowsWhenAuditorDeleted() {
        when(submissionRepository.findById(100L)).thenReturn(Optional.of(activeSubmission));
        when(auditorAssignmentRepository.findBySubmissionId(100L)).thenReturn(List.of(assignment1));

        UserDto deletedAuditor = UserDto.builder()
                .id(10L)
                .email("auditor1@dypiu.ac.in")
                .deleted(true) // Deleted auditor
                .build();
        when(authUserClient.getUserById(10L)).thenReturn(deletedAuditor);

        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> submissionService.updateSubmission(
                100L,
                iqacUser,
                "UNDER_REVIEW",
                "internal",
                "academic",
                List.of(10L),
                null,
                null,
                activeSubmission.getValuesData(),
                null,
                null,
                null,
                null,
                true,
                false,
                false,
                "Fix needed",
                "iqac@dypiu.ac.in",
                "iqac",
                null,
                null,
                null,
                null
        ));

        assertTrue(ex.getMessage().contains("Assigned auditor account is inactive/deleted"));
        verify(auditorAssignmentRepository, never()).save(any());
    }

    @Test
    @DisplayName("Submitter cannot edit forms once status transitions to UNDER_REVIEW or AUDITOR_COMPLETED")
    void testOwnerCannotEditWhenUnderReview() {
        when(submissionRepository.findById(100L)).thenReturn(Optional.of(activeSubmission));

        // Director SOE (owner) tries to edit while status is UNDER_REVIEW
        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> submissionService.updateSubmission(
                100L,
                directorUser,
                "UNDER_REVIEW",
                "internal",
                "academic",
                null, null, null, null, null, null, null, null,
                true, false, false, "Remarks", "director@dypiu.ac.in", "director",
                null, null, null, null
        ));

        assertTrue(ex.getMessage().contains("Submitters cannot edit forms once status transitions to UNDER_REVIEW or AUDITOR_COMPLETED"));
    }

    @Test
    @DisplayName("Non-IQAC caller cannot forward submission for review when in DRAFT")
    void testNonIqacCannotForwardDraftToUnderReview() {
        Submission draftSubmission = Submission.builder()
                .id(101L)
                .email("director.soe@dypiu.ac.in")
                .auditType("academic")
                .school("School of Engineering")
                .status("DRAFT")
                .build();
        when(submissionRepository.findById(101L)).thenReturn(Optional.of(draftSubmission));

        // Director SOE tries to set status to UNDER_REVIEW directly from DRAFT
        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> submissionService.updateSubmission(
                101L,
                directorUser,
                "UNDER_REVIEW",
                "internal",
                "academic",
                null, null, null, null, null, null, null, null,
                false, false, false, null, "director@dypiu.ac.in", "director",
                null, null, null, null
        ));

        assertTrue(ex.getMessage().contains("Only IQAC can forward submissions for review"));
    }

    @Test
    @DisplayName("IDOR: Unauthorized caller not linked to submission cannot perform update")
    void testUnauthorizedCallerThrowsException() {
        when(submissionRepository.findById(100L)).thenReturn(Optional.of(activeSubmission));

        UserDto randomUser = UserDto.builder()
                .id(999L)
                .email("stranger@dypiu.ac.in")
                .role("faculty")
                .build();

        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> submissionService.updateSubmission(
                100L,
                randomUser,
                "DRAFT",
                null, null, null, null, null, null, null, null, null, null,
                false, false, false, null, null, null, null, null, null, null
        ));

        assertTrue(ex.getMessage().contains("You are not authorized to edit this submission"));
    }

    @Test
    @DisplayName("Approved / Final submission is immutable and cannot be returned for correction")
    void testApprovedSubmissionCannotBeReturnedOrEdited() {
        Submission approvedSubmission = Submission.builder()
                .id(200L)
                .email("director.soe@dypiu.ac.in")
                .auditType("academic")
                .status("APPROVED")
                .build();

        when(submissionRepository.findById(200L)).thenReturn(Optional.of(approvedSubmission));

        SecurityException ex = assertThrows(SecurityException.class, () -> submissionService.updateSubmission(
                200L,
                iqacUser,
                "UNDER_REVIEW",
                "internal",
                "academic",
                null, null, null, null, null, null, null, null,
                true, false, false, "Try to return", "iqac@dypiu.ac.in", "iqac",
                null, null, null, null
        ));

        assertEquals("Cannot edit an approved submission", ex.getMessage());
    }

    @Test
    @DisplayName("Unassigned auditor cannot complete audit of submission")
    void testUnassignedAuditorCannotCompleteAudit() {
        Submission sub = Submission.builder()
                .id(300L)
                .email("director.soe@dypiu.ac.in")
                .auditType("academic")
                .status("UNDER_REVIEW")
                .build();

        when(submissionRepository.findById(300L)).thenReturn(Optional.of(sub));
        // No auditor assignments exist for this submission
        when(auditorAssignmentRepository.findBySubmissionId(300L)).thenReturn(List.of());

        UserDto unassignedAuditor = UserDto.builder()
                .id(88L)
                .email("other.auditor@dypiu.ac.in")
                .role("auditor")
                .accountType("auditor")
                .build();

        // When unassigned auditor tries to update or complete audit
        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> submissionService.updateSubmission(
                300L,
                unassignedAuditor,
                "AUDITOR_COMPLETED",
                null, null, null, null, null, null, null, null, null, null,
                false, false, false, null, null, null, null, null, null, null
        ));

        assertTrue(ex.getMessage().contains("You are not authorized to edit this submission"));
    }

    @Test
    @DisplayName("Repeated cycle: Return -> Auditor Completion clears flags -> Second Return sets flags again")
    void testRepeatedReturnAndCompletionCycle() {
        when(submissionRepository.findById(100L)).thenReturn(Optional.of(activeSubmission));
        when(auditorAssignmentRepository.findBySubmissionId(100L)).thenReturn(List.of(assignment1));
        when(authUserClient.getUserById(10L)).thenReturn(auditorUser1);
        when(submissionRepository.save(any(Submission.class))).thenAnswer(inv -> inv.getArgument(0));

        // Cycle 1: IQAC returns for correction
        Submission returned1 = submissionService.updateSubmission(
                100L, iqacUser, "UNDER_REVIEW", "internal", "academic",
                List.of(10L), null, null, activeSubmission.getValuesData(), null, null, null, null,
                true, false, false, "Cycle 1 correction", "iqac@dypiu.ac.in", "iqac", null, null, null, null
        );
        assertTrue(returned1.getAuditorCorrectionRequested());

        // Cycle 2: Auditor completes audit
        Submission completedByAuditor = submissionService.updateSubmission(
                100L, auditorUser1, "AUDITOR_COMPLETED", "internal", "academic",
                null, null, null, "{\"q1\":\"auditor revised answer\"}", null, null, null, null,
                false, false, false, null, null, null, null, null, "Auditor completed correction", null
        );
        assertEquals("AUDITOR_COMPLETED", completedByAuditor.getStatus());
        assertFalse(completedByAuditor.getAuditorCorrectionRequested());
        assertFalse(completedByAuditor.getCorrectionRequestedForAuditor());
        assertFalse(completedByAuditor.getRequiresAuditorResubmission());

        // Cycle 3: IQAC returns again for a 2nd round of correction
        Submission returned2 = submissionService.updateSubmission(
                100L, iqacUser, "UNDER_REVIEW", "internal", "academic",
                List.of(10L), null, null, completedByAuditor.getValuesData(), null, null, null, null,
                true, false, false, "Cycle 2 further correction required", "iqac@dypiu.ac.in", "iqac", null, null, null, null
        );
        assertEquals("UNDER_REVIEW", returned2.getStatus());
        assertTrue(returned2.getAuditorCorrectionRequested());
        assertEquals("Cycle 2 further correction required", returned2.getAuditorCorrectionMessage());
    }
}
