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
public class SectionDto {
    private Long id;
    private String idString; // e.g. "part-a-academic-activities"
    private String sectionKey;
    private String title;
    private String number; // e.g. "A", "B"
    private String ownerRole; // e.g. "director-schools", "registrar"
    private String description;
    private Integer displayOrder;

    private List<FieldDto> fields; // Top-level fields
    private List<TableDto> tables; // Child tables
    private List<Map<String, Object>> blocks; // For composite layout blocks if needed
}
