package com.director_appraisal.form_data_service.controller.academic;

import com.director_appraisal.form_data_service.model.academic.StudentMentoring;
import com.director_appraisal.form_data_service.service.academic.StudentMentoringService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tables/student_mentoring")
@RequiredArgsConstructor
@CrossOrigin
public class StudentMentoringController {

    private final StudentMentoringService service;

    @GetMapping("/submission/{submissionId}")
    public ResponseEntity<List<StudentMentoring>> getBySubmission(@PathVariable Long submissionId) {
        return ResponseEntity.ok(service.getBySubmissionId(submissionId));
    }

    @PostMapping("/submission/{submissionId}")
    public ResponseEntity<List<StudentMentoring>> save(@PathVariable Long submissionId, @RequestBody List<StudentMentoring> rows) {
        return ResponseEntity.ok(service.saveAll(submissionId, rows));
    }

    @PutMapping("/submission/{submissionId}")
    public ResponseEntity<List<StudentMentoring>> update(@PathVariable Long submissionId, @RequestBody List<StudentMentoring> rows) {
        return ResponseEntity.ok(service.saveAll(submissionId, rows));
    }

    @DeleteMapping("/submission/{submissionId}")
    public ResponseEntity<Void> delete(@PathVariable Long submissionId) {
        service.deleteBySubmissionId(submissionId);
        return ResponseEntity.ok().build();
    }
}
