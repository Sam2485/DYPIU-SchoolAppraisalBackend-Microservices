package com.director_appraisal.storage_service.service;

import com.director_appraisal.storage_service.dto.ApiErrorResponse;
import com.director_appraisal.storage_service.exception.GlobalExceptionHandler;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Storage Service - Logging & Diagnostics Tests")
class StorageDiagnosticsTest {

    private final GlobalExceptionHandler exceptionHandler = new GlobalExceptionHandler();

    @Test
    @DisplayName("Diagnostics: GlobalExceptionHandler produces 413 Payload Too Large with structured diagnostic body")
    void testStoragePayloadTooLargeDiagnosticResponse() {
        MockHttpServletRequest request = new MockHttpServletRequest("POST", "/api/attachments/upload");
        request.addHeader("X-Correlation-Id", "corr-upload-large");

        ResponseEntity<ApiErrorResponse> response = exceptionHandler.handleMaxUploadSize(
                new MaxUploadSizeExceededException(25 * 1024 * 1024L), request
        );

        assertEquals(HttpStatus.PAYLOAD_TOO_LARGE, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("storage-service", response.getBody().getService());
        assertEquals("corr-upload-large", response.getBody().getCorrelationId());
        assertEquals("ATTACHMENT_TOO_LARGE", response.getBody().getCode());
        assertEquals(413, response.getBody().getStatus());
    }
}
