package com.director_appraisal.form_data_service.model.config;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "form_fields")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FormField {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long sectionId;

    private Long tableId; // Nullable if top-level section field (like directorEmail, schoolName)

    @Column(nullable = false, length = 100)
    private String fieldKey; // e.g. "schoolName", "sr_no", "date_of_meeting"

    @Column(nullable = false)
    private String label; // e.g. "Name of the School / Department"

    @Column(nullable = false, length = 50)
    @Builder.Default
    private String fieldType = "TEXT"; // TEXT, NUMBER, DATE, SELECT, TEXTAREA, EMAIL, URL, ATTACHMENT, MULTISELECT, HEADING

    private String kind; // e.g. "heading"

    @Builder.Default
    private Boolean isRequired = false;

    private String placeholder;

    private String defaultValue;

    @Column(columnDefinition = "TEXT")
    private String validationRules; // JSON: { min: 0, max: 100, maxLength: 500, regex: "..." }

    @Column(columnDefinition = "TEXT")
    private String options; // JSON: ["Available", "Not Available"] or ["SC", "ST", "OBC", "General"]

    @Column(columnDefinition = "TEXT")
    private String attachmentRules; // JSON: { allowedTypes: ["pdf", "jpg"], maxSizeBytes: 10485760 }

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
