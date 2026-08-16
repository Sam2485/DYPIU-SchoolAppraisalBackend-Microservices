package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.BuildingInfrastructure;
import com.director_appraisal.form_data_service.repository.administrative.BuildingInfrastructureRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BuildingInfrastructureService {

    private final BuildingInfrastructureRepository repository;

    public List<BuildingInfrastructure> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<BuildingInfrastructure> saveAll(Long submissionId, List<BuildingInfrastructure> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (BuildingInfrastructure row : rows) {
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
