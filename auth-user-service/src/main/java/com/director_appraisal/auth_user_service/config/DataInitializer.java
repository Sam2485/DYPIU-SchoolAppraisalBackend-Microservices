package com.director_appraisal.auth_user_service.config;

import com.director_appraisal.auth_user_service.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;

    @Override
    public void run(String... args) {
        try {
            userRepository.findAll().forEach(u -> {
                boolean changed = false;
                if (u.getUniversityId() == null) {
                    u.setUniversityId(1L);
                    changed = true;
                }
                if (u.getUniversityCode() == null || u.getUniversityCode().isBlank()) {
                    u.setUniversityCode("dypiu");
                    changed = true;
                }
                if (changed) {
                    userRepository.save(u);
                }
            });
            log.info("Verified all existing users have tenant university assigned.");
        } catch (Exception e) {
            log.warn("Could not verify user tenant initialization: {}", e.getMessage());
        }
    }
}


