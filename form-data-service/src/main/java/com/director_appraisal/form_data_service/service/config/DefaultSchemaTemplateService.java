package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.model.config.University;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class DefaultSchemaTemplateService {

    @Transactional
    public void seedDefaultTemplatesForUniversity(University university) {
        // No-op: Schemas are managed dynamically via Appraisal Form Studio
    }
}
