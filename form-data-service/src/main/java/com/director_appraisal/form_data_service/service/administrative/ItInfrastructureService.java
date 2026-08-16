package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.ItInfrastructure;
import com.director_appraisal.form_data_service.repository.administrative.ItInfrastructureRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ItInfrastructureService {

    private final ItInfrastructureRepository repository;

    public List<ItInfrastructure> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<ItInfrastructure> saveAll(Long submissionId, List<ItInfrastructure> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (ItInfrastructure row : rows) {
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
