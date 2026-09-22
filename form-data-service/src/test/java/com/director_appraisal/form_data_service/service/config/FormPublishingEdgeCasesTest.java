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
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Data Service - Publishing Edge Cases & Validation Integrity Tests")
class FormPublishingEdgeCasesTest {

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
    @DisplayName("Edge Case: Throws IllegalStateException when publishing version with 0 sections")
    void testPublishVersionWithZeroSectionsThrows() {
        FormSchema schema = FormSchema.builder().id(1L).name("Empty Schema").build();
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of());

        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> formConfigService.publishVersion(10L, "admin"));
        assertEquals("Cannot publish a schema with 0 sections.", ex.getMessage());
        verify(schemaVersionRepository, never()).save(any());
    }

    @Test
    @DisplayName("Edge Case: Throws IllegalStateException when table has 0 columns during publish")
    void testPublishTableWithZeroColumnsThrows() {
        FormSchema schema = FormSchema.builder().id(1L).name("Schema With Empty Table").build();
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();
        FormSection sec = FormSection.builder().id(101L).versionId(10L).sectionKey("sec1").title("Section 1").ownerRole("auditor").build();
        FormTable emptyTable = FormTable.builder().id(201L).sectionId(101L).tableKey("tbl1").title("Empty Table").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(sec));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of(emptyTable));
        when(formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(201L)).thenReturn(List.of()); // 0 columns!

        IllegalStateException ex = assertThrows(IllegalStateException.class, () -> formConfigService.publishVersion(10L, "admin"));
        assertTrue(ex.getMessage().contains("must have at least one column"));
        verify(schemaVersionRepository, never()).save(any());
    }

    @Test
    @DisplayName("Edge Case: Auto-heals duplicate section keys during version integrity validation")
    void testAutoHealDuplicateSectionKeys() {
        FormSchema schema = FormSchema.builder().id(1L).name("Schema with Dup Keys").build();
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();

        // Two sections with the identical key "part_a" - one marked as auditor
        FormSection sec1 = FormSection.builder().id(101L).versionId(10L).sectionKey("part_a").title("Part A 1").build();
        FormSection sec2 = FormSection.builder().id(102L).versionId(10L).sectionKey("part_a").title("Part A 2").ownerRole("auditor").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(sec1, sec2));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(any())).thenReturn(List.of());

        CompiledSchemaDto compiled = CompiledSchemaDto.builder()
                .schemaId(1L)
                .versionId(10L)
                .sections(List.of(SectionDto.builder().id(101L).sectionKey("part_a").build()))
                .build();
        when(schemaCompilerService.compile(10L)).thenReturn(compiled);

        formConfigService.publishVersion(10L, "admin");

        // Verify sec2 was healed with a unique key
        ArgumentCaptor<FormSection> captor = ArgumentCaptor.forClass(FormSection.class);
        verify(formSectionRepository, atLeastOnce()).save(captor.capture());
        List<FormSection> savedSections = captor.getAllValues();
        assertTrue(savedSections.stream().anyMatch(s -> s.getId().equals(102L) && s.getSectionKey().startsWith("part_a_")));
    }

    @Test
    @DisplayName("Edge Case: Auto-generates section keys and table keys from title if blank")
    void testAutoGeneratesKeysFromTitleIfBlank() {
        FormSchema schema = FormSchema.builder().id(1L).name("Schema with Blank Keys").build();
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();

        FormSection sec = FormSection.builder().id(101L).versionId(10L).sectionKey("").title("General Faculty Info").ownerRole("auditor").build();
        FormTable tbl = FormTable.builder().id(201L).sectionId(101L).tableKey("").title("Faculty Patents").build();
        FormField col = FormField.builder().id(301L).tableId(201L).fieldKey("patent_no").label("Patent Number").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(sec));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of(tbl));
        when(formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(201L)).thenReturn(List.of(col));

        CompiledSchemaDto compiled = CompiledSchemaDto.builder().schemaId(1L).versionId(10L).sections(List.of()).build();
        when(schemaCompilerService.compile(10L)).thenReturn(compiled);

        formConfigService.publishVersion(10L, "admin");

        // Verify section key was auto-generated
        verify(formSectionRepository, atLeastOnce()).save(argThat(s -> "general_faculty_info".equals(s.getSectionKey())));
        // Verify table key was auto-generated
        verify(formTableRepository, atLeastOnce()).save(argThat(t -> "faculty_patents".equals(t.getTableKey())));
    }

    @Test
    @DisplayName("Idempotency: Re-publishing an already published version safely updates compiled schema and active pointer")
    void testRepublishAlreadyPublishedVersion() {
        FormSchema schema = FormSchema.builder().id(1L).activeVersionId(10L).activeVersionNumber(1).name("Schema").build();
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("PUBLISHED").build();
        FormSection sec = FormSection.builder().id(101L).versionId(10L).sectionKey("sec").title("Sec").ownerRole("auditor").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(sec));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of());

        CompiledSchemaDto compiled = CompiledSchemaDto.builder().schemaId(1L).versionId(10L).versionNumber(1).build();
        when(schemaCompilerService.compile(10L)).thenReturn(compiled);

        CompiledSchemaDto res = formConfigService.publishVersion(10L, "admin");
        assertNotNull(res);
        assertEquals("PUBLISHED", version.getStatus());
        assertEquals(10L, schema.getActiveVersionId());
        assertEquals(1, schema.getActiveVersionNumber());
        verify(schemaVersionRepository).save(version);
        verify(formSchemaRepository).save(schema);
    }

    @Test
    @DisplayName("Clone Schema: Clones schema metadata and deep-clones section, table, and field tree")
    void testCloneSchemaDeepCopiesTree() {
        FormSchema sourceSchema = FormSchema.builder()
                .id(1L)
                .universityId(1L)
                .auditType("academic")
                .name("Source Schema")
                .activeVersionId(10L)
                .build();

        SchemaVersion sourceVersion = SchemaVersion.builder()
                .id(10L)
                .schemaId(1L)
                .versionNumber(1)
                .status("PUBLISHED")
                .academicYear("2024-25")
                .title("Source V1")
                .build();

        FormSection srcSec = FormSection.builder().id(101L).versionId(10L).sectionKey("sec1").title("Section 1").build();
        FormField srcTopField = FormField.builder().id(201L).sectionId(101L).fieldKey("f1").label("Field 1").build();
        FormTable srcTable = FormTable.builder().id(301L).sectionId(101L).tableKey("tbl1").title("Table 1").build();
        FormField srcCol = FormField.builder().id(401L).sectionId(101L).tableId(301L).fieldKey("c1").label("Col 1").build();

        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(sourceSchema));
        when(formSchemaRepository.save(any(FormSchema.class))).thenAnswer(inv -> {
            FormSchema s = inv.getArgument(0);
            s.setId(2L);
            return s;
        });

        when(schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(1L)).thenReturn(List.of(sourceVersion));
        when(schemaVersionRepository.save(any(SchemaVersion.class))).thenAnswer(inv -> {
            SchemaVersion v = inv.getArgument(0);
            v.setId(20L);
            return v;
        });

        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(srcSec));
        when(formSectionRepository.save(any(FormSection.class))).thenAnswer(inv -> {
            FormSection s = inv.getArgument(0);
            s.setId(102L);
            return s;
        });

        when(formFieldRepository.findBySectionIdAndTableIdIsNullOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of(srcTopField));
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(101L)).thenReturn(List.of(srcTable));
        when(formTableRepository.save(any(FormTable.class))).thenAnswer(inv -> {
            FormTable t = inv.getArgument(0);
            t.setId(302L);
            return t;
        });
        when(formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(301L)).thenReturn(List.of(srcCol));

        FormSchema cloned = formConfigService.cloneSchema(
                1L,
                "Cloned Schema",
                "administrative",
                1L,
                "School of Management",
                "admin@dypiu.ac.in"
        );

        assertNotNull(cloned);
        assertEquals("Cloned Schema", cloned.getName());
        assertEquals("administrative", cloned.getAuditType());
        assertEquals("School of Management", cloned.getAssignedSchools());

        // Verify deep cloning occurred
        verify(formSectionRepository).save(any(FormSection.class));
        verify(formTableRepository).save(any(FormTable.class));
        verify(formFieldRepository, atLeast(2)).save(any(FormField.class));
    }

    @Test
    @DisplayName("Constraint: Publishing version without Auditor section throws 400 Bad Request")
    void testPublishWithoutAuditorSectionThrowsBadRequest() {
        FormSchema schema = FormSchema.builder().id(1L).name("Schema Without Auditor").build();
        SchemaVersion version = SchemaVersion.builder().id(10L).schemaId(1L).versionNumber(1).status("DRAFT").build();
        FormSection sec = FormSection.builder().id(101L).versionId(10L).sectionKey("general").title("General").ownerRole("director-schools").build();

        when(schemaVersionRepository.findById(10L)).thenReturn(Optional.of(version));
        when(formSchemaRepository.findById(1L)).thenReturn(Optional.of(schema));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of(sec));

        org.springframework.web.server.ResponseStatusException ex = assertThrows(
                org.springframework.web.server.ResponseStatusException.class,
                () -> formConfigService.publishVersion(10L, "admin")
        );
        assertTrue(ex.getReason().contains("Auditor"));
        verify(schemaVersionRepository, never()).save(any());
    }

    @Test
    @DisplayName("Exclusivity: Assigning a school already assigned to another form throws 400 Bad Request")
    void testSchoolAssignmentExclusivityThrowsOnDuplicate() {
        FormSchema schema1 = FormSchema.builder()
                .id(1L)
                .name("SoD & SoCE academic form")
                .auditType("academic")
                .assignedSchools("[\"SOD\",\"SOCM\"]")
                .status("ACTIVE")
                .build();

        when(formSchemaRepository.findAll()).thenReturn(List.of(schema1));

        // Attempt to assign SOD to another schema
        org.springframework.web.server.ResponseStatusException ex = assertThrows(
                org.springframework.web.server.ResponseStatusException.class,
                () -> formConfigService.validateSchoolAssignments(2L, "academic", "[\"SOD\",\"SOAA\"]")
        );
        assertTrue(ex.getReason().contains("School 'SOD' is already assigned to form 'SoD & SoCE academic form'"));
    }

    @Test
    @DisplayName("Exclusivity: Updating existing schema with its own assigned schools succeeds without conflict")
    void testSchoolAssignmentExclusivityAllowsSelfUpdate() {
        FormSchema schema1 = FormSchema.builder()
                .id(1L)
                .name("SoD & SoCE academic form")
                .auditType("academic")
                .assignedSchools("[\"SOD\",\"SOCM\"]")
                .status("ACTIVE")
                .build();

        when(formSchemaRepository.findAll()).thenReturn(List.of(schema1));

        // Updating schema1 keeping SOD and SOCM should succeed (no exception)
        assertDoesNotThrow(() -> formConfigService.validateSchoolAssignments(1L, "academic", "[\"SOD\",\"SOCM\"]"));
    }

    @Test
    @DisplayName("Exclusivity: Distinct schools can be assigned across schemas without conflict")
    void testSchoolAssignmentExclusivityAllowsDistinctSchools() {
        FormSchema schema1 = FormSchema.builder()
                .id(1L)
                .name("SoD form")
                .auditType("academic")
                .assignedSchools("[\"SOD\"]")
                .status("ACTIVE")
                .build();

        when(formSchemaRepository.findAll()).thenReturn(List.of(schema1));

        // Assigning SOAA to schema 2 should succeed
        assertDoesNotThrow(() -> formConfigService.validateSchoolAssignments(2L, "academic", "[\"SOAA\"]"));
    }
}
