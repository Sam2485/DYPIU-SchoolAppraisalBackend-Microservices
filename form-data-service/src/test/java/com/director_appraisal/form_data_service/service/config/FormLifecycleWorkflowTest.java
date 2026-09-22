package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.client.SubmissionServiceClient;
import com.director_appraisal.form_data_service.dto.config.CompiledSchemaDto;
import com.director_appraisal.form_data_service.dto.config.SectionDto;
import com.director_appraisal.form_data_service.model.config.*;
import com.director_appraisal.form_data_service.repository.config.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Data Service - Form Lifecycle, Version Migration & Rollback Workflow Tests")
class FormLifecycleWorkflowTest {

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
    private SchemaCompilerService schemaCompilerService;
    @Mock
    private SubmissionServiceClient submissionServiceClient;

    private FormConfigService formConfigService;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        formConfigService = new FormConfigService(
                formSchemaRepository,
                schemaVersionRepository,
                formSectionRepository,
                formTableRepository,
                formFieldRepository,
                schemaCompilerService,
                objectMapper,
                submissionServiceClient
        );
    }

    @Test
    @DisplayName("Lifecycle: Publish V1 -> Admin creates Draft V2 -> Active stays V1 -> Publish V2 updates active pointer")
    void testPublishDraftRepublishLifecycle() {
        // 1. Schema with active V1 published
        FormSchema schema = FormSchema.builder()
                .id(1L)
                .universityId(1L)
                .auditType("academic")
                .name("Academic Appraisal Form")
                .activeVersionId(10L)
                .activeVersionNumber(1)
                .status("ACTIVE")
                .build();

        SchemaVersion v1 = SchemaVersion.builder()
                .id(10L)
                .schemaId(1L)
                .versionNumber(1)
                .status("PUBLISHED")
                .title("Academic Appraisal Form V1")
                .academicYear("2024-25")
                .build();

        FormSection secV1 = FormSection.builder()
                .id(101L)
                .versionId(10L)
                .sectionKey("part_a")
                .title("Part A")
                .build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(1L)).thenReturn(new ArrayList<>(List.of(v1)));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(secV1));
        when(formFieldRepository.findBySectionIdAndTableIdIsNullOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of());
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of());

        // Save mock for creating draft V2
        when(schemaVersionRepository.save(any(SchemaVersion.class))).thenAnswer(inv -> {
            SchemaVersion v = inv.getArgument(0);
            if (v.getId() == null) v.setId(20L);
            return v;
        });
        when(formSectionRepository.save(any(FormSection.class))).thenAnswer(inv -> {
            FormSection s = inv.getArgument(0);
            if (s.getId() == null) s.setId(201L);
            return s;
        });

        // 2. Admin creates draft V2
        SchemaVersion draftV2 = formConfigService.createDraftVersion(1L, "admin@dypiu.ac.in");
        assertNotNull(draftV2);
        assertEquals(2, draftV2.getVersionNumber());
        assertEquals("DRAFT", draftV2.getStatus());

        // Verify that while V2 is in DRAFT, parent schema's activeVersionId is STILL V1 (10L)
        assertEquals(10L, schema.getActiveVersionId());
        assertEquals(1, schema.getActiveVersionNumber());

        // 3. Admin publishes V2
        when(schemaVersionRepository.findById(20L)).thenReturn(Optional.of(draftV2));
        FormSection secV2 = FormSection.builder().id(201L).versionId(20L).sectionKey("part_a").title("Part A").build();
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(20L)).thenReturn(List.of(secV2));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(201L)).thenReturn(List.of());

        CompiledSchemaDto compiledV2 = CompiledSchemaDto.builder()
                .schemaId(1L)
                .versionId(20L)
                .versionNumber(2)
                .title("Academic Appraisal Form V2")
                .sections(List.of(SectionDto.builder().id(201L).sectionKey("part_a").title("Part A").build()))
                .build();
        when(schemaCompilerService.compile(20L)).thenReturn(compiledV2);

        CompiledSchemaDto publishedResult = formConfigService.publishVersion(20L, "admin@dypiu.ac.in");
        assertNotNull(publishedResult);
        assertEquals("PUBLISHED", draftV2.getStatus());

        // 4. Verify parent schema activeVersionId is now updated to V2 (20L)
        assertEquals(20L, schema.getActiveVersionId());
        assertEquals(2, schema.getActiveVersionNumber());
        verify(formSchemaRepository).save(schema);
    }

    @Test
    @DisplayName("Rollback: Should rollback active version from V2 to V1")
    void testRollbackV2ToV1() {
        FormSchema schema = FormSchema.builder()
                .id(1L)
                .name("Appraisal Form")
                .activeVersionId(20L)
                .activeVersionNumber(2)
                .build();

        SchemaVersion v1 = SchemaVersion.builder()
                .id(10L)
                .schemaId(1L)
                .versionNumber(1)
                .status("PUBLISHED")
                .build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(v1));

        formConfigService.rollbackVersion(1L, 10L);

        assertEquals(10L, schema.getActiveVersionId());
        assertEquals(1, schema.getActiveVersionNumber());
        verify(formSchemaRepository).save(schema);
    }

    @Test
    @DisplayName("Rollback: Should reject rollback to a non-published (DRAFT) version with IllegalStateException")
    void testRollbackToDraftThrowsException() {
        FormSchema schema = FormSchema.builder().id(1L).activeVersionId(20L).build();
        SchemaVersion draftV3 = SchemaVersion.builder().id(30L).schemaId(1L).status("DRAFT").build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findById(30L)).thenReturn(Optional.of(draftV3));

        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> formConfigService.rollbackVersion(1L, 30L));
        assertTrue(ex.getMessage().contains("Cannot rollback to a non-published version"));
        verify(formSchemaRepository, never()).save(any());
    }

    @Test
    @DisplayName("Rollback: Should reject rollback if target version belongs to another schema")
    void testRollbackCrossSchemaThrowsException() {
        FormSchema schema = FormSchema.builder().id(1L).activeVersionId(20L).build();
        SchemaVersion otherSchemaVersion = SchemaVersion.builder().id(99L).schemaId(2L).status("PUBLISHED").build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findById(99L)).thenReturn(Optional.of(otherSchemaVersion));

        IllegalArgumentException ex = assertThrows(IllegalArgumentException.class, () -> formConfigService.rollbackVersion(1L, 99L));
        assertTrue(ex.getMessage().contains("Version does not belong to schema"));
        verify(formSchemaRepository, never()).save(any());
    }

    @Test
    @DisplayName("Delete Version Guard: Deleting active V2 with 0 submissions falls back activeVersion to V1")
    void testDeleteActiveVersionFallsBackToPreviousPublished() {
        FormSchema schema = FormSchema.builder()
                .id(1L)
                .activeVersionId(20L)
                .activeVersionNumber(2)
                .build();

        SchemaVersion v1 = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("PUBLISHED").build();
        SchemaVersion v2 = SchemaVersion.builder().id(20L).schemaId(1L).versionNumber(2).status("PUBLISHED").build();

        when(schemaVersionRepository.findById(20L)).thenReturn(Optional.of(v2));
        when(submissionServiceClient.countBySchemaVersion(List.of(20L))).thenReturn(Map.of("20", 0L));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(20L)).thenReturn(List.of());
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(1L)).thenReturn(List.of(v1));

        formConfigService.deleteVersion(20L);

        // Verify V2 was deleted
        verify(schemaVersionRepository).deleteById(20L);
        // Verify parent schema activeVersionId rolled back to V1
        assertEquals(10L, schema.getActiveVersionId());
        assertEquals(1, schema.getActiveVersionNumber());
        verify(formSchemaRepository).save(schema);
    }

    @Test
    @DisplayName("Delete Version Guard: Fail-closed with 409 Conflict when submission-service Feign client fails")
    void testDeleteVersionFailClosedOnSubmissionServiceError() {
        SchemaVersion v1 = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("PUBLISHED").build();
        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(v1));
        when(submissionServiceClient.countBySchemaVersion(List.of(10L))).thenThrow(new RuntimeException("503 Service Unavailable"));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> formConfigService.deleteVersion(10L));
        assertEquals(HttpStatus.CONFLICT, ex.getStatusCode());
        assertTrue(ex.getReason().contains("submission-service is unreachable"));
        verify(schemaVersionRepository, never()).deleteById(any());
    }

    @Test
    @DisplayName("Delete Schema Guard: Blocks deletion with 409 Conflict when submissions exist across any version")
    void testDeleteSchemaBlockedWhenSubmissionsExist() {
        FormSchema schema = FormSchema.builder().id(1L).name("Faculty Appraisal Form").build();
        SchemaVersion v1 = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).build();
        SchemaVersion v2 = SchemaVersion.builder().id(20L).schemaId(1L).versionNumber(2).build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(1L)).thenReturn(List.of(v2, v1));
        when(submissionServiceClient.countBySchemaVersion(List.of(20L, 10L))).thenReturn(Map.of("10", 12L, "20", 0L));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> formConfigService.deleteSchema(1L));
        assertEquals(HttpStatus.CONFLICT, ex.getStatusCode());
        assertTrue(ex.getReason().contains("This schema has 12 submissions and cannot be deleted."));
        verify(formSchemaRepository, never()).deleteById(any());
    }
}
