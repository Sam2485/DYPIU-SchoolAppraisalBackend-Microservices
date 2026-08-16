package com.director_appraisal.form_data_service.controller.academic;

import com.director_appraisal.form_data_service.model.academic.FunctionalMous;
import com.director_appraisal.form_data_service.service.academic.FunctionalMousService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/tables/functional_mous")
@RequiredArgsConstructor
@CrossOrigin
public class FunctionalMousController {

    private final FunctionalMousService service;

    @GetMapping("/submission/{submissionId}")
    public ResponseEntity<List<FunctionalMous>> getBySubmission(@PathVariable Long submissionId) {
        return ResponseEntity.ok(service.getBySubmissionId(submissionId));
    }

    @PostMapping("/submission/{submissionId}")
    public ResponseEntity<List<FunctionalMous>> save(@PathVariable Long submissionId, @RequestBody List<FunctionalMous> rows) {
        return ResponseEntity.ok(service.saveAll(submissionId, rows));
    }

    @PutMapping("/submission/{submissionId}")
    public ResponseEntity<List<FunctionalMous>> update(@PathVariable Long submissionId, @RequestBody List<FunctionalMous> rows) {
        return ResponseEntity.ok(service.saveAll(submissionId, rows));
    }

    @DeleteMapping("/submission/{submissionId}")
    public ResponseEntity<Void> delete(@PathVariable Long submissionId) {
        service.deleteBySubmissionId(submissionId);
        return ResponseEntity.ok().build();
    }
}
