package com.director_appraisal.form_data_service.service;

import com.director_appraisal.form_data_service.model.AcademicYear;
import com.director_appraisal.form_data_service.repository.AcademicYearRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
public class AcademicYearService {

    private static final String DEFAULT_ACADEMIC_YEAR = "2025-2026";

    private final AcademicYearRepository academicYearRepository;

    public String getCurrentAcademicYearLabel() {
        return academicYearRepository.findByActiveTrue().stream()
                .findFirst()
                .map(AcademicYear::getYearLabel)
                .orElse(DEFAULT_ACADEMIC_YEAR);
    }

    public Map<String, Object> getAcademicYearInfo() {
        List<AcademicYear> activeYears = academicYearRepository.findByActiveTrue();
        String activeYearLabel = activeYears.stream()
                .findFirst()
                .map(AcademicYear::getYearLabel)
                .orElse(DEFAULT_ACADEMIC_YEAR);

        List<String> dbYears = academicYearRepository.findAll().stream()
                .map(AcademicYear::getYearLabel)
                .filter(y -> y != null && !y.isBlank())
                .toList();

        Set<String> allYearsSet = new LinkedHashSet<>();
        allYearsSet.add(activeYearLabel);
        allYearsSet.addAll(dbYears);
        if (allYearsSet.isEmpty()) {
            allYearsSet.add(DEFAULT_ACADEMIC_YEAR);
        }

        List<String> sortedYears = allYearsSet.stream()
                .filter(y -> y != null && !y.isBlank())
                .sorted(Comparator.naturalOrder())
                .toList();

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("activeYear", activeYearLabel);
        response.put("currentAcademicYear", activeYearLabel);
        response.put("currentYear", activeYearLabel);
        response.put("compactActiveYear", toAuditCycle(activeYearLabel));
        response.put("availableYears", sortedYears);
        response.put("academicYears", sortedYears);
        response.put("years", sortedYears);
        return response;
    }

    @Transactional
    public Map<String, Object> startNextAcademicYear(String currentAcademicYear, String nextAcademicYear) {
        String current = normalizeYear(currentAcademicYear);
        String next = normalizeYear(nextAcademicYear);
        validateNextYear(current, next);

        List<AcademicYear> activeYears = academicYearRepository.findByActiveTrue();
        for (AcademicYear ay : activeYears) {
            ay.setActive(false);
            if (ay.getClosedAt() == null) {
                ay.setClosedAt(LocalDateTime.now());
            }
            academicYearRepository.save(ay);
        }

        AcademicYear newYear = academicYearRepository.findByYearLabel(next).orElse(null);
        if (newYear == null) {
            newYear = AcademicYear.builder()
                    .yearLabel(next)
                    .active(true)
                    .startedAt(LocalDateTime.now())
                    .build();
        } else {
            newYear.setActive(true);
            newYear.setClosedAt(null);
            newYear.setStartedAt(LocalDateTime.now());
        }
        academicYearRepository.save(newYear);

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("success", true);
        response.put("academicYear", next);
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("academicYear", next);
        response.put("data", data);
        response.put("auditCycle", toAuditCycle(next));
        response.put("previousAcademicYear", current);

        return response;
    }

    private void validateNextYear(String current, String next) {
        int[] currentParts = parseYear(current);
        int[] nextParts = parseYear(next);
        if (currentParts[1] != currentParts[0] + 1 || nextParts[1] != nextParts[0] + 1
                || nextParts[0] != currentParts[0] + 1 || nextParts[1] != currentParts[1] + 1) {
            throw new IllegalArgumentException("Academic year must increment exactly once");
        }
    }

    private int[] parseYear(String value) {
        String[] parts = value.split("-");
        if (parts.length != 2 || parts[0].length() != 4 || parts[1].length() != 4) {
            throw new IllegalArgumentException("Academic year must use format YYYY-YYYY");
        }
        try {
            return new int[]{Integer.parseInt(parts[0]), Integer.parseInt(parts[1])};
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Academic year must use numeric format YYYY-YYYY");
        }
    }

    private String normalizeYear(String value) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException("Academic year is required");
        }
        return value.trim();
    }

    private String toAuditCycle(String academicYear) {
        int[] parts = parseYear(academicYear);
        return parts[0] + "-" + String.valueOf(parts[1]).substring(2);
    }
}
