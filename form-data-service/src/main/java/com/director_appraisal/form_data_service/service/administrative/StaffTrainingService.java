package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.StaffTraining;
import com.director_appraisal.form_data_service.repository.administrative.StaffTrainingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StaffTrainingService {

    private final StaffTrainingRepository repository;

    public List<StaffTraining> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<StaffTraining> saveAll(Long submissionId, List<StaffTraining> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (StaffTraining row : rows) {
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
