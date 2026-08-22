package com.director_appraisal.gateway.config;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
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

@DisplayName("API Gateway - JwtAuthenticationFilter Tests")
class JwtAuthenticationFilterTest {

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
    @DisplayName("Should pass OPTIONS preflight requests without authentication")
    void testOptionsRequestPasses() {
        MockServerHttpRequest request = MockServerHttpRequest.method(HttpMethod.OPTIONS, "/api/submissions/my-draft").build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);
        AtomicBoolean chainCalled = new AtomicBoolean(false);
        GatewayFilterChain chain = ex -> {
            chainCalled.set(true);
            return Mono.empty();
        };

        StepVerifier.create(filter.filter(exchange, chain)).verifyComplete();
        assertTrue(chainCalled.get());
    }

    @Test
    @DisplayName("Should pass public endpoints (/api/auth/login, /uploads/**) without token")
    void testPublicEndpointsPass() {
        MockServerHttpRequest request = MockServerHttpRequest.get("/api/auth/login").build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);
        AtomicBoolean chainCalled = new AtomicBoolean(false);
        GatewayFilterChain chain = ex -> {
            chainCalled.set(true);
            return Mono.empty();
        };

        StepVerifier.create(filter.filter(exchange, chain)).verifyComplete();
        assertTrue(chainCalled.get());
    }

    @Test
    @DisplayName("Should return 401 Unauthorized if Authorization header is missing on protected endpoint")
    void testMissingAuthHeaderReturns401() {
        MockServerHttpRequest request = MockServerHttpRequest.get("/api/submissions/my-draft").build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);
        GatewayFilterChain chain = ex -> Mono.empty();

        StepVerifier.create(filter.filter(exchange, chain)).verifyComplete();
        assertEquals(HttpStatus.UNAUTHORIZED, exchange.getResponse().getStatusCode());
    }

    @Test
    @DisplayName("Should return 401 Unauthorized if token is invalid or expired")
    void testInvalidTokenReturns401() {
        MockServerHttpRequest request = MockServerHttpRequest.get("/api/submissions/my-draft")
                .header(HttpHeaders.AUTHORIZATION, "Bearer invalid.token.value")
                .build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);
        GatewayFilterChain chain = ex -> Mono.empty();

        StepVerifier.create(filter.filter(exchange, chain)).verifyComplete();
        assertEquals(HttpStatus.UNAUTHORIZED, exchange.getResponse().getStatusCode());
    }

    @Test
    @DisplayName("Should validate valid JWT and forward X-User-Email, X-User-Role, X-University-Id, and X-University-Code")
    void testValidJwtAttachesDownstreamHeaders() {
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

        MockServerHttpRequest request = MockServerHttpRequest.get("/api/submissions/my-draft")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
                .build();
        MockServerWebExchange exchange = MockServerWebExchange.from(request);

        AtomicBoolean chainCalled = new AtomicBoolean(false);
        GatewayFilterChain chain = ex -> {
            chainCalled.set(true);
            HttpHeaders headers = ex.getRequest().getHeaders();
            assertEquals("director@dypiu.ac.in", headers.getFirst("X-User-Email"));
            assertEquals("director", headers.getFirst("X-User-Role"));
            assertEquals("School of Computing", headers.getFirst("X-User-School"));
            assertEquals("Dr. Director", headers.getFirst("X-User-Name"));
            assertEquals("1", headers.getFirst("X-University-Id"));
            assertEquals("dypiu", headers.getFirst("X-University-Code"));
            return Mono.empty();
        };

        StepVerifier.create(filter.filter(exchange, chain)).verifyComplete();
        assertTrue(chainCalled.get());
    }
}
