package com.director_appraisal.submission_service.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserDto {

    private Long id;
    private String email;
    private String name;
    private String designation;
    private String school;
    private String role;
    private String accountType;
    private String category;
    private String auditorType;
    private String auditorRole;
    private String post;
    private String schools;
    private String avatarUrl;
    private Boolean deleted = false;
    private String status = "ACTIVE";

    public Boolean getDeleted() {
        return deleted != null ? deleted : false;
    }

    public String getStatus() {
        return status != null ? status : "ACTIVE";
    }

    public List<String> getSchoolsList() {
        if (schools == null || schools.isBlank()) {
            return List.of();
        }
        return List.of(schools.split(","));
    }

    public void setSchoolsList(List<String> list) {
        if (list == null || list.isEmpty()) {
            this.schools = null;
        } else {
            this.schools = String.join(",", list);
        }
    }

    public String getUsername() {
        return email;
    }
}
