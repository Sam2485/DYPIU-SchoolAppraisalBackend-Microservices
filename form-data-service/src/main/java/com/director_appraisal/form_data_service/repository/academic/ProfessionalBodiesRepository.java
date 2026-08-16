package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.ProfessionalBodies;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ProfessionalBodiesRepository extends JpaRepository<ProfessionalBodies, Long> {
    List<ProfessionalBodies> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
