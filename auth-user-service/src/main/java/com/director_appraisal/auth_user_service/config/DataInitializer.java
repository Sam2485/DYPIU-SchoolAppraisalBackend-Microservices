package com.director_appraisal.auth_user_service.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * DataInitializer disabled - production relies on real database backup records.
 */
@Component
public class DataInitializer implements CommandLineRunner {

    @Override
    public void run(String... args) {
        // No-op: Data is loaded from the restored database backup
    }
}

