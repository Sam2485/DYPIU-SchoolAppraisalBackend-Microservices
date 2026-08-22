package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.University;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UniversityRepository extends JpaRepository<University, Long> {
    Optional<University> findByCodeIgnoreCase(String code);
    Optional<University> findByDomainIgnoreCase(String domain);
    boolean existsByCodeIgnoreCase(String code);
}
