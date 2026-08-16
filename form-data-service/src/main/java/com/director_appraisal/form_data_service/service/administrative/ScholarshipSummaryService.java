package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.ScholarshipSummary;
import com.director_appraisal.form_data_service.repository.administrative.ScholarshipSummaryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ScholarshipSummaryService {

    private final ScholarshipSummaryRepository repository;

    public List<ScholarshipSummary> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<ScholarshipSummary> saveAll(Long submissionId, List<ScholarshipSummary> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (ScholarshipSummary row : rows) {
            row.setId(null);
            row.setSubmissionId(submissionId);
        }
        return repository.saveAll(rows);
    }

    @Transactional
    public void deleteBySubmissionId(Long submissionId) {
        repository.deleteBySubmissionId(submissionId);
    }
}
