package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.Consultancy;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ConsultancyRepository extends JpaRepository<Consultancy, Long> {
    List<Consultancy> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
