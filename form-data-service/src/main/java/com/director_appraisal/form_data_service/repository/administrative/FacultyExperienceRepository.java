package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.FacultyExperience;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FacultyExperienceRepository extends JpaRepository<FacultyExperience, Long> {
    List<FacultyExperience> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
