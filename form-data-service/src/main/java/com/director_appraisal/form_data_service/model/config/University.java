package com.director_appraisal.form_data_service.model.config;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "universities")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class University {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 50)
    private String code; // e.g., "dypiu", "mit_wpu"

    @Column(nullable = false)
    private String name;

    private String domain; // e.g., "dypiu.ac.in"

    @Builder.Default
    private String status = "ACTIVE"; // ACTIVE, INACTIVE

    @Column(columnDefinition = "TEXT")
    private String address;

    private String establishmentAct;

    private String logoUrl;

    private String iqacLogoUrl;

    private String primaryColor;

    @Column(columnDefinition = "TEXT")
    private String themeBranding; // JSON for extra colors/logos

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (code != null) {
            code = code.trim().toLowerCase();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
        if (code != null) {
            code = code.trim().toLowerCase();
        }
    }
}
