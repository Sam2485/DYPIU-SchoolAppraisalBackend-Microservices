package com.director_appraisal.auth_user_service.service;

import com.director_appraisal.auth_user_service.dto.ApiErrorResponse;
import com.director_appraisal.auth_user_service.exception.GlobalExceptionHandler;
import com.director_appraisal.auth_user_service.util.LoggingSanitizer;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Auth User Service - Logging & Error Diagnostics Tests")
class LoggingAndDiagnosticsTest {

    private final GlobalExceptionHandler exceptionHandler = new GlobalExceptionHandler();

    @Test
    @DisplayName("Diagnostics: LoggingSanitizer properly masks passwords, tokens, and secrets")
    void testLoggingSanitizerMasksSensitiveData() {
        String sensitiveJson = "{\"email\":\"user@dypiu.ac.in\",\"password\":\"SuperSecret123!\",\"token\":\"eyJhbGciOi...\",\"refreshToken\":\"ref-xyz\"}";
        String sanitized = LoggingSanitizer.sanitize(sensitiveJson);

        assertNotNull(sanitized);
        assertFalse(sanitized.contains("SuperSecret123!"));
        assertFalse(sanitized.contains("eyJhbGciOi..."));
        assertFalse(sanitized.contains("ref-xyz"));
        assertTrue(sanitized.contains("[REDACTED]"));
        assertTrue(sanitized.contains("user@dypiu.ac.in"));
    }

    @Test
    @DisplayName("Diagnostics: GlobalExceptionHandler returns structured ApiErrorResponse with correlationId")
    void testExceptionHandlerReturnsStructuredApiErrorResponse() {
        MockHttpServletRequest request = new MockHttpServletRequest("POST", "/api/auth/login");
        request.addHeader("X-Correlation-Id", "corr-test-12345");

        ResponseEntity<ApiErrorResponse> response = exceptionHandler.handleIllegalArgument(
                new IllegalArgumentException("Invalid credentials format"), request
        );

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(400, response.getBody().getStatus());
        assertEquals("INVALID_ARGUMENT", response.getBody().getCode());
        assertEquals("Invalid credentials format", response.getBody().getMessage());
        assertEquals("auth-user-service", response.getBody().getService());
        assertEquals("/api/auth/login", response.getBody().getPath());
        assertEquals("corr-test-12345", response.getBody().getCorrelationId());
        assertNotNull(response.getBody().getTimestamp());
    }
}
