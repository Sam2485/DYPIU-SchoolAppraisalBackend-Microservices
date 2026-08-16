package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.SwocWeaknesses;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SwocWeaknessesRepository extends JpaRepository<SwocWeaknesses, Long> {
    List<SwocWeaknesses> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
