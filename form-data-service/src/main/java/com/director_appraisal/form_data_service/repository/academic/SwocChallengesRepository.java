package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.SwocChallenges;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SwocChallengesRepository extends JpaRepository<SwocChallenges, Long> {
    List<SwocChallenges> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
