package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.CulturalActivities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CulturalActivitiesRepository extends JpaRepository<CulturalActivities, Long> {
    List<CulturalActivities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
