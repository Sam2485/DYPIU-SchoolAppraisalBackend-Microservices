package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.FormField;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormFieldRepository extends JpaRepository<FormField, Long> {
    List<FormField> findBySectionIdAndTableIdIsNullOrderByDisplayOrderAscIdAsc(Long sectionId);
    List<FormField> findByTableIdOrderByDisplayOrderAscIdAsc(Long tableId);
    List<FormField> findBySectionIdOrderByDisplayOrderAscIdAsc(Long sectionId);
    void deleteBySectionId(Long sectionId);
    void deleteByTableId(Long tableId);
}
