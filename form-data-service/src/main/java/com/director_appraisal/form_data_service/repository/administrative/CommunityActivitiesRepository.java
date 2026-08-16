package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.CommunityActivities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CommunityActivitiesRepository extends JpaRepository<CommunityActivities, Long> {
    List<CommunityActivities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
