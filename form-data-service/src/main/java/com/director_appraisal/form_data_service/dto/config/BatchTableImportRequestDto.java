package com.director_appraisal.form_data_service.dto.config;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BatchTableImportRequestDto {

    private List<TableImportItem> tables;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TableImportItem {
        private String title;
        private String tableKey;
        @Builder.Default
        private Boolean isRepeatable = true;
        @Builder.Default
        private Boolean showTitle = true;
        private List<FieldImportItem> fields;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class FieldImportItem {
        private String label;
        private String fieldKey;
        @Builder.Default
        private String fieldType = "TEXT";
        @Builder.Default
        private Boolean isRequired = false;
        private String placeholder;
        private String defaultValue;
        private List<String> options;
        private String optionsString;
        private Integer displayOrder;
    }
}
