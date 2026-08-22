package com.director_appraisal.auth_user_service.service;

import com.director_appraisal.auth_user_service.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Auth User Service - JwtService Tests")
class JwtServiceTest {

    private static final String SECRET = "a7f997cb3734907e6ce00508c77996e02d5b81215f9993d061198404fa41a343";
    private JwtService jwtService;

    @BeforeEach
    void setUp() {
        jwtService = new JwtService(SECRET, 3600000);
    }

    @Test
    @DisplayName("Should generate token with user details and custom tenant claims")
    void testGenerateToken() {
        User user = User.builder()
                .id(10L)
                .email("user@dypiu.ac.in")
                .password("encodedPassword")
                .role("director")
                .school("School of Engineering")
                .universityId(1L)
                .universityCode("dypiu")
                .build();

        String token = jwtService.generateToken(user, Map.of(
                "universityId", 1L,
                "universityCode", "dypiu",
                "role", "director"
        ));

        assertNotNull(token);
        assertTrue(jwtService.validateToken(token, user));
        assertEquals("user@dypiu.ac.in", jwtService.extractUsername(token));
    }
}
