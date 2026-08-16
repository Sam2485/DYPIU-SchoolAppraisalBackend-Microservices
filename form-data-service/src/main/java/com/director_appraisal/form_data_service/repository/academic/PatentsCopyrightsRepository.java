package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.PatentsCopyrights;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PatentsCopyrightsRepository extends JpaRepository<PatentsCopyrights, Long> {
    List<PatentsCopyrights> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
