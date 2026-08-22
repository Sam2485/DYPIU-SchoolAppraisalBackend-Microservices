package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.FormSection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormSectionRepository extends JpaRepository<FormSection, Long> {
    List<FormSection> findByVersionIdOrderByDisplayOrderAscIdAsc(Long versionId);
    void deleteByVersionId(Long versionId);
}
