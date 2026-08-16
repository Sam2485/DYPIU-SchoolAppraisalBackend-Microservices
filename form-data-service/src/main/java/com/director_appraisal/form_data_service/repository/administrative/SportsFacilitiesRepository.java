package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.SportsFacilities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SportsFacilitiesRepository extends JpaRepository<SportsFacilities, Long> {
    List<SportsFacilities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
