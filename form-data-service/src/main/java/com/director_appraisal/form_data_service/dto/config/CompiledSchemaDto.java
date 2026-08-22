package com.director_appraisal.form_data_service.dto.config;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CompiledSchemaDto {
    private String id; // e.g. "academic-audit-2025-26"
    private Long schemaId;
    private Long versionId;
    private Integer versionNumber;
    private String auditType; // academic, administrative
    private String title;
    private String academicYear;
    private String ownerRole;
    private String status; // PUBLISHED, DRAFT, ARCHIVED

    private Map<String, Object> header; // university branding header
    private Map<String, Object> universityInfo;
    private List<SectionDto> sections;
    private List<Map<String, Object>> modules; // For administrative modules format if needed
}
