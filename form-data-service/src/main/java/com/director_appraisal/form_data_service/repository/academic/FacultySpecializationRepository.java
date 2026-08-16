package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.FacultySpecialization;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FacultySpecializationRepository extends JpaRepository<FacultySpecialization, Long> {
    List<FacultySpecialization> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
