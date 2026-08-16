package com.director_appraisal.form_data_service.repository.academic;

import com.director_appraisal.form_data_service.model.academic.BoardOfStudies;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BoardOfStudiesRepository extends JpaRepository<BoardOfStudies, Long> {
    List<BoardOfStudies> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
