package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.SwocOpportunities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SwocOpportunitiesRepository extends JpaRepository<SwocOpportunities, Long> {
    List<SwocOpportunities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
