package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.ValueAddedCourses;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ValueAddedCoursesRepository extends JpaRepository<ValueAddedCourses, Long> {
    List<ValueAddedCourses> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
