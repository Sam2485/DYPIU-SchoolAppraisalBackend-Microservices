package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.FormTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormTableRepository extends JpaRepository<FormTable, Long> {
    List<FormTable> findBySectionIdOrderByDisplayOrderAscIdAsc(Long sectionId);
    void deleteBySectionId(Long sectionId);
}
