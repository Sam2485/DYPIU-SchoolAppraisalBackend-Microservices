package com.director_appraisal.auth_user_service.service;

import com.director_appraisal.auth_user_service.model.User;
import com.director_appraisal.auth_user_service.repository.PasswordResetTokenRepository;
import com.director_appraisal.auth_user_service.repository.UserAdministrativePostRepository;
import com.director_appraisal.auth_user_service.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Auth User Service - Security & Password Hardening Tests")
class AuthSecurityTest {

    @Mock
    private UserRepository userRepository;
    @Mock
    private PasswordResetTokenRepository resetTokenRepository;
    @Mock
    private UserAdministrativePostRepository userAdministrativePostRepository;
    @Mock
    private EmailService emailService;

    private PasswordEncoder passwordEncoder;
    private UserService userService;

    @BeforeEach
    void setUp() {
        passwordEncoder = new BCryptPasswordEncoder(10);
        userService = new UserService(
                userRepository,
                resetTokenRepository,
                userAdministrativePostRepository,
                passwordEncoder,
                emailService,
                "http://localhost:5173"
        );
    }

    @Test
    @DisplayName("Security: Passwords must be hashed using strong BCrypt, never stored as plain text")
    void testPasswordHashingSecurity() {
        User rawUser = User.builder()
                .email("newuser@dypiu.ac.in")
                .password("plainTextPassword123!")
                .role("director")
                .build();

        when(userRepository.findByEmail("newuser@dypiu.ac.in")).thenReturn(Optional.empty());
        when(userRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        User created = userService.createUser(rawUser);

        assertNotEquals("plainTextPassword123!", created.getPassword());
        assertTrue(created.getPassword().startsWith("$2a$") || created.getPassword().startsWith("$2b$"));
        assertTrue(userService.checkPassword("plainTextPassword123!", created.getPassword()));
        assertFalse(userService.checkPassword("wrongPasswordAttempt", created.getPassword()));
    }

    @Test
    @DisplayName("Security: Rate Limiter blocks brute-force login attempts exceeding threshold")
    void testRateLimiterBruteForceProtection() {
        RateLimiterService rateLimiter = new RateLimiterService();
        String ip = "192.168.1.50";
        String email = "target@dypiu.ac.in";

        // Attempt 5 failed attempts (limit is 5)
        for (int i = 0; i < 5; i++) {
            RateLimiterService.RateLimitResult res = rateLimiter.checkLimit(ip, email, "LOGIN");
            assertTrue(res.isAllowed());
        }

        // 6th attempt must be BLOCKED
        RateLimiterService.RateLimitResult blockedRes = rateLimiter.checkLimit(ip, email, "LOGIN");
        assertFalse(blockedRes.isAllowed(), "Brute-force attack must be blocked after 5 attempts");
        assertTrue(blockedRes.getRetryAfterSeconds() > 0);
    }
}
