package com.director_appraisal.admin_service.controller;

import com.director_appraisal.admin_service.dto.ApiErrorResponse;
import com.director_appraisal.admin_service.exception.GlobalExceptionHandler;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Admin Service - Logging & Diagnostics Tests")
class AdminDiagnosticsTest {

    private final GlobalExceptionHandler exceptionHandler = new GlobalExceptionHandler();

    @Test
    @DisplayName("Diagnostics: GlobalExceptionHandler produces 403 Forbidden with structured diagnostic body for unauthorized action")
    void testAdminSecurityExceptionDiagnosticResponse() {
        MockHttpServletRequest request = new MockHttpServletRequest("POST", "/api/backup/db/restore");
        request.addHeader("X-Correlation-Id", "corr-restore-unauth");

        ResponseEntity<ApiErrorResponse> response = exceptionHandler.handleSecurity(
                new SecurityException("Access denied. Admin privileges required."), request
        );

        assertEquals(HttpStatus.FORBIDDEN, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("admin-service", response.getBody().getService());
        assertEquals("corr-restore-unauth", response.getBody().getCorrelationId());
        assertEquals("ACCESS_DENIED", response.getBody().getCode());
        assertEquals("Access denied. Admin privileges required.", response.getBody().getMessage());
    }
}
