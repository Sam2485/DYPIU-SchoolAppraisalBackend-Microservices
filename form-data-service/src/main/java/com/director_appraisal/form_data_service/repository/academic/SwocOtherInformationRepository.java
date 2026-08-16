package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.SwocOtherInformation;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SwocOtherInformationRepository extends JpaRepository<SwocOtherInformation, Long> {
    List<SwocOtherInformation> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
