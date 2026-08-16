package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.ExtensionActivities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ExtensionActivitiesRepository extends JpaRepository<ExtensionActivities, Long> {
    List<ExtensionActivities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
