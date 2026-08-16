package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.ResearchFunds;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ResearchFundsRepository extends JpaRepository<ResearchFunds, Long> {
    List<ResearchFunds> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
