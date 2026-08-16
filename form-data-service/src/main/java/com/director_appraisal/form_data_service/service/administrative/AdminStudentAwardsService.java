package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.AdminStudentAwards;
import com.director_appraisal.form_data_service.repository.administrative.AdminStudentAwardsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminStudentAwardsService {

    private final AdminStudentAwardsRepository repository;

    public List<AdminStudentAwards> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<AdminStudentAwards> saveAll(Long submissionId, List<AdminStudentAwards> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (AdminStudentAwards row : rows) {
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
