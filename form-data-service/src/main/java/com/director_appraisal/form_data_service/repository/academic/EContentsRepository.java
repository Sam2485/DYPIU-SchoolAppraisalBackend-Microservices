package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.EContents;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface EContentsRepository extends JpaRepository<EContents, Long> {
    List<EContents> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
