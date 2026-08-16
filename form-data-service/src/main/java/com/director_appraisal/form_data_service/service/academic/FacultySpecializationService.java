package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.FacultySpecialization;
import com.director_appraisal.form_data_service.repository.academic.FacultySpecializationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FacultySpecializationService {

    private final FacultySpecializationRepository repository;

    public List<FacultySpecialization> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<FacultySpecialization> saveAll(Long submissionId, List<FacultySpecialization> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (FacultySpecialization row : rows) {
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
