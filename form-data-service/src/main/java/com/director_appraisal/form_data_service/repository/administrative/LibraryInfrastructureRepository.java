package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.LibraryInfrastructure;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LibraryInfrastructureRepository extends JpaRepository<LibraryInfrastructure, Long> {
    List<LibraryInfrastructure> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
