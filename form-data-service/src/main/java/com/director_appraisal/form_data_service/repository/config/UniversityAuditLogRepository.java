package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.UniversityAuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UniversityAuditLogRepository extends JpaRepository<UniversityAuditLog, Long> {
    List<UniversityAuditLog> findByUniversityIdOrderByTimestampDesc(Long universityId);
    List<UniversityAuditLog> findByUniversityCodeOrderByTimestampDesc(String universityCode);
}
