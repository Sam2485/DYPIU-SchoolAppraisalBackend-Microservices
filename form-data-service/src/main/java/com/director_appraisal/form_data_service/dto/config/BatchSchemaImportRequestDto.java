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
public class BatchSchemaImportRequestDto {

    private List<SectionImportItem> sections;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SectionImportItem {
        private String title;
        private String sectionNumber; // e.g. "A", "B", "1", "2"
        private String sectionKey;
        @Builder.Default
        private String ownerRole = "director-schools";
        private String description;
        private List<BatchTableImportRequestDto.TableImportItem> tables;
    }
}
