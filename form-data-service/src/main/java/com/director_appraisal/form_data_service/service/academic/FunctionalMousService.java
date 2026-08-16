package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.FunctionalMous;
import com.director_appraisal.form_data_service.repository.academic.FunctionalMousRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FunctionalMousService {

    private final FunctionalMousRepository repository;

    public List<FunctionalMous> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<FunctionalMous> saveAll(Long submissionId, List<FunctionalMous> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (FunctionalMous row : rows) {
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
