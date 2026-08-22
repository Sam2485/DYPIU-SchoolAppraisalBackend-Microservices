package com.director_appraisal.submission_service.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Map;

@FeignClient(name = "form-data-service", url = "${FORMS_SERVICE_URL:http://localhost:9002}")
public interface FormDataClient {


    @GetMapping("/api/academic-year/info")
    Map<String, Object> getAcademicYearInfo();

    @GetMapping("/api/config/active")
    Map<String, Object> getActiveConfig(
            @org.springframework.web.bind.annotation.RequestParam("auditType") String auditType,
            @org.springframework.web.bind.annotation.RequestParam(value = "universityCode", required = false) String universityCode);

    @GetMapping("/api/config/version/{versionId}")
    Map<String, Object> getConfigByVersion(@org.springframework.web.bind.annotation.PathVariable("versionId") Long versionId);
}

