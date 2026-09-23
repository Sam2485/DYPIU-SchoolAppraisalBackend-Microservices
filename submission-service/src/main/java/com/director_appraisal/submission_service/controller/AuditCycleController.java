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

    @org.springframework.beans.factory.annotation.Autowired(required = false)
    private jakarta.servlet.http.HttpServletRequest httpRequest;

    @GetMapping("/current")
    public ResponseEntity<Map<String, Object>> getCurrentAcademicYear(
            @RequestParam(required = false) String auditType,
            @RequestParam(required = false) Boolean onlyWithData) {
        return ResponseEntity.ok(buildAcademicYearInfo(auditType, onlyWithData));
    }

    public ResponseEntity<Map<String, Object>> getCurrentAcademicYear() {
        return getCurrentAcademicYear(null, null);
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllAcademicYears(
            @RequestParam(required = false) String auditType,
            @RequestParam(required = false) Boolean onlyWithData) {
        return ResponseEntity.ok(buildAcademicYearInfo(auditType, onlyWithData));
    }

    public ResponseEntity<Map<String, Object>> getAllAcademicYears() {
        return getAllAcademicYears(null, null);
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

        Map<String, Object> yearInfo = buildAcademicYearInfo(null, false);
        response.put("years", yearInfo.get("years"));
        response.put("availableYears", yearInfo.get("availableYears"));
        response.put("academicYears", yearInfo.get("academicYears"));
        response.put("yearsWithData", yearInfo.get("yearsWithData"));
        response.put("yearDetails", yearInfo.get("yearDetails"));

        return ResponseEntity.ok(response);
    }

    public Map<String, Object> buildAcademicYearInfo() {
        return buildAcademicYearInfo(null, null);
    }

    public Map<String, Object> buildAcademicYearInfo(String requestAuditType, Boolean onlyWithData) {
        try {
            String active = submissionService.getCurrentAcademicYearLabel();
            String compactActive = toShortYearFormat(active);
            Set<String> allSystemYears = collectAllYears(active);

            com.director_appraisal.submission_service.dto.UserDto user = null;
            if (httpRequest != null) {
                user = submissionService.getCurrentUserDetails(httpRequest);
            }

            String auditType = requestAuditType;
            if (auditType == null || auditType.isBlank()) {
                if (user != null) {
                    auditType = submissionService.resolveAuditTypeForCaller(user, null);
                }
            }

            Set<String> yearsWithData = new LinkedHashSet<>();
            List<Map<String, Object>> yearDetails = new ArrayList<>();

            // Build normalized distinct list of years
            Set<String> distinctNormalizedYears = new LinkedHashSet<>();
            if (compactActive != null && !compactActive.isBlank()) {
                distinctNormalizedYears.add(compactActive);
            }
            for (String y : allSystemYears) {
                if (y != null && !y.isBlank()) {
                    distinctNormalizedYears.add(toShortYearFormat(y));
                }
            }

            for (String compactY : distinctNormalizedYears) {
                String longY = toLongYearFormat(compactY);
                boolean isActive = submissionService.isSameAcademicYear(compactY, active);
                boolean hasData;

                if (isActive) {
                    hasData = true;
                } else if (user != null) {
                    hasData = submissionService.hasDataForYear(user, auditType, compactY);
                } else {
                    hasData = submissionService.hasDataForYear(null, auditType, compactY);
                }

                if (hasData) {
                    yearsWithData.add(compactY);
                    yearsWithData.add(longY);
                }

                Map<String, Object> detail = new LinkedHashMap<>();
                detail.put("year", compactY);
                detail.put("academicYear", longY);
                detail.put("auditCycle", compactY);
                detail.put("hasData", hasData);
                detail.put("isActive", isActive);
                yearDetails.add(detail);
            }

            // Decide which set of years to return in availableYears
            Set<String> availableYears = new LinkedHashSet<>();
            String role = (user != null && user.getRole() != null) ? user.getRole().trim().toLowerCase() : "";
            boolean isRestrictedRole = "director".equals(role) || "administrative".equals(role) 
                    || "academic".equalsIgnoreCase(auditType) || "administrative".equalsIgnoreCase(auditType);

            if (Boolean.TRUE.equals(onlyWithData) || (isRestrictedRole && !Boolean.FALSE.equals(onlyWithData))) {
                availableYears.addAll(yearsWithData);
            } else {
                availableYears.addAll(allSystemYears);
            }

            // Always ensure the active year is included in availableYears
            if (compactActive != null && !compactActive.isBlank()) {
                availableYears.add(compactActive);
                availableYears.add(toLongYearFormat(compactActive));
            }

            Map<String, Object> response = new LinkedHashMap<>();
            response.put("activeYear", active);
            response.put("currentAcademicYear", active);
            response.put("currentYear", active);
            response.put("compactActiveYear", compactActive);
            response.put("auditCycle", compactActive);
            response.put("years", allSystemYears);
            response.put("availableYears", availableYears);
            response.put("academicYears", availableYears);
            response.put("yearsWithData", yearsWithData);
            response.put("yearDetails", yearDetails);
            return response;
        } catch (Exception e) {
            log.error("Error building academic year info: {}", e.getMessage(), e);
            String defLong = defaultLongYear();
            String defShort = defaultShortYear();
            Map<String, Object> fallback = new LinkedHashMap<>();
            fallback.put("activeYear", defLong);
            fallback.put("currentAcademicYear", defLong);
            fallback.put("currentYear", defLong);
            fallback.put("compactActiveYear", defShort);
            fallback.put("auditCycle", defShort);
            fallback.put("years", List.of(defShort, defLong));
            fallback.put("availableYears", List.of(defShort, defLong));
            fallback.put("academicYears", List.of(defShort, defLong));
            fallback.put("yearsWithData", List.of(defShort, defLong));
            fallback.put("yearDetails", List.of(
                    Map.of("year", defShort, "academicYear", defLong, "hasData", true, "isActive", true)
            ));
            return fallback;
        }
    }

    private String defaultLongYear() {
        int year = java.time.LocalDate.now().getYear();
        int month = java.time.LocalDate.now().getMonthValue();
        int start = month >= 6 ? year : year - 1;
        return start + "-" + (start + 1);
    }

    private String defaultShortYear() {
        int year = java.time.LocalDate.now().getYear();
        int month = java.time.LocalDate.now().getMonthValue();
        int start = month >= 6 ? year : year - 1;
        return start + "-" + String.valueOf(start + 1).substring(2);
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
            int year = java.time.LocalDate.now().getYear();
            return (year + 1) + "-" + (year + 2);
        }
        String[] parts = current.trim().split("-");
        try {
            int start = Integer.parseInt(parts[0]);
            return (start + 1) + "-" + (start + 2);
        } catch (Exception e) {
            int year = java.time.LocalDate.now().getYear();
            return (year + 1) + "-" + (year + 2);
        }
    }

    private String toLongYearFormat(String value) {
        if (value == null || value.isBlank()) return defaultLongYear();
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
        if (value == null || value.isBlank()) return defaultShortYear();
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
