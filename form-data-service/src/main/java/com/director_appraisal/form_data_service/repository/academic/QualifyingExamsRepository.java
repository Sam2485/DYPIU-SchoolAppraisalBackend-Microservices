package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.QualifyingExams;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface QualifyingExamsRepository extends JpaRepository<QualifyingExams, Long> {
    List<QualifyingExams> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
