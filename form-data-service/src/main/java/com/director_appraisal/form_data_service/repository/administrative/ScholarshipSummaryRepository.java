package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.ScholarshipSummary;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ScholarshipSummaryRepository extends JpaRepository<ScholarshipSummary, Long> {
    List<ScholarshipSummary> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
