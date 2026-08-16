package com.director_appraisal.auth_user_service.repository;

import com.director_appraisal.auth_user_service.model.UserAdministrativePost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface UserAdministrativePostRepository extends JpaRepository<UserAdministrativePost, Long> {
    List<UserAdministrativePost> findByUserId(Long userId);
    boolean existsByUserIdAndPost(Long userId, String post);
    @Transactional
    void deleteByUserId(Long userId);
}
