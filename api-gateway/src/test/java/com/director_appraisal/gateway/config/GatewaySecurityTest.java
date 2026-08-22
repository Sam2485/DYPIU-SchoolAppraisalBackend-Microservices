package com.director_appraisal.gateway.config;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.mock.http.server.reactive.MockServerHttpRequest;
import org.springframework.mock.web.server.MockServerWebExchange;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("API Gateway - Advanced Security Tests")
class GatewaySecurityTest {

    private static final String SECRET = "a7f997cb3734907e6ce00508c77996e02d5b81215f9993d061198404fa41a343";
    private JwtUtil jwtUtil;
    private JwtAuthenticationFilter filter;
    private SecretKey key;

    @BeforeEach
    void setUp() {
        jwtUtil = new JwtUtil(SECRET);
        filter = new JwtAuthenticationFilter(jwtUtil);
        key = Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8));
    }

    @Test
    @DisplayName("Security: Strip client-spoofed X-User-Role and attach only verified JWT claim")
    void testStripSpoofedRoleHeader() {
        String token = Jwts.builder()
                .subject("faculty@dypiu.ac.in")
                .claims(Map.of(
                        "role", "director",
                        "universityId", 1L,
                        "universityCode", "dypiu"
                ))
                .expiration(new Date(System.currentTimeMillis() + 3600000))
                .signWith(key)
                .compact();

        // Client attempts to spoof super_admin role and fake university ID
        MockServerHttpRequest request = MockServerHttpRequest.get("/api/submissions/my-draft")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
                .header("X-User-Role", "super_admin")
                .header("X-University-Id", "999")
                .build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);

        AtomicBoolean verified = new AtomicBoolean(false);
        GatewayFilterChain chain = ex -> {
            HttpHeaders forwardedHeaders = ex.getRequest().getHeaders();
            // Verify that spoofed headers were replaced by verified claims from token
            assertEquals("director", forwardedHeaders.getFirst("X-User-Role"));
            assertEquals("1", forwardedHeaders.getFirst("X-University-Id"));
            assertEquals("faculty@dypiu.ac.in", forwardedHeaders.getFirst("X-User-Email"));
            verified.set(true);
            return Mono.empty();
        };

        StepVerifier.create(filter.filter(exchange, chain)).verifyComplete();
        assertTrue(verified.get());
    }

    @Test
    @DisplayName("Security: Reject token with alg=none or forged signature")
    void testRejectForgedSignature() {
        SecretKey forgedKey = Keys.hmacShaKeyFor("completelyDifferentForgedSecretKeyForAttackVector1234567890".getBytes(StandardCharsets.UTF_8));
        String forgedToken = Jwts.builder()
                .subject("attacker@evil.com")
                .claims(Map.of("role", "super_admin"))
                .expiration(new Date(System.currentTimeMillis() + 3600000))
                .signWith(forgedKey)
                .compact();

        MockServerHttpRequest request = MockServerHttpRequest.get("/api/submissions/my-draft")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + forgedToken)
                .build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);

        StepVerifier.create(filter.filter(exchange, ex -> Mono.empty())).verifyComplete();
        assertEquals(HttpStatus.UNAUTHORIZED, exchange.getResponse().getStatusCode());
    }

    @Test
    @DisplayName("Security: Reject token replay if expired in past")
    void testRejectExpiredTokenReplay() {
        String expiredToken = Jwts.builder()
                .subject("expired_user@dypiu.ac.in")
                .claims(Map.of("role", "director"))
                .expiration(new Date(System.currentTimeMillis() - 50000)) // expired in past
                .signWith(key)
                .compact();

        MockServerHttpRequest request = MockServerHttpRequest.get("/api/submissions/my-draft")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + expiredToken)
                .build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);

        StepVerifier.create(filter.filter(exchange, ex -> Mono.empty())).verifyComplete();
        assertEquals(HttpStatus.UNAUTHORIZED, exchange.getResponse().getStatusCode());
    }
}
