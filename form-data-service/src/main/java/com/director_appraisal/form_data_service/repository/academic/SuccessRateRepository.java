package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.SuccessRate;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SuccessRateRepository extends JpaRepository<SuccessRate, Long> {
    List<SuccessRate> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
