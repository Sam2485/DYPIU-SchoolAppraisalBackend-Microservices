package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.StudentStrength;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudentStrengthRepository extends JpaRepository<StudentStrength, Long> {
    List<StudentStrength> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
