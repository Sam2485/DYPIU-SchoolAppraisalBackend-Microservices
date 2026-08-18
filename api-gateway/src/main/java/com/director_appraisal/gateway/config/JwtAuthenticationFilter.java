package com.director_appraisal.gateway.config;

import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.nio.charset.StandardCharsets;
import java.util.List;

@Component
public class JwtAuthenticationFilter implements GlobalFilter, Ordered {

    private final JwtUtil jwtUtil;

    public JwtAuthenticationFilter(JwtUtil jwtUtil) {
        this.jwtUtil = jwtUtil;
    }

    private static final List<String> PUBLIC_ENDPOINTS = List.of(
            "/api/auth/login",
            "/api/auth/register",
            "/api/auth/refresh",
            "/api/auth/forgot-password",
            "/api/auth/reset-password",
            "/api/auth/verify-otp",
            "/api/auth/mfa"
    );

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();
        String path = request.getURI().getPath();

        // 1. Allow OPTIONS requests (CORS preflight)
        if (request.getMethod() == HttpMethod.OPTIONS) {
            return chain.filter(exchange);
        }

        // 2. Allow public auth endpoints
        if (isPublicEndpoint(path)) {
            return chain.filter(exchange);
        }

        // 3. Check for Authorization header
        String authHeader = request.getHeaders().getFirst(HttpHeaders.AUTHORIZATION);
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return onError(exchange, "Authorization token is missing.", HttpStatus.UNAUTHORIZED);
        }

        String token = authHeader.substring(7).trim();

        // 4. Validate token
        if (!jwtUtil.validateToken(token)) {
            return onError(exchange, "Invalid or expired authorization token.", HttpStatus.UNAUTHORIZED);
        }

        // 5. Extract user email and attach X-User-Email header
        String userEmail = jwtUtil.extractEmail(token);
        ServerHttpRequest modifiedRequest = request.mutate()
                .header("X-User-Email", userEmail != null ? userEmail : "")
                .build();

        return chain.filter(exchange.mutate().request(modifiedRequest).build());
    }

    private boolean isPublicEndpoint(String path) {
        if (path == null) return false;
        if (path.startsWith("/api/auth/") || path.equals("/api/auth") || path.startsWith("/uploads/") || path.startsWith("/api/attachments/public/")) {
            return true;
        }
        return PUBLIC_ENDPOINTS.stream().anyMatch(endpoint -> path.equalsIgnoreCase(endpoint) || path.startsWith(endpoint + "/"));
    }


    private Mono<Void> onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);

        String jsonResponse = String.format("{\"success\":false,\"message\":\"%s\"}", err);
        byte[] bytes = jsonResponse.getBytes(StandardCharsets.UTF_8);
        DataBuffer buffer = response.bufferFactory().wrap(bytes);

        return response.writeWith(Mono.just(buffer));
    }

    @Override
    public int getOrder() {
        return -1; // Run before routing
    }
}
