package com.director_appraisal.form_data_service.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@FeignClient(name = "submission-service", url = "${app.services.submission-url:${SUBMISSION_SERVICE_URL:http://localhost:9003}}")
public interface SubmissionServiceClient {

    @GetMapping("/api/internal/submissions/count-by-schema-version")
    Map<String, Long> countBySchemaVersion(@RequestParam(value = "versionIds", required = false) List<Long> versionIds);
}
