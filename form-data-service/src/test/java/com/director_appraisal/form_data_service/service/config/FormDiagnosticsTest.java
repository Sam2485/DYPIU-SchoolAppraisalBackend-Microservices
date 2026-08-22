package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.dto.config.ApiErrorResponse;
import com.director_appraisal.form_data_service.exception.GlobalExceptionHandler;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;

import java.util.NoSuchElementException;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Form Data Service - Logging & Error Diagnostics Tests")
class FormDiagnosticsTest {

    private final GlobalExceptionHandler exceptionHandler = new GlobalExceptionHandler();

    @Test
    @DisplayName("Diagnostics: GlobalExceptionHandler returns structured ApiErrorResponse for NOT_FOUND")
    void testFormServiceNotFoundDiagnosticResponse() {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/api/config/schemas/999");
        request.addHeader("X-Correlation-Id", "corr-form-999");

        ResponseEntity<ApiErrorResponse> response = exceptionHandler.handleNotFound(
                new NoSuchElementException("Schema not found: 999"), request
        );

        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(404, response.getBody().getStatus());
        assertEquals("RESOURCE_NOT_FOUND", response.getBody().getCode());
        assertEquals("Schema not found: 999", response.getBody().getMessage());
        assertEquals("form-data-service", response.getBody().getService());
        assertEquals("/api/config/schemas/999", response.getBody().getPath());
        assertEquals("corr-form-999", response.getBody().getCorrelationId());
    }

    @Test
    @DisplayName("Diagnostics: GlobalExceptionHandler handles IllegalStateException properly")
    void testFormServiceIllegalStateDiagnosticResponse() {
        MockHttpServletRequest request = new MockHttpServletRequest("POST", "/api/admin/config/versions/10/publish");
        request.addHeader("X-Correlation-Id", "corr-publish-10");

        ResponseEntity<ApiErrorResponse> response = exceptionHandler.handleIllegalState(
                new IllegalStateException("Cannot publish version with zero sections"), request
        );

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals(400, response.getBody().getStatus());
        assertEquals("INVALID_STATE", response.getBody().getCode());
        assertEquals("Cannot publish version with zero sections", response.getBody().getMessage());
        assertEquals("form-data-service", response.getBody().getService());
    }
}
