package com.director_appraisal.submission_service.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
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
    private String schoolName;
    private String role;
    private String accountType;
    private String category;
    private String auditCategory;
    private String auditorType;
    private String auditorRole;
    private String post;
    private String avatarUrl;

    @Builder.Default
    private Boolean deleted = false;

    @Builder.Default
    private String status = "active";

    @Builder.Default
    private List<String> schools = new ArrayList<>();

    @Builder.Default
    private List<String> administrativePosts = new ArrayList<>();

    @JsonProperty("schools")
    public void setSchools(Object schoolsObj) {
        if (schoolsObj == null) {
            this.schools = new ArrayList<>();
        } else if (schoolsObj instanceof List<?> list) {
            this.schools = list.stream().filter(o -> o != null).map(Object::toString).toList();
        } else if (schoolsObj instanceof String str) {
            if (str.isBlank()) {
                this.schools = new ArrayList<>();
            } else {
                this.schools = List.of(str.split(","));
            }
        } else {
            this.schools = List.of(schoolsObj.toString());
        }
    }

    @JsonProperty("administrativePosts")
    public void setAdministrativePosts(Object postsObj) {
        if (postsObj == null) {
            this.administrativePosts = new ArrayList<>();
        } else if (postsObj instanceof List<?> list) {
            this.administrativePosts = list.stream().filter(o -> o != null).map(Object::toString).toList();
        } else if (postsObj instanceof String str) {
            if (str.isBlank()) {
                this.administrativePosts = new ArrayList<>();
            } else {
                this.administrativePosts = List.of(str.split(","));
            }
        } else {
            this.administrativePosts = List.of(postsObj.toString());
        }
    }

    public List<String> getSchoolsList() {
        if (schools != null && !schools.isEmpty()) {
            return schools;
        }
        if (school != null && !school.isBlank()) {
            return List.of(school);
        }
        if (schoolName != null && !schoolName.isBlank()) {
            return List.of(schoolName);
        }
        return List.of();
    }

    public void setSchoolsList(List<String> list) {
        this.schools = (list != null) ? new ArrayList<>(list) : new ArrayList<>();
    }

    public Boolean getDeleted() {
        return deleted != null ? deleted : false;
    }

    public String getStatus() {
        return status != null ? status : "active";
    }

    public String getUsername() {
        return email;
    }
}
