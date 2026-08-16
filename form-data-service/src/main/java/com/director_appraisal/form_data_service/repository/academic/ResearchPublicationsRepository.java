package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.ResearchPublications;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ResearchPublicationsRepository extends JpaRepository<ResearchPublications, Long> {
    List<ResearchPublications> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
