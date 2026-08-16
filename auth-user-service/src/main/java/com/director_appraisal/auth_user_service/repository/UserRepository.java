package com.director_appraisal.auth_user_service.repository;

import com.director_appraisal.auth_user_service.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    java.util.List<User> findByAccountType(String accountType);
}
