package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.ScholarshipStudents;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ScholarshipStudentsRepository extends JpaRepository<ScholarshipStudents, Long> {
    List<ScholarshipStudents> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
