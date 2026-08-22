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
public class TableDto {
    private Long id;
    private String idString; // e.g. "studentStrength"
    private String tableKey;
    private String title;
    private Boolean showTitle;
    private Boolean isRepeatable;
    private Integer displayOrder;

    private List<String> columns; // Array of column header strings (e.g. ["Class", "Intake", "Admitted"])
    private List<FieldDto> fields; // Column field definitions with types/validations
    private List<Map<String, Object>> initialRows; // Default initial rows if configured
    private Map<String, List<String>> selectOptions;
    private List<String> dateColumns;
    private List<String> numberColumns;
    private List<String> textareaColumns;
    private Map<String, Integer> textareaMaxLengths;
}
