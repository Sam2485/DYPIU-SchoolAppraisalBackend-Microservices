package com.director_appraisal.form_data_service.service.config;

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

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

import com.director_appraisal.form_data_service.client.SubmissionServiceClient;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.Map;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Config Service - FormConfigService Tests")
class FormConfigServiceTest {

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
    @DisplayName("Should create draft version and clone existing sections and tables")
    void testCreateDraftVersion() {
        FormSchema schema = FormSchema.builder()
                .id(1L)
                .universityId(1L)
                .auditType("academic")
                .name("Academic Audit")
                .activeVersionNumber(1)
                .activeVersionId(10L)
                .build();

        SchemaVersion sourceV1 = SchemaVersion.builder()
                .id(10L)
                .schemaId(1L)
                .versionNumber(1)
                .status("PUBLISHED")
                .academicYear("2025-26")
                .build();

        FormSection sec = FormSection.builder()
                .id(100L)
                .versionId(10L)
                .sectionKey("part-a")
                .title("Part A")
                .build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(1L)).thenReturn(List.of(sourceV1));
        when(schemaVersionRepository.save(any())).thenAnswer(inv -> {
            SchemaVersion v = inv.getArgument(0);
            v.setId(20L);
            return v;
        });

        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(sec));
        when(formSectionRepository.save(any())).thenAnswer(inv -> {
            FormSection s = inv.getArgument(0);
            s.setId(200L);
            return s;
        });
        when(formFieldRepository.findBySectionIdAndTableIdIsNullOrderByDisplayOrderAscIdAsc(100L)).thenReturn(List.of());
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(100L)).thenReturn(List.of());

        SchemaVersion draft = formConfigService.createDraftVersion(1L, "admin");
        assertNotNull(draft);
        assertEquals(2, draft.getVersionNumber());
        assertEquals("DRAFT", draft.getStatus());
        verify(formSectionRepository, atLeastOnce()).save(any());
    }

    @Test
    @DisplayName("Should validate schema and publish version successfully")
    void testPublishVersionSuccess() {
        FormSchema schema = FormSchema.builder()
                .id(1L)
                .universityId(1L)
                .auditType("academic")
                .name("Academic Audit")
                .build();

        SchemaVersion draft = SchemaVersion.builder()
                .id(20L)
                .schemaId(1L)
                .versionNumber(2)
                .status("DRAFT")
                .build();

        FormSection sec = FormSection.builder()
                .id(200L)
                .versionId(20L)
                .sectionKey("part-a")
                .title("Part A")
                .ownerRole("auditor")
                .build();

        FormTable tbl = FormTable.builder()
                .id(300L)
                .sectionId(200L)
                .tableKey("table1")
                .title("Table 1")
                .build();

        FormField col = FormField.builder()
                .id(400L)
                .sectionId(200L)
                .tableId(300L)
                .fieldKey("col1")
                .label("Column 1")
                .build();

        when(schemaVersionRepository.findById(20L)).thenReturn(Optional.of(draft));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(20L)).thenReturn(List.of(sec));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(200L)).thenReturn(List.of(tbl));
        when(formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(300L)).thenReturn(List.of(col));

        CompiledSchemaDto compiledDto = CompiledSchemaDto.builder()
                .schemaId(1L)
                .versionId(20L)
                .versionNumber(2)
                .title("Academic Audit V2")
                .sections(List.of(SectionDto.builder().id(200L).sectionKey("part-a").build()))
                .build();

        when(schemaCompilerService.compile(20L)).thenReturn(compiledDto);

        CompiledSchemaDto result = formConfigService.publishVersion(20L, "admin");
        assertNotNull(result);
        assertEquals("PUBLISHED", draft.getStatus());
        assertEquals(20L, schema.getActiveVersionId());
        assertEquals(2, schema.getActiveVersionNumber());
        verify(schemaVersionRepository).save(draft);
        verify(formSchemaRepository).save(schema);
    }

    @Test
    @DisplayName("Should throw exception when attempting to publish schema without Auditor section")
    void testPublishWithoutAuditorSectionThrows() {
        FormSchema schema = FormSchema.builder().id(1L).build();
        SchemaVersion draft = SchemaVersion.builder().id(20L).schemaId(1L).build();
        FormSection sec = FormSection.builder()
                .id(200L)
                .versionId(20L)
                .sectionKey("part-a")
                .title("Part A")
                .ownerRole("director-schools")
                .build();

        when(schemaVersionRepository.findById(20L)).thenReturn(Optional.of(draft));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(20L)).thenReturn(List.of(sec));

        org.springframework.web.server.ResponseStatusException ex = assertThrows(
                org.springframework.web.server.ResponseStatusException.class,
                () -> formConfigService.publishVersion(20L, "admin")
        );
        assertTrue(ex.getReason().contains("Auditor"));
    }

    @Test
    @DisplayName("Should throw exception when attempting to publish schema with 0 sections")
    void testPublishEmptySchemaThrows() {
        FormSchema schema = FormSchema.builder().id(1L).build();
        SchemaVersion draft = SchemaVersion.builder().id(20L).schemaId(1L).build();

        when(schemaVersionRepository.findById(20L)).thenReturn(Optional.of(draft));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(20L)).thenReturn(List.of()); // 0 sections

        assertThrows(IllegalStateException.class, () -> formConfigService.publishVersion(20L, "admin"));
    }

    @Test
    @DisplayName("Should rollback active version to previous published version")
    void testRollbackVersion() {
        FormSchema schema = FormSchema.builder()
                .id(1L)
                .activeVersionId(20L)
                .activeVersionNumber(2)
                .name("Academic Audit")
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
    @DisplayName("Should compile version with real SchemaCompilerService even if 0 sections and universityId null")
    void testRealSchemaCompilerService() {
        SchemaCompilerService compiler = new SchemaCompilerService(
                formSchemaRepository,
                schemaVersionRepository,
                formSectionRepository,
                formTableRepository,
                formFieldRepository,
                universityRepository,
                objectMapper
        );

        FormSchema schema = FormSchema.builder()
                .id(5L)
                .name("Part A")
                .auditType("academic")
                .universityId(null)
                .build();

        SchemaVersion draftV1 = SchemaVersion.builder()
                .id(5L)
                .schemaId(5L)
                .versionNumber(1)
                .status("DRAFT")
                .build();

        when(schemaVersionRepository.findById(5L)).thenReturn(Optional.of(draftV1));
        when(formSchemaRepository.findById(5L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(5L)).thenReturn(List.of());
        when(universityRepository.findAll()).thenReturn(List.of());

        CompiledSchemaDto dto = compiler.compile(5L);
        assertNotNull(dto);
        assertEquals(5L, dto.getSchemaId());
        assertEquals(5L, dto.getVersionId());
        assertEquals("Part A", dto.getTitle());
        assertTrue(dto.getSections().isEmpty());
    }

    @Test
    @DisplayName("Should reject deleting version when submissions exist with 409 Conflict")
    void shouldRejectDeletingVersionWhenSubmissionsExist() {
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("PUBLISHED").build();
        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(submissionServiceClient.countBySchemaVersion(List.of(10L))).thenReturn(Map.of("10", 3L));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> formConfigService.deleteVersion(10L));
        assertEquals(HttpStatus.CONFLICT, ex.getStatusCode());
        assertTrue(ex.getReason().contains("This version has 3 submissions and cannot be deleted."));
        verify(schemaVersionRepository, never()).deleteById(any());
    }

    @Test
    @DisplayName("Should allow deleting version when submissions are zero")
    void shouldAllowDeletingVersionWhenSubmissionsAreZero() {
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();
        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(submissionServiceClient.countBySchemaVersion(List.of(10L))).thenReturn(Map.of("10", 0L));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of());
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.empty());

        assertDoesNotThrow(() -> formConfigService.deleteVersion(10L));
        verify(schemaVersionRepository, times(1)).deleteById(10L);
    }

    @Test
    @DisplayName("Should fail closed with 409 when submission-service fails on deleteVersion")
    void shouldFailClosedWhenSubmissionServiceFailsOnDeleteVersion() {
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();
        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(submissionServiceClient.countBySchemaVersion(List.of(10L))).thenThrow(new RuntimeException("Connection refused"));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> formConfigService.deleteVersion(10L));
        assertEquals(HttpStatus.CONFLICT, ex.getStatusCode());
        assertTrue(ex.getReason().contains("because submission-service is unreachable"));
        verify(schemaVersionRepository, never()).deleteById(any());
    }

    @Test
    @DisplayName("Should reject deleting schema when submissions exist across its versions with 409 Conflict")
    void shouldRejectDeletingSchemaWhenSubmissionsExist() {
        FormSchema schema = FormSchema.builder().id(1L).name("Faculty Form").build();
        SchemaVersion v1 = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).build();
        SchemaVersion v2 = SchemaVersion.builder().id(11L).schemaId(1L).versionNumber(2).build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(1L)).thenReturn(List.of(v2, v1));
        when(submissionServiceClient.countBySchemaVersion(List.of(11L, 10L))).thenReturn(Map.of("10", 5L, "11", 0L));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class, () -> formConfigService.deleteSchema(1L));
        assertEquals(HttpStatus.CONFLICT, ex.getStatusCode());
        assertTrue(ex.getReason().contains("This schema has 5 submissions and cannot be deleted."));
        verify(formSchemaRepository, never()).deleteById(any());
    }

    @Test
    @DisplayName("Should stamp new schema version with active academic year from submission-service")
    void shouldStampNewSchemaVersionWithActiveYearFromSubmissionService() {
        FormSchema schema = FormSchema.builder().id(99L).name("New Schema").auditType("academic").build();
        when(formSchemaRepository.findById(99L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(99L)).thenReturn(List.of());
        when(submissionServiceClient.getCurrentAuditCycle()).thenReturn(Map.of("activeYear", "2030-2031", "auditCycle", "2030-31"));
        when(schemaVersionRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        SchemaVersion created = formConfigService.createDraftVersion(99L, "iqac");
        assertNotNull(created);
        assertEquals("2030-31", created.getAcademicYear());
    }

    @Test
    @DisplayName("Should fallback to calendar academic year when submission-service fails")
    void shouldFallbackToCalendarAcademicYearWhenSubmissionServiceFails() {
        FormSchema schema = FormSchema.builder().id(100L).name("New Schema 2").auditType("administrative").build();
        when(formSchemaRepository.findById(100L)).thenReturn(Optional.of(schema));
        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(100L)).thenReturn(List.of());
        when(submissionServiceClient.getCurrentAuditCycle()).thenThrow(new RuntimeException("Connection refused"));
        when(schemaVersionRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        SchemaVersion created = formConfigService.createDraftVersion(100L, "iqac");
        assertNotNull(created);
        assertNotNull(created.getAcademicYear());
        assertTrue(created.getAcademicYear().matches("\\d{4}-\\d{2}"));
    }

    @Test
    @DisplayName("Should stamp active academic year upon publishing even if draft had older academic year")
    void shouldStampActiveAcademicYearWhenPublishingEvenIfDraftHadOlderYear() {
        FormSchema schema = FormSchema.builder().id(1L).name("Existing Schema").auditType("academic").build();
        SchemaVersion draft = SchemaVersion.builder()
                .id(50L)
                .schemaId(1L)
                .versionNumber(3)
                .status("DRAFT")
                .academicYear("2026-27") // Old year inherited from earlier version
                .build();

        FormSection sec = FormSection.builder().id(500L).versionId(50L).sectionKey("part-a").title("Part A").ownerRole("auditor").build();
        FormTable tbl = FormTable.builder().id(600L).sectionId(500L).tableKey("t1").title("T1").build();
        FormField col = FormField.builder().id(700L).sectionId(500L).tableId(600L).fieldKey("c1").label("C1").build();

        when(schemaVersionRepository.findById(50L)).thenReturn(Optional.of(draft));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(50L)).thenReturn(List.of(sec));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(500L)).thenReturn(List.of(tbl));
        when(formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(600L)).thenReturn(List.of(col));

        when(submissionServiceClient.getCurrentAuditCycle()).thenReturn(Map.of("activeYear", "2030-2031", "auditCycle", "2030-31"));

        CompiledSchemaDto compiledDto = CompiledSchemaDto.builder()
                .schemaId(1L)
                .versionId(50L)
                .versionNumber(3)
                .sections(List.of(SectionDto.builder().id(500L).sectionKey("part-a").build()))
                .build();
        when(schemaCompilerService.compile(50L)).thenReturn(compiledDto);

        CompiledSchemaDto result = formConfigService.publishVersion(50L, "iqac");

        assertNotNull(result);
        assertEquals("PUBLISHED", draft.getStatus());
        assertEquals("2030-31", draft.getAcademicYear(), "Draft academic year must be updated to the active year when published");
        assertEquals("2030-31", result.getAcademicYear(), "Compiled schema academic year must match the active year");
        verify(schemaVersionRepository).save(draft);
    }

    @Test
    @DisplayName("Should match school exactly and reject substring matches")
    void shouldMatchSchoolExactlyAndRejectSubstrings() {
        FormSchema schemaSOA = FormSchema.builder()
                .id(1L)
                .name("SOA Form")
                .auditType("academic")
                .status("ACTIVE")
                .assignedSchools("[\"SOA\"]")
                .activeVersionId(10L)
                .build();

        FormSchema schemaSOAA = FormSchema.builder()
                .id(2L)
                .name("SOAA Form")
                .auditType("academic")
                .status("ACTIVE")
                .assignedSchools("[\"SOAA\"]")
                .activeVersionId(20L)
                .build();

        when(formSchemaRepository.findAll()).thenReturn(List.of(schemaSOA, schemaSOAA));

        CompiledSchemaDto compiledSOA = CompiledSchemaDto.builder().schemaId(1L).versionId(10L).title("SOA Form").build();
        CompiledSchemaDto compiledSOAA = CompiledSchemaDto.builder().schemaId(2L).versionId(20L).title("SOAA Form").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(SchemaVersion.builder().id(10L).schemaId(1L).build()));
        when(schemaVersionRepository.findById(20L)).thenReturn(Optional.of(SchemaVersion.builder().id(20L).schemaId(2L).build()));
        when(schemaCompilerService.compile(10L)).thenReturn(compiledSOA);
        when(schemaCompilerService.compile(20L)).thenReturn(compiledSOAA);

        // Querying for "SOAA" must match schemaSOAA (id=2), NOT schemaSOA (id=1) even though "SOAA".contains("SOA")
        CompiledSchemaDto result = formConfigService.getActiveCompiledSchema("academic", "SOAA");
        assertNotNull(result);
        assertEquals(2L, result.getSchemaId());
        assertEquals("SOAA Form", result.getTitle());

        // Querying for "SOA" must match schemaSOA (id=1)
        CompiledSchemaDto resultSOA = formConfigService.getActiveCompiledSchema("academic", "SOA");
        assertNotNull(resultSOA);
        assertEquals(1L, resultSOA.getSchemaId());
        assertEquals("SOA Form", resultSOA.getTitle());
    }
}
