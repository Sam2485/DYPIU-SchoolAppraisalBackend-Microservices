package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.FdpOrganized;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface FdpOrganizedRepository extends JpaRepository<FdpOrganized, Long> {
    List<FdpOrganized> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
