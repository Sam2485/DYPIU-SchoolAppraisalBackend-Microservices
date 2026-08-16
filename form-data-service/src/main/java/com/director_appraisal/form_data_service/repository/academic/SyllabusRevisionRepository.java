package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.SyllabusRevision;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SyllabusRevisionRepository extends JpaRepository<SyllabusRevision, Long> {
    List<SyllabusRevision> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
