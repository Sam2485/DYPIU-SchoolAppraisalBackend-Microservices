package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.CoursesOffered;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CoursesOfferedRepository extends JpaRepository<CoursesOffered, Long> {
    List<CoursesOffered> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
