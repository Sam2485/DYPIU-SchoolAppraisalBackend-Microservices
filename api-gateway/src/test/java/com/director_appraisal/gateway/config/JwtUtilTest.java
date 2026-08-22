package com.director_appraisal.gateway.config;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("API Gateway - JwtUtil Tests")
class JwtUtilTest {

    private static final String SECRET = "a7f997cb3734907e6ce00508c77996e02d5b81215f9993d061198404fa41a343";
    private JwtUtil jwtUtil;
    private SecretKey key;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil(SECRET);
        key = Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8));
    }

    @Test
    @DisplayName("Should extract email and role correctly from valid token")
    void testExtractEmailAndRole() {
        String token = Jwts.builder()
                .subject("director@dypiu.ac.in")
                .claims(Map.of(
                        "role", "director",
                        "name", "Dr. Director",
                        "school", "School of Computing",
                        "universityId", 1L,
                        "universityCode", "dypiu"
                ))
                .expiration(new Date(System.currentTimeMillis() + 3600000))
                .signWith(key)
                .compact();

        assertTrue(jwtUtil.validateToken(token));
        assertEquals("director@dypiu.ac.in", jwtUtil.extractEmail(token));
        assertEquals("director", jwtUtil.extractRole(token));
        assertEquals("Dr. Director", jwtUtil.extractName(token));
        assertEquals("School of Computing", jwtUtil.extractSchool(token));
        assertEquals("1", jwtUtil.extractUniversityId(token));
        assertEquals("dypiu", jwtUtil.extractUniversityCode(token));
    }

    @Test
    @DisplayName("Should reject expired token")
    void testExpiredToken() {
        String token = Jwts.builder()
                .subject("expired@dypiu.ac.in")
                .expiration(new Date(System.currentTimeMillis() - 1000)) // expired in past
                .signWith(key)
                .compact();

        assertFalse(jwtUtil.validateToken(token));
    }

    @Test
    @DisplayName("Should reject token with wrong signature")
    void testTamperedSignatureToken() {
        SecretKey wrongKey = Keys.hmacShaKeyFor("differentSecretKeyForTestingMustBeAtLeast256BitsLong123456789".getBytes(StandardCharsets.UTF_8));
        String token = Jwts.builder()
                .subject("attacker@dypiu.ac.in")
                .expiration(new Date(System.currentTimeMillis() + 3600000))
                .signWith(wrongKey)
                .compact();

        assertFalse(jwtUtil.validateToken(token));
    }

    @Test
    @DisplayName("Should safely handle missing university claims with default fallback")
    void testLegacyTokenFallback() {
        String token = Jwts.builder()
                .subject("legacy@dypiu.ac.in")
                .claims(Map.of("role", "director"))
                .expiration(new Date(System.currentTimeMillis() + 3600000))
                .signWith(key)
                .compact();

        assertTrue(jwtUtil.validateToken(token));
        assertEquals("1", jwtUtil.extractUniversityId(token));
        assertEquals("dypiu", jwtUtil.extractUniversityCode(token));
    }
}
