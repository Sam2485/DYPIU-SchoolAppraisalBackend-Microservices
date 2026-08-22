package com.director_appraisal.submission_service.service;

import com.director_appraisal.submission_service.config.FeignCorrelationInterceptor;
import com.director_appraisal.submission_service.config.MdcLoggingFilter;
import com.director_appraisal.submission_service.dto.ApiErrorResponse;
import com.director_appraisal.submission_service.exception.GlobalExceptionHandler;
import feign.RequestTemplate;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;

import java.util.Collection;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Submission Service - Logging & Diagnostics Tests")
class SubmissionDiagnosticsTest {

    private final GlobalExceptionHandler exceptionHandler = new GlobalExceptionHandler();
    private final FeignCorrelationInterceptor feignInterceptor = new FeignCorrelationInterceptor();

    @Test
    @DisplayName("Diagnostics: FeignCorrelationInterceptor propagates correlation ID and tenant context downstream")
    void testFeignCorrelationPropagation() {
        MDC.put(MdcLoggingFilter.MDC_CORRELATION_ID, "corr-feign-xyz");
        MDC.put(MdcLoggingFilter.MDC_USER_EMAIL, "director@dypiu.ac.in");
        MDC.put(MdcLoggingFilter.MDC_UNIVERSITY_ID, "1");

        try {
            RequestTemplate template = new RequestTemplate();
            feignInterceptor.apply(template);

            Map<String, Collection<String>> headers = template.headers();
            assertTrue(headers.containsKey("X-Correlation-Id"));
            assertTrue(headers.get("X-Correlation-Id").contains("corr-feign-xyz"));
            assertTrue(headers.containsKey("X-User-Email"));
            assertTrue(headers.get("X-User-Email").contains("director@dypiu.ac.in"));
            assertTrue(headers.containsKey("X-University-Id"));
            assertTrue(headers.get("X-University-Id").contains("1"));
        } finally {
            MDC.clear();
        }
    }

    @Test
    @DisplayName("Diagnostics: GlobalExceptionHandler produces structured ApiErrorResponse")
    void testSubmissionServiceExceptionHandler() {
        MockHttpServletRequest request = new MockHttpServletRequest("POST", "/api/submissions/save-draft");
        request.addHeader("X-Correlation-Id", "corr-sub-diag-1");

        ResponseEntity<ApiErrorResponse> response = exceptionHandler.handleIllegalArgument(
                new IllegalArgumentException("Submission valuesData is missing required field"), request
        );

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("submission-service", response.getBody().getService());
        assertEquals("corr-sub-diag-1", response.getBody().getCorrelationId());
        assertEquals("INVALID_ARGUMENT", response.getBody().getCode());
        assertEquals("/api/submissions/save-draft", response.getBody().getPath());
    }
}
