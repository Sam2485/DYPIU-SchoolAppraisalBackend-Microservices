package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.HigherStudies;
import com.director_appraisal.form_data_service.repository.academic.HigherStudiesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HigherStudiesService {

    private final HigherStudiesRepository repository;

    public List<HigherStudies> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<HigherStudies> saveAll(Long submissionId, List<HigherStudies> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (HigherStudies row : rows) {
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
