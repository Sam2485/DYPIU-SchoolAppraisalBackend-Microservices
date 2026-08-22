package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.controller.config.AdminConfigController;
import com.director_appraisal.form_data_service.model.config.FormSchema;
import com.director_appraisal.form_data_service.model.config.SchemaVersion;
import com.director_appraisal.form_data_service.repository.config.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Config Service - Schema Security & Tenant Isolation Tests")
class FormConfigSecurityTest {

    @Mock
    private FormSchemaRepository formSchemaRepository;
    @Mock
    private SchemaVersionRepository schemaVersionRepository;
    @Mock
    private FormSectionRepository formSectionRepository;
    @Mock
    private FormTableRepository formTableRepository;
    @Mock
    private FormFieldRepository formFieldRepository;
    @Mock
    private UniversityRepository universityRepository;
    @Mock
    private FormConfigService formConfigService;
    @Mock
    private SchemaCompilerService schemaCompilerService;

    private AdminConfigController adminConfigController;

    @BeforeEach
    void setUp() {
        adminConfigController = new AdminConfigController(
                formSchemaRepository,
                schemaVersionRepository,
                formSectionRepository,
                formTableRepository,
                formFieldRepository,
                universityRepository,
                formConfigService,
                schemaCompilerService,
                new ObjectMapper()
        );
    }

    @Test
    @DisplayName("Security: Reject schema creation attempt by non-admin role (e.g. faculty / contributor)")
    void testRejectNonAdminSchemaCreation() {
        FormSchema req = FormSchema.builder()
                .universityId(1L)
                .name("Malicious Schema Override")
                .auditType("academic")
                .build();

        assertThrows(SecurityException.class, () -> {
            adminConfigController.createSchema(req, "faculty");
        });
    }

    @Test
    @DisplayName("Security: Rollback must reject rolling back to non-existent or draft version")
    void testRejectRollbackToNonPublishedVersion() {
        FormSchema schema = FormSchema.builder().id(1L).activeVersionId(20L).build();
        SchemaVersion draftV = SchemaVersion.builder().id(30L).schemaId(1L).status("DRAFT").build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findById(30L)).thenReturn(Optional.of(draftV));

        FormConfigService realService = new FormConfigService(
                formSchemaRepository,
                schemaVersionRepository,
                formSectionRepository,
                formTableRepository,
                formFieldRepository,
                universityRepository,
                schemaCompilerService,
                new ObjectMapper()
        );

        assertThrows(IllegalStateException.class, () -> {
            realService.rollbackVersion(1L, 30L);
        });
    }
}
