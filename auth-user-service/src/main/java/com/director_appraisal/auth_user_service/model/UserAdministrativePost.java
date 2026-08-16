package com.director_appraisal.auth_user_service.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "user_administrative_posts")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserAdministrativePost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long userId;
    private String post;
}
