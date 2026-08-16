package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.TrainingActivities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TrainingActivitiesRepository extends JpaRepository<TrainingActivities, Long> {
    List<TrainingActivities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
