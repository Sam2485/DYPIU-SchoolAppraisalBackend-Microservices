package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.Hackathons;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface HackathonsRepository extends JpaRepository<Hackathons, Long> {
    List<Hackathons> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
