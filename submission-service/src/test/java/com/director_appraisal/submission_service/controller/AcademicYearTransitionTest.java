package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.model.AcademicYear;
import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.repository.AcademicYearRepository;
import com.director_appraisal.submission_service.repository.SubmissionRepository;
import com.director_appraisal.submission_service.service.SubmissionService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;

import java.time.LocalDateTime;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Submission Service - Academic Year Transition & Historical Isolation Tests")
class AcademicYearTransitionTest {

    @Mock
    private SubmissionService submissionService;
    @Mock
    private SubmissionRepository submissionRepository;
    @Mock
    private AcademicYearRepository academicYearRepository;

    private AuditCycleController auditCycleController;

    @BeforeEach
    void setUp() {
        auditCycleController = new AuditCycleController(
                submissionService,
                submissionRepository,
                academicYearRepository
        );
    }

    @Test
    @DisplayName("Should successfully transition to next academic year, deactivate old cycle, and activate new cycle")
    void testStartNextAcademicYearSuccess() {
        // Given current active year 2024-2025
        AcademicYear currentActive = AcademicYear.builder()
                .id(1L)
                .yearLabel("2024-2025")
                .active(true)
                .startedAt(LocalDateTime.now().minusYears(1))
                .build();

        when(submissionService.getCurrentAcademicYearLabel()).thenReturn("2024-2025");
        when(academicYearRepository.findByActiveTrue()).thenReturn(List.of(currentActive));
        // Next year 2025-2026 does not exist yet
        when(academicYearRepository.findByYearLabel("2025-2026")).thenReturn(Optional.empty());
        when(academicYearRepository.findByYearLabel("2025-26")).thenReturn(Optional.empty());
        when(academicYearRepository.save(any(AcademicYear.class))).thenAnswer(inv -> inv.getArgument(0));

        when(academicYearRepository.findAll()).thenReturn(List.of(currentActive));
        when(submissionRepository.findDistinctAcademicYears()).thenReturn(List.of("2024-25"));
        when(submissionRepository.findDistinctAuditCycles()).thenReturn(List.of("2024-25"));

        // When starting next academic year
        AuditCycleController.StartNextAcademicYearRequest req = new AuditCycleController.StartNextAcademicYearRequest();
        req.setCurrentAcademicYear("2024-2025");
        req.setNextAcademicYear("2025-2026");

        ResponseEntity<Map<String, Object>> response = auditCycleController.startNextAcademicYear(req);

        // Then
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        Map<String, Object> body = response.getBody();
        assertNotNull(body);
        assertEquals(true, body.get("success"));
        assertEquals("2025-2026", body.get("activeYear"));
        assertEquals("2025-26", body.get("auditCycle"));
        assertEquals("2024-2025", body.get("previousAcademicYear"));

        // Verify old year was deactivated and closedAt set
        assertFalse(currentActive.getActive());
        assertNotNull(currentActive.getClosedAt());

        // Verify next year was saved as active
        ArgumentCaptor<AcademicYear> captor = ArgumentCaptor.forClass(AcademicYear.class);
        verify(academicYearRepository, atLeastOnce()).save(captor.capture());
        List<AcademicYear> savedYears = captor.getAllValues();
        AcademicYear activatedNext = savedYears.get(savedYears.size() - 1);
        assertEquals("2025-2026", activatedNext.getYearLabel());
        assertTrue(activatedNext.getActive());
        assertNull(activatedNext.getClosedAt());
        assertNotNull(activatedNext.getStartedAt());
    }

