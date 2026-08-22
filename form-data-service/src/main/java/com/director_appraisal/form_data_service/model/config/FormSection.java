package com.director_appraisal.form_data_service.model.config;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "form_sections")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FormSection {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long versionId;

    @Column(nullable = false, length = 100)
    private String sectionKey; // e.g. "part-a-academic-activities"

    @Column(nullable = false)
    private String title; // e.g. "Part A - Academic Activities"

    private String sectionNumber; // e.g. "A", "B", "1"

    private String ownerRole; // e.g. "director-schools", "registrar", "hr", "dean-student-welfare", "dean-placement"

    @Column(columnDefinition = "TEXT")
    private String description;

    @Builder.Default
    private Integer displayOrder = 0;

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
