package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.EResources;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EResourcesRepository extends JpaRepository<EResources, Long> {
    List<EResources> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
