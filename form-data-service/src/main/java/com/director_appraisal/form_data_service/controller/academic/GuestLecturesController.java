package com.director_appraisal.form_data_service.controller.academic;

import com.director_appraisal.form_data_service.model.academic.GuestLectures;
import com.director_appraisal.form_data_service.service.academic.GuestLecturesService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tables/guest_lectures")
@RequiredArgsConstructor
@CrossOrigin
public class GuestLecturesController {

    private final GuestLecturesService service;

    @GetMapping("/submission/{submissionId}")
    public ResponseEntity<List<GuestLectures>> getBySubmission(@PathVariable Long submissionId) {
        return ResponseEntity.ok(service.getBySubmissionId(submissionId));
    }

    @PostMapping("/submission/{submissionId}")
    public ResponseEntity<List<GuestLectures>> save(@PathVariable Long submissionId, @RequestBody List<GuestLectures> rows) {
        return ResponseEntity.ok(service.saveAll(submissionId, rows));
    }

    @PutMapping("/submission/{submissionId}")
    public ResponseEntity<List<GuestLectures>> update(@PathVariable Long submissionId, @RequestBody List<GuestLectures> rows) {
        return ResponseEntity.ok(service.saveAll(submissionId, rows));
    }

    @DeleteMapping("/submission/{submissionId}")
    public ResponseEntity<Void> delete(@PathVariable Long submissionId) {
        service.deleteBySubmissionId(submissionId);
        return ResponseEntity.ok().build();
    }
}
