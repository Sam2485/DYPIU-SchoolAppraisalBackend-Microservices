package com.director_appraisal.submission_service.controller;

import com.director_appraisal.submission_service.service.SubmissionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/internal/submissions")
@RequiredArgsConstructor
@Slf4j
public class InternalSubmissionController {

    private final SubmissionService submissionService;

    @GetMapping("/count-by-schema-version")
    public ResponseEntity<Map<Long, Long>> countBySchemaVersion(
            @RequestParam(value = "versionIds", required = false) List<Long> versionIds) {
        log.info("[INTERNAL] countBySchemaVersion requested for versionIds={}", versionIds);
        Map<Long, Long> counts = submissionService.countBySchemaVersionIds(versionIds);
        return ResponseEntity.ok(counts);
    }
}
