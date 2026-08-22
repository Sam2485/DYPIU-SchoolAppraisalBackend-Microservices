package com.director_appraisal.form_data_service.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.UUID;

@Slf4j
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class MdcLoggingFilter extends OncePerRequestFilter {

    public static final String CORRELATION_ID_HEADER = "X-Correlation-Id";
    public static final String MDC_CORRELATION_ID = "correlationId";
    public static final String MDC_SERVICE = "service";
    public static final String MDC_USER_EMAIL = "userEmail";
    public static final String MDC_USER_ROLE = "userRole";
    public static final String MDC_UNIVERSITY_ID = "universityId";
    public static final String MDC_UNIVERSITY_CODE = "universityCode";
    public static final String SERVICE_NAME = "form-data-service";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String correlationId = request.getHeader(CORRELATION_ID_HEADER);
        if (correlationId == null || correlationId.isBlank()) {
            correlationId = request.getHeader("X-Correlation-ID");
        }
        if (correlationId == null || correlationId.isBlank()) {
            correlationId = request.getHeader("X-Request-Id");
        }
        if (correlationId == null || correlationId.isBlank() || correlationId.length() > 64) {
            correlationId = UUID.randomUUID().toString();
        }

        String userEmail = request.getHeader("X-User-Email");
        String userRole = request.getHeader("X-User-Role");
        String uniId = request.getHeader("X-University-Id");
        String uniCode = request.getHeader("X-University-Code");

        MDC.put(MDC_CORRELATION_ID, correlationId);
        MDC.put(MDC_SERVICE, SERVICE_NAME);
        if (userEmail != null) MDC.put(MDC_USER_EMAIL, userEmail);
        if (userRole != null) MDC.put(MDC_USER_ROLE, userRole);
        if (uniId != null) MDC.put(MDC_UNIVERSITY_ID, uniId);
        if (uniCode != null) MDC.put(MDC_UNIVERSITY_CODE, uniCode);

        response.setHeader(CORRELATION_ID_HEADER, correlationId);

        long startTime = System.currentTimeMillis();
        String method = request.getMethod();
        String uri = request.getRequestURI();
        String query = request.getQueryString() != null ? "?" + request.getQueryString() : "";

        log.info("[REQUEST_START] correlationId={} service={} method={} path={}{} user={} role={} uniId={}",
                correlationId, SERVICE_NAME, method, uri, query,
                userEmail != null ? userEmail : "anonymous",
                userRole != null ? userRole : "none",
                uniId != null ? uniId : "none");

        try {
            filterChain.doFilter(request, response);
        } finally {
            long duration = System.currentTimeMillis() - startTime;
            int status = response.getStatus();
            log.info("[REQUEST_END] correlationId={} service={} method={} path={} status={} durationMs={}",
                    correlationId, SERVICE_NAME, method, uri, status, duration);

            if (duration > 2000) {
                log.warn("[REQUEST_SLOW] correlationId={} service={} method={} path={} durationMs={} thresholdMs=2000",
                        correlationId, SERVICE_NAME, method, uri, duration);
            }
            MDC.clear();
        }
    }
}
