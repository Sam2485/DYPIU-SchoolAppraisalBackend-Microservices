package com.director_appraisal.form_data_service.repository.administrative;

import com.director_appraisal.form_data_service.model.administrative.DivyangajanFacilities;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DivyangajanFacilitiesRepository extends JpaRepository<DivyangajanFacilities, Long> {
    List<DivyangajanFacilities> findBySubmissionId(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
