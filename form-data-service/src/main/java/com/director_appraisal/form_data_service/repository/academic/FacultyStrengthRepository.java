package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.FacultyStrength;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FacultyStrengthRepository extends JpaRepository<FacultyStrength, Long> {
    List<FacultyStrength> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
