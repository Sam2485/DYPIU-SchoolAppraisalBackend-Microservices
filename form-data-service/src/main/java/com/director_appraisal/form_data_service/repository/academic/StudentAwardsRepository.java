package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.StudentAwards;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudentAwardsRepository extends JpaRepository<StudentAwards, Long> {
    List<StudentAwards> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
