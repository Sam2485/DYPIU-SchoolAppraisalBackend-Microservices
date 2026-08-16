package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.StudentStartups;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface StudentStartupsRepository extends JpaRepository<StudentStartups, Long> {
    List<StudentStartups> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
