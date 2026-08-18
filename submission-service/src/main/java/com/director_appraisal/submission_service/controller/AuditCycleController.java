package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.repository.SubmissionRepository;
import com.director_appraisal.submission_service.service.SubmissionService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/audit-cycles")
@RequiredArgsConstructor
@CrossOrigin
public class AuditCycleController {

    private final SubmissionService submissionService;
    private final SubmissionRepository submissionRepository;

    @GetMapping("/current")
    public ResponseEntity<Map<String, Object>> getCurrentAcademicYear() {
        String active = submissionService.getCurrentAcademicYearLabel();
        return ResponseEntity.ok(Map.of(
                "activeYear", active,
                "currentAcademicYear", active
        ));
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllAcademicYears() {
        String active = submissionService.getCurrentAcademicYearLabel();
        List<String> distinct = submissionRepository.findDistinctAcademicYears();
        List<String> years = (distinct != null && !distinct.isEmpty()) ? distinct : List.of(active);
        return ResponseEntity.ok(Map.of(
                "activeYear", active,
                "years", years
        ));
    }

    @PostMapping("/start-next")
    public ResponseEntity<Map<String, Object>> startNextAcademicYear(@RequestBody StartNextAcademicYearRequest request) {
        String active = submissionService.getCurrentAcademicYearLabel();
        return ResponseEntity.ok(Map.of(
                "activeYear", active,
                "currentAcademicYear", active
        ));
    }

    @Data
    public static class StartNextAcademicYearRequest {
        private String currentAcademicYear;
        private String nextAcademicYear;
        private boolean preserveApprovedHistory = true;
        private boolean resetActiveForms = true;
    }
}
