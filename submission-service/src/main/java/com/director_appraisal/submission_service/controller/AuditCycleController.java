package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.client.FormDataClient;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/audit-cycles")
@RequiredArgsConstructor
@CrossOrigin
public class AuditCycleController {

    private final FormDataClient formDataClient;

    @GetMapping("/current")
    public ResponseEntity<Map<String, Object>> getCurrentAcademicYear() {
        return ResponseEntity.ok(formDataClient.getAcademicYearInfo());
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAllAcademicYears() {
        return ResponseEntity.ok(formDataClient.getAcademicYearInfo());
    }

    @PostMapping("/start-next")
    public ResponseEntity<Map<String, Object>> startNextAcademicYear(@RequestBody StartNextAcademicYearRequest request) {
        return ResponseEntity.ok(formDataClient.getAcademicYearInfo());
    }

    @Data
    public static class StartNextAcademicYearRequest {
        private String currentAcademicYear;
        private String nextAcademicYear;
        private boolean preserveApprovedHistory = true;
        private boolean resetActiveForms = true;
    }
}
