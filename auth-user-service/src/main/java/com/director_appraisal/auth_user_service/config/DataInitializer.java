package com.director_appraisal.auth_user_service.config;

import com.director_appraisal.auth_user_service.model.User;
import com.director_appraisal.auth_user_service.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
@RequiredArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        saveOrUpdateUser("admin@dypiu.edu.in", "IQAC Admin", "iqac", "user", "administrative", "IQAC", "Administrative Office", null);
        saveOrUpdateUser("director@dypiu.edu.in", "SOCSEA Director", "director", "user", "academic", "Director", "SOCSEA", null);
        saveOrUpdateUser("hr@dypiu.edu.in", "HR Administrative", "administrative", "user", "administrative", "HR", "Administrative Office", "hr");
        saveOrUpdateUser("vc@dypiu.edu.in", "Vice Chancellor", "vice-chancellor", "user", "administrative", "Vice Chancellor", null, null);
    }

    private void saveOrUpdateUser(String email, String name, String role, String accountType, String category, String designation, String school, String post) {
        Optional<User> existingOpt = userRepository.findByEmail(email);
        User user = existingOpt.orElseGet(() -> User.builder().email(email).build());

        user.setName(name);
        user.setPassword(passwordEncoder.encode("password"));
        user.setRole(role);
        user.setAccountType(accountType);
        user.setCategory(category);
        user.setDesignation(designation);
        user.setSchool(school);
        user.setPost(post);
        user.setStatus("active");
        user.setDeleted(false);

        userRepository.save(user);
        log.info("Initialized / Reset password for user: {} ({})", email, role);
    }
}
