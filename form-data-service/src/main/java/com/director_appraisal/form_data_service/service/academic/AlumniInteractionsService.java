package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.AlumniInteractions;
import com.director_appraisal.form_data_service.repository.academic.AlumniInteractionsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AlumniInteractionsService {

    private final AlumniInteractionsRepository repository;

    public List<AlumniInteractions> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<AlumniInteractions> saveAll(Long submissionId, List<AlumniInteractions> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (AlumniInteractions row : rows) {
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
