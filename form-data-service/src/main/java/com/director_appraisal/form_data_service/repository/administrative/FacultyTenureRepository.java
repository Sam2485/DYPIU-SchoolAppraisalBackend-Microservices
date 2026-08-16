package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.FacultyTenure;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FacultyTenureRepository extends JpaRepository<FacultyTenure, Long> {
    List<FacultyTenure> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
