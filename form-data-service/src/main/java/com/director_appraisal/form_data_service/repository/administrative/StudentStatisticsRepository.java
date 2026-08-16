package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.StudentStatistics;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudentStatisticsRepository extends JpaRepository<StudentStatistics, Long> {
    List<StudentStatistics> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
