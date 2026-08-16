package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.Consultancy;
import com.director_appraisal.form_data_service.repository.academic.ConsultancyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ConsultancyService {

    private final ConsultancyRepository repository;

    public List<Consultancy> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<Consultancy> saveAll(Long submissionId, List<Consultancy> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (Consultancy row : rows) {
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
