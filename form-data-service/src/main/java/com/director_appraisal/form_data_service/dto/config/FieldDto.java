package com.director_appraisal.form_data_service.dto.config;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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
@JsonIgnoreProperties(ignoreUnknown = true)
public class FieldDto {
    private Object id;
    private String idString; // e.g. "schoolName" for legacy compatibility
    private String fieldKey;
    private String label;
    private String fieldType; // TEXT, NUMBER, DATE, SELECT, TEXTAREA, EMAIL, URL, ATTACHMENT, MULTISELECT, HEADING
    private String kind; // e.g. "heading"
    private Boolean isRequired;
    private String placeholder;
    private String defaultValue;
    private Object validationRules; // Map or Object
    private List<String> options; // For select dropdowns
    private Object attachmentRules;
    private Integer displayOrder;
}
