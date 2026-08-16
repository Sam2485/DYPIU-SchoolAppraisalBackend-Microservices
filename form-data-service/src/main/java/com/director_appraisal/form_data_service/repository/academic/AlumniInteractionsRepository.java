package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.AlumniInteractions;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AlumniInteractionsRepository extends JpaRepository<AlumniInteractions, Long> {
    List<AlumniInteractions> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
