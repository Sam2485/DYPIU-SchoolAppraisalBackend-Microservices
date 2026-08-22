package com.director_appraisal.admin_service.exception;

import com.director_appraisal.admin_service.config.MdcLoggingFilter;
import com.director_appraisal.admin_service.dto.ApiErrorResponse;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.Instant;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final String SERVICE_NAME = "admin-service";

    @ExceptionHandler(SecurityException.class)
    public ResponseEntity<ApiErrorResponse> handleSecurity(SecurityException e, HttpServletRequest req) {
        log.warn("[SECURITY_VIOLATION] path={} message={}", req.getRequestURI(), e.getMessage());
        return build(HttpStatus.FORBIDDEN, "ACCESS_DENIED", e.getMessage(), req, null);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ApiErrorResponse> handleIllegalArgument(IllegalArgumentException e, HttpServletRequest req) {
        log.warn("[BAD_REQUEST] path={} message={}", req.getRequestURI(), e.getMessage());
        return build(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", e.getMessage(), req, null);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiErrorResponse> handleGeneralException(Exception e, HttpServletRequest req) {
        Throwable rootCause = getRootCause(e);
        log.error("[UNHANDLED_ERROR] path={} exception={} message={} rootCauseClass={} rootCauseMsg={}",
                req.getRequestURI(), e.getClass().getName(), e.getMessage(),
                rootCause.getClass().getName(), rootCause.getMessage(), e);
        return build(HttpStatus.INTERNAL_SERVER_ERROR, "INTERNAL_SERVER_ERROR",
                "Backup/Restore operation failed. Please check server logs.", req, null);
    }

    private ResponseEntity<ApiErrorResponse> build(HttpStatus status, String code, String message,
                                                   HttpServletRequest req, Object details) {
        String correlationId = MDC.get(MdcLoggingFilter.MDC_CORRELATION_ID);
        if (correlationId == null || correlationId.isBlank()) {
            correlationId = req.getHeader(MdcLoggingFilter.CORRELATION_ID_HEADER);
        }

        ApiErrorResponse response = ApiErrorResponse.builder()
                .timestamp(Instant.now().toString())
                .status(status.value())
                .error(status.getReasonPhrase())
                .code(code)
                .message(message)
                .service(SERVICE_NAME)
                .path(req != null ? req.getRequestURI() : "unknown")
                .correlationId(correlationId)
                .details(details)
                .build();

        return ResponseEntity.status(status).body(response);
    }

    private Throwable getRootCause(Throwable throwable) {
        Throwable cause = throwable;
        while (cause.getCause() != null && cause.getCause() != cause) {
            cause = cause.getCause();
        }
        return cause;
    }
}
