package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.PatentsCopyrights;
import com.director_appraisal.form_data_service.repository.academic.PatentsCopyrightsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PatentsCopyrightsService {

    private final PatentsCopyrightsRepository repository;

    public List<PatentsCopyrights> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<PatentsCopyrights> saveAll(Long submissionId, List<PatentsCopyrights> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (PatentsCopyrights row : rows) {
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
