package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.ResearchResources;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ResearchResourcesRepository extends JpaRepository<ResearchResources, Long> {
    List<ResearchResources> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
