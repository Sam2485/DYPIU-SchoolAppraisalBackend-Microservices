package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.IndustryCollaborations;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface IndustryCollaborationsRepository extends JpaRepository<IndustryCollaborations, Long> {
    List<IndustryCollaborations> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
