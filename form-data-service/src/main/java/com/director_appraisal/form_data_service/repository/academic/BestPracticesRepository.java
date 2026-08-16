package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.BestPractices;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BestPracticesRepository extends JpaRepository<BestPractices, Long> {
    List<BestPractices> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
