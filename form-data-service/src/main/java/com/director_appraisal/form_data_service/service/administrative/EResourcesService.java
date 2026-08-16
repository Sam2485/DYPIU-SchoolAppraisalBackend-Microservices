package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.EResources;
import com.director_appraisal.form_data_service.repository.administrative.EResourcesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EResourcesService {

    private final EResourcesRepository repository;

    public List<EResources> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<EResources> saveAll(Long submissionId, List<EResources> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (EResources row : rows) {
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