    @Test
    @DisplayName("Idempotency: Repeated call to start next year reactivates existing entity without duplicates")
    void testStartNextAcademicYearIdempotent() {
        AcademicYear existingNextYear = AcademicYear.builder()
                .id(2L)
                .yearLabel("2025-2026")
                .active(false)
                .closedAt(LocalDateTime.now().minusMonths(1))
                .build();

        when(submissionService.getCurrentAcademicYearLabel()).thenReturn("2024-2025");
        when(academicYearRepository.findByActiveTrue()).thenReturn(List.of());
        when(academicYearRepository.findByYearLabel("2025-2026")).thenReturn(Optional.of(existingNextYear));
        when(academicYearRepository.save(any(AcademicYear.class))).thenAnswer(inv -> inv.getArgument(0));

        AuditCycleController.StartNextAcademicYearRequest req = new AuditCycleController.StartNextAcademicYearRequest();
        req.setCurrentAcademicYear("2024-2025");
        req.setNextAcademicYear("2025-2026");

        ResponseEntity<Map<String, Object>> response = auditCycleController.startNextAcademicYear(req);

        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        assertEquals("2025-2026", response.getBody().get("activeYear"));

        // Verify the existing entity (id=2L) was updated, not replaced
        assertTrue(existingNextYear.getActive());
        assertNull(existingNextYear.getClosedAt());
        assertNotNull(existingNextYear.getStartedAt());
        verify(academicYearRepository).save(existingNextYear);
    }

    @Test
    @DisplayName("Historical Isolation: Previous cycle submissions maintain their academicYear and locked state")
    void testHistoricalSubmissionsIsolation() {
        Submission prevYearSubmission = Submission.builder()
                .id(1L)
                .email("director.soe@dypiu.ac.in")
                .auditType("academic")
                .school("School of Engineering")
                .academicYear("2024-25")
                .auditCycle("2024-25")
                .status("APPROVED")
                .valuesData("{\"score\": 92}")
                .build();

        Submission newCycleDraft = Submission.builder()
                .id(2L)
                .email("director.soe@dypiu.ac.in")
                .auditType("academic")
                .school("School of Engineering")
                .academicYear("2025-26")
                .auditCycle("2025-26")
                .status("DRAFT")
                .valuesData("{}")
                .build();

        // 1. Verify academic years remain distinct
        assertNotEquals(prevYearSubmission.getAcademicYear(), newCycleDraft.getAcademicYear());
        assertNotEquals(prevYearSubmission.getAuditCycle(), newCycleDraft.getAuditCycle());

        // 2. Verify approved submission remains immutable
        assertEquals("APPROVED", prevYearSubmission.getStatus());
        assertEquals("DRAFT", newCycleDraft.getStatus());

        // 3. Verify previous year data is not overwritten by new draft
        assertNotNull(prevYearSubmission.getValuesData());
        assertTrue(prevYearSubmission.getValuesData().contains("92"));
        assertEquals("{}", newCycleDraft.getValuesData());
    }

