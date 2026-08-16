package com.director_appraisal.auth_user_service.repository;

import com.director_appraisal.auth_user_service.model.MfaLoginSession;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface MfaLoginSessionRepository extends JpaRepository<MfaLoginSession, String> {
    void deleteByExpiresAtBefore(LocalDateTime now);
}
