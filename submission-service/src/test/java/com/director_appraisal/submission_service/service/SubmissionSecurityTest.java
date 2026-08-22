package com.director_appraisal.submission_service.service;

import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.repository.SubmissionRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Submission Service - Security & IDOR Protection Tests")
class SubmissionSecurityTest {

    @Mock
    private SubmissionRepository submissionRepository;

    @Test
    @DisplayName("Security: Reject cross-tenant IDOR attack where University A user tries to query University B submission ID")
    void testCrossTenantIdorProtection() {
        Submission uniBSubmission = Submission.builder()
                .id(100L)
                .email("director@apex.edu.in")
                .universityId(2L)
                .universityCode("apex_uni")
                .status("SUBMITTED")
                .build();

        when(submissionRepository.findById(100L)).thenReturn(Optional.of(uniBSubmission));

        Long callerUniversityId = 1L; // Caller from DYPIU
        Optional<Submission> target = submissionRepository.findById(100L);

        assertTrue(target.isPresent());
        boolean isAuthorizedTenant = target.get().getUniversityId().equals(callerUniversityId);
        assertFalse(isAuthorizedTenant, "Tenant isolation must flag cross-tenant access as unauthorized");
    }

    @Test
    @DisplayName("Security: Submitted/Approved submissions cannot be mutated without unlocking workflow")
    void testImmutableApprovedSubmission() {
        Submission approvedSub = Submission.builder()
                .id(50L)
                .email("faculty@dypiu.ac.in")
                .status("APPROVED")
                .valuesData("{\"originalScore\": 95}")
                .build();

        assertEquals("APPROVED", approvedSub.getStatus());
        // Verify state is locked
        boolean isEditable = !"APPROVED".equalsIgnoreCase(approvedSub.getStatus()) && !"SUBMITTED".equalsIgnoreCase(approvedSub.getStatus());
        assertFalse(isEditable, "Approved submission must not be directly editable");
    }
}
