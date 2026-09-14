package com.director_appraisal.form_data_service.model.config;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "university_audit_logs")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UniversityAuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long universityId;

    @Column(nullable = false, length = 50)
    private String universityCode;

    private String universityName;

    @Column(nullable = false, length = 50)
    private String action; // e.g. "ARCHIVED", "HARD_DELETED", "CREATED", "UPDATED"

    private String performedByEmail;

    private String performedByName;

    private String performedByRole;

    private String correlationId;

    @Column(columnDefinition = "TEXT")
    private String details;

    @Builder.Default
    private LocalDateTime timestamp = LocalDateTime.now();

    @PrePersist
    protected void onCreate() {
        if (timestamp == null) {
            timestamp = LocalDateTime.now();
        }
    }
}
