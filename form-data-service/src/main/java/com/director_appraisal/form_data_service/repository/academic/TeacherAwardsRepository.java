package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.TeacherAwards;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TeacherAwardsRepository extends JpaRepository<TeacherAwards, Long> {
    List<TeacherAwards> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
