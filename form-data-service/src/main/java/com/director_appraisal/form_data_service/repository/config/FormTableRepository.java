package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.FormTable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface FormTableRepository extends JpaRepository<FormTable, Long> {
    List<FormTable> findBySectionIdOrderByDisplayOrderAscIdAsc(Long sectionId);
    List<FormTable> findBySectionIdIn(Collection<Long> sectionIds);
    void deleteBySectionId(Long sectionId);
}
