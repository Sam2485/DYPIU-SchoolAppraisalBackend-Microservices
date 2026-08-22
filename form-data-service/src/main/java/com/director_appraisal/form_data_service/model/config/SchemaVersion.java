package com.director_appraisal.form_data_service.model.config;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "schema_versions")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SchemaVersion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long schemaId;

    @Column(nullable = false)
    private Integer versionNumber; // 1, 2, 3...

    @Column(nullable = false, length = 20)
    @Builder.Default
    private String status = "DRAFT"; // DRAFT, PUBLISHED, ARCHIVED

    private String academicYear; // e.g. "2025-26"

    private String title; // e.g. "External Academic Audit"

    private String ownerRole; // e.g. "director-schools", "registrar"

    @Column(columnDefinition = "TEXT")
    private String compiledSchema; // Full compiled AST JSON for fast rendering

    private String publishedBy;

    private LocalDateTime publishedAt;

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
