package com.director_appraisal.submission_service.config;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.context.annotation.Configuration;

@Slf4j
@Configuration
public class FeignCorrelationInterceptor implements RequestInterceptor {

    @Override
    public void apply(RequestTemplate template) {
        String correlationId = MDC.get(MdcLoggingFilter.MDC_CORRELATION_ID);
        if (correlationId != null && !correlationId.isBlank()) {
            template.header("X-Correlation-Id", correlationId);
        }

        String userEmail = MDC.get(MdcLoggingFilter.MDC_USER_EMAIL);
        if (userEmail != null) template.header("X-User-Email", userEmail);

        String userRole = MDC.get(MdcLoggingFilter.MDC_USER_ROLE);
        if (userRole != null) template.header("X-User-Role", userRole);

        String uniId = MDC.get(MdcLoggingFilter.MDC_UNIVERSITY_ID);
        if (uniId != null) template.header("X-University-Id", uniId);

        String uniCode = MDC.get(MdcLoggingFilter.MDC_UNIVERSITY_CODE);
        if (uniCode != null) template.header("X-University-Code", uniCode);

        log.info("[DOWNSTREAM_REQUEST] targetService={} method={} url={} correlationId={}",
                template.feignTarget() != null ? template.feignTarget().name() : "unknown",
                template.method(),
                template.url(),
                correlationId != null ? correlationId : "none");
    }
}
