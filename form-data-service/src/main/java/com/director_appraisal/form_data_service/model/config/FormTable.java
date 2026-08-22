package com.director_appraisal.form_data_service.model.config;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "form_tables")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FormTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long sectionId;

    @Column(nullable = false, length = 100)
    private String tableKey; // e.g. "boardOfStudies", "studentStrength"

    @Column(nullable = false)
    private String title; // e.g. "1. Board of Studies meetings conducted"

    @Builder.Default
    private Boolean showTitle = true;

    @Builder.Default
    private Boolean isRepeatable = true;

    @Builder.Default
    private Integer displayOrder = 0;

    @Column(columnDefinition = "TEXT")
    private String initialRows; // JSON array of default row objects

    @Column(columnDefinition = "TEXT")
    private String selectOptions; // JSON map of column name -> options array

    @Column(columnDefinition = "TEXT")
    private String dateColumns; // JSON array of column names that take date inputs

    @Column(columnDefinition = "TEXT")
    private String numberColumns; // JSON array of column names that take number inputs

    @Column(columnDefinition = "TEXT")
    private String textareaColumns; // JSON array of column names that take textarea inputs

    @Column(columnDefinition = "TEXT")
    private String textareaMaxLengths; // JSON map of column name -> max length

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
