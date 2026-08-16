package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.ItInfrastructure;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ItInfrastructureRepository extends JpaRepository<ItInfrastructure, Long> {
    List<ItInfrastructure> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
