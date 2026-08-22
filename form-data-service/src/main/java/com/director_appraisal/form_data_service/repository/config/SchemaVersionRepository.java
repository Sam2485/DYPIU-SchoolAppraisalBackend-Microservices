package com.director_appraisal.form_data_service.repository.config;

import com.director_appraisal.form_data_service.model.config.SchemaVersion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SchemaVersionRepository extends JpaRepository<SchemaVersion, Long> {
    List<SchemaVersion> findBySchemaIdOrderByVersionNumberDesc(Long schemaId);
    Optional<SchemaVersion> findBySchemaIdAndVersionNumber(Long schemaId, Integer versionNumber);
    Optional<SchemaVersion> findBySchemaIdAndStatusIgnoreCase(Long schemaId, String status);
}