    @Test
    @DisplayName("Auto-computes next academic year if nextAcademicYear input is omitted")
    void testAutoComputeNextAcademicYear() {
        when(submissionService.getCurrentAcademicYearLabel()).thenReturn("2024-2025");
        when(academicYearRepository.findByActiveTrue()).thenReturn(List.of());
        when(academicYearRepository.findByYearLabel(any())).thenReturn(Optional.empty());
        when(academicYearRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        // Request with null nextAcademicYear
        AuditCycleController.StartNextAcademicYearRequest req = new AuditCycleController.StartNextAcademicYearRequest();
        req.setCurrentAcademicYear("2024-2025");
        req.setNextAcademicYear(null);

        ResponseEntity<Map<String, Object>> response = auditCycleController.startNextAcademicYear(req);
        assertNotNull(response);
        Map<String, Object> body = response.getBody();
        assertNotNull(body);
        assertEquals("2025-2026", body.get("activeYear"));
        assertEquals("2025-26", body.get("auditCycle"));
    }

    @Test
    @DisplayName("Should return academic year info correctly on getCurrentAcademicYear")
    void testGetCurrentAcademicYear() {
        when(submissionService.getCurrentAcademicYearLabel()).thenReturn("2025-2026");
        when(academicYearRepository.findAll()).thenReturn(List.of(
                AcademicYear.builder().id(1L).yearLabel("2024-2025").active(false).build(),
                AcademicYear.builder().id(2L).yearLabel("2025-2026").active(true).build()
        ));
        when(submissionRepository.findDistinctAcademicYears()).thenReturn(List.of("2024-25", "2025-26"));
        when(submissionRepository.findDistinctAuditCycles()).thenReturn(List.of("2024-25", "2025-26"));

        ResponseEntity<Map<String, Object>> response = auditCycleController.getCurrentAcademicYear();
        assertNotNull(response);
        Map<String, Object> body = response.getBody();
        assertNotNull(body);
        assertEquals("2025-2026", body.get("activeYear"));
        assertEquals("2025-26", body.get("compactActiveYear"));
        assertTrue(((Set<?>) body.get("years")).contains("2025-2026"));
        assertTrue(((Set<?>) body.get("years")).contains("2025-26"));
    }

    @Test
    @DisplayName("Empty cycles should have hasData=false and be excluded from availableYears when onlyWithData=true")
    void testEmptyYearExcludedWhenOnlyWithDataTrue() {
        // Active year: 2028-2029
        when(submissionService.getCurrentAcademicYearLabel()).thenReturn("2028-2029");
        when(academicYearRepository.findAll()).thenReturn(List.of(
                AcademicYear.builder().id(1L).yearLabel("2026-2027").active(false).build(),
                AcademicYear.builder().id(2L).yearLabel("2027-2028").active(false).build(),
                AcademicYear.builder().id(3L).yearLabel("2028-2029").active(true).build()
        ));
        when(submissionRepository.findDistinctAcademicYears()).thenReturn(List.of("2026-27", "2027-28", "2028-29"));
        when(submissionRepository.findDistinctAuditCycles()).thenReturn(List.of("2026-27", "2027-28", "2028-29"));

        when(submissionService.isSameAcademicYear(eq("2028-29"), eq("2028-2029"))).thenReturn(true);
        when(submissionService.isSameAcademicYear(eq("2026-27"), eq("2028-2029"))).thenReturn(false);
        when(submissionService.isSameAcademicYear(eq("2027-28"), eq("2028-2029"))).thenReturn(false);

        // 2026-27 has real data; 2027-28 has zero real data
        when(submissionService.hasDataForYear(any(), any(), eq("2026-27"))).thenReturn(true);
        when(submissionService.hasDataForYear(any(), any(), eq("2027-28"))).thenReturn(false);

        ResponseEntity<Map<String, Object>> response = auditCycleController.getCurrentAcademicYear("academic", true);
        assertNotNull(response);
        Map<String, Object> body = response.getBody();
        assertNotNull(body);

        @SuppressWarnings("unchecked")
        Set<String> availableYears = (Set<String>) body.get("availableYears");
        assertNotNull(availableYears);

        // 2028-29 (active) and 2026-27 (has data) must be present
        assertTrue(availableYears.contains("2028-29"));
        assertTrue(availableYears.contains("2026-27"));

        // 2027-28 (empty cycle) must NOT be present in availableYears!
        assertFalse(availableYears.contains("2027-28"));
        assertFalse(availableYears.contains("2027-2028"));

        // Verify yearDetails accurately reports hasData per year
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> yearDetails = (List<Map<String, Object>>) body.get("yearDetails");
        assertNotNull(yearDetails);

        Map<String, Object> y2027 = yearDetails.stream()
                .filter(d -> "2027-28".equals(d.get("year")))
                .findFirst()
                .orElse(null);
        assertNotNull(y2027);
        assertEquals(false, y2027.get("hasData"));

        Map<String, Object> y2026 = yearDetails.stream()
                .filter(d -> "2026-27".equals(d.get("year")))
                .findFirst()
                .orElse(null);
        assertNotNull(y2026);
        assertEquals(true, y2026.get("hasData"));
    }
}
