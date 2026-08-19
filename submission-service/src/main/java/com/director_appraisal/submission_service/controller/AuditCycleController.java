package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.model.AcademicYear;
import com.director_appraisal.submission_service.repository.AcademicYearRepository;
import com.director_appraisal.submission_service.repository.SubmissionRepository;
import com.director_appraisal.submission_service.service.SubmissionService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@RestController
@RequestMapping("/api/audit-cycles")
@RequiredArgsConstructor
@CrossOrigin
public class AuditCycleController {

    private final SubmissionService submissionService;
    private final SubmissionRepository submissionRepository;
    private final AcademicYearRepository academicYearRepository;

    @GetMapping("/current")
    public ResponseEntity<Map<String, Object>> getCurrentAcademicYear() {
        return ResponseEntity.ok(buildAcademicYearInfo());
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllAcademicYears() {
        return ResponseEntity.ok(buildAcademicYearInfo());
    }

    @Transactional
    @PostMapping("/start-next")
    public ResponseEntity<Map<String, Object>> startNextAcademicYear(@RequestBody(required = false) StartNextAcademicYearRequest request) {
        String activeYear = submissionService.getCurrentAcademicYearLabel();
        String currentYearInput = (request != null && request.getCurrentAcademicYear() != null && !request.getCurrentAcademicYear().isBlank())
                ? request.getCurrentAcademicYear().trim()
                : activeYear;

        String nextYearInput = (request != null && request.getNextAcademicYear() != null && !request.getNextAcademicYear().isBlank())
                ? request.getNextAcademicYear().trim()
                : computeNextYear(currentYearInput);

        String nextYearLong = toLongYearFormat(nextYearInput);
        String nextYearShort = toShortYearFormat(nextYearInput);

        log.info("Starting next academic year: current={}, nextLong={}, nextShort={}", currentYearInput, nextYearLong, nextYearShort);

        // 1. Deactivate existing active years
        List<AcademicYear> activeYears = academicYearRepository.findByActiveTrue();
        for (AcademicYear ay : activeYears) {
            ay.setActive(false);
            if (ay.getClosedAt() == null) {
                ay.setClosedAt(LocalDateTime.now());
            }
            academicYearRepository.save(ay);
        }

        // 2. Activate or create next year
        AcademicYear nextYearEntity = academicYearRepository.findByYearLabel(nextYearLong)
                .or(() -> academicYearRepository.findByYearLabel(nextYearShort))
                .orElse(null);

        if (nextYearEntity == null) {
            nextYearEntity = AcademicYear.builder()
                    .yearLabel(nextYearLong)
                    .active(true)
                    .startedAt(LocalDateTime.now())
                    .build();
        } else {
            nextYearEntity.setYearLabel(nextYearLong);
            nextYearEntity.setActive(true);
            nextYearEntity.setClosedAt(null);
            nextYearEntity.setStartedAt(LocalDateTime.now());
        }
        academicYearRepository.save(nextYearEntity);

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("success", true);
        response.put("activeYear", nextYearLong);
        response.put("currentAcademicYear", nextYearLong);
        response.put("currentYear", nextYearLong);
        response.put("academicYear", nextYearLong);
        response.put("auditCycle", nextYearShort);
        response.put("compactActiveYear", nextYearShort);
        response.put("previousAcademicYear", currentYearInput);

        Map<String, Object> data = new LinkedHashMap<>();
        data.put("academicYear", nextYearLong);
        data.put("auditCycle", nextYearShort);
        data.put("activeYear", nextYearLong);
        response.put("data", data);

        Set<String> allYears = collectAllYears(nextYearLong);
        response.put("years", allYears);
        response.put("availableYears", allYears);
        response.put("academicYears", allYears);

        return ResponseEntity.ok(response);
    }

    private Map<String, Object> buildAcademicYearInfo() {
        String active = submissionService.getCurrentAcademicYearLabel();
        String compactActive = toShortYearFormat(active);
        Set<String> allYears = collectAllYears(active);

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("activeYear", active);
        response.put("currentAcademicYear", active);
        response.put("currentYear", active);
        response.put("compactActiveYear", compactActive);
        response.put("auditCycle", compactActive);
        response.put("years", allYears);
        response.put("availableYears", allYears);
        response.put("academicYears", allYears);
        return response;
    }

    private Set<String> collectAllYears(String currentActive) {
        Set<String> years = new LinkedHashSet<>();
        if (currentActive != null && !currentActive.isBlank()) {
            years.add(toShortYearFormat(currentActive));
            years.add(toLongYearFormat(currentActive));
        }
        try {
            List<AcademicYear> allAy = academicYearRepository.findAll();
            for (AcademicYear ay : allAy) {
                if (ay.getYearLabel() != null && !ay.getYearLabel().isBlank()) {
                    years.add(toShortYearFormat(ay.getYearLabel()));
                    years.add(toLongYearFormat(ay.getYearLabel()));
                }
            }
        } catch (Exception ignored) {}

        try {
            List<String> distinctAy = submissionRepository.findDistinctAcademicYears();
            if (distinctAy != null) {
                for (String y : distinctAy) {
                    if (y != null && !y.isBlank()) {
                        years.add(toShortYearFormat(y));
                        years.add(toLongYearFormat(y));
                    }
                }
            }
        } catch (Exception ignored) {}

        try {
            List<String> distinctAc = submissionRepository.findDistinctAuditCycles();
            if (distinctAc != null) {
                for (String y : distinctAc) {
                    if (y != null && !y.isBlank()) {
                        years.add(toShortYearFormat(y));
                        years.add(toLongYearFormat(y));
                    }
                }
            }
        } catch (Exception ignored) {}

        return years;
    }

    private String computeNextYear(String current) {
        if (current == null || current.isBlank()) {
            return "2026-2027";
        }
        String[] parts = current.trim().split("-");
        try {
            int start = Integer.parseInt(parts[0]);
            return (start + 1) + "-" + (start + 2);
        } catch (Exception e) {
            return "2026-2027";
        }
    }

    private String toLongYearFormat(String value) {
        if (value == null || value.isBlank()) return "2025-2026";
        String trimmed = value.trim();
        if (trimmed.matches("\\d{4}-\\d{2}")) {
            return trimmed.substring(0, 5) + trimmed.substring(0, 2) + trimmed.substring(5);
        }
        if (trimmed.matches("\\d{4}-\\d{4}")) {
            return trimmed;
        }
        return trimmed;
    }

    private String toShortYearFormat(String value) {
        if (value == null || value.isBlank()) return "2025-26";
        String trimmed = value.trim();
        if (trimmed.matches("\\d{4}-\\d{4}")) {
            return trimmed.substring(0, 4) + "-" + trimmed.substring(7);
        }
        if (trimmed.matches("\\d{4}-\\d{2}")) {
            return trimmed;
        }
        return trimmed;
    }

    @Data
    public static class StartNextAcademicYearRequest {
        private String currentAcademicYear;
        private String nextAcademicYear;
        private boolean preserveApprovedHistory = true;
        private boolean resetActiveForms = true;
    }
}
