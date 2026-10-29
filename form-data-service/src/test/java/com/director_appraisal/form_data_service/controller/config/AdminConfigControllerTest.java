package com.director_appraisal.form_data_service.controller.config;

import com.director_appraisal.form_data_service.dto.config.CompiledSchemaDto;
import com.director_appraisal.form_data_service.model.config.*;
import com.director_appraisal.form_data_service.repository.config.*;
import com.director_appraisal.form_data_service.service.config.FormConfigService;
import com.director_appraisal.form_data_service.service.config.SchemaCompilerService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Config Service - AdminConfigController Tests")
class AdminConfigControllerTest {

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
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        adminConfigController = new AdminConfigController(
                formSchemaRepository,
                schemaVersionRepository,
                formSectionRepository,
                formTableRepository,
                formFieldRepository,
                formConfigService,
                schemaCompilerService
        );
    }

    @Test
    @DisplayName("Should create new Section in Draft Version")
    void testCreateSection() {
        FormSection sec = FormSection.builder()
                .versionId(1L)
                .title("Part F - Special Achievements")
                .ownerRole("director-schools")
                .build();

        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(1L)).thenReturn(List.of());
        when(formSectionRepository.save(any())).thenAnswer(inv -> {
            FormSection s = inv.getArgument(0);
            s.setId(10L);
            return s;
        });

        ResponseEntity<FormSection> response = adminConfigController.createSection(null, sec);
        assertEquals(200, response.getStatusCode().value());
        assertNotNull(response.getBody());
        assertEquals("Part F - Special Achievements", response.getBody().getTitle());
        assertEquals(1, response.getBody().getDisplayOrder());
    }

    @Test
    @DisplayName("Should create new Table in Section and auto-initialize default column")
    void testCreateTable() {
        FormTable tbl = FormTable.builder()
                .sectionId(10L)
                .title("Special Honors")
                .tableKey("specialHonors")
                .isRepeatable(true)
                .build();

        FormSection section = FormSection.builder().id(10L).versionId(1L).title("Section 1").build();
        when(formSectionRepository.findById(10L)).thenReturn(Optional.of(section));
        when(formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(1L)).thenReturn(List.of(section));
        when(formTableRepository.findBySectionIdIn(any())).thenReturn(List.of());
        when(formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(10L)).thenReturn(List.of());
        when(formTableRepository.save(any())).thenAnswer(inv -> {
            FormTable t = inv.getArgument(0);
            t.setId(50L);
            return t;
        });
        when(formFieldRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        ResponseEntity<FormTable> response = adminConfigController.createTable(null, tbl);
        assertEquals(200, response.getStatusCode().value());
        assertNotNull(response.getBody());
        assertEquals("Special Honors", response.getBody().getTitle());
    }

    @Test
    @DisplayName("Should publish draft version and return compiled AST")
    void testPublishVersion() {
        CompiledSchemaDto compiled = CompiledSchemaDto.builder()
                .schemaId(1L)
                .versionId(20L)
                .versionNumber(2)
                .title("Academic Audit V2")
                .status("PUBLISHED")
                .build();

        when(formConfigService.publishVersion(20L, "admin")).thenReturn(compiled);

        ResponseEntity<CompiledSchemaDto> response = adminConfigController.publishVersion(20L, "admin");
        assertNotNull(response.getBody());
        assertEquals("Academic Audit V2", response.getBody().getTitle());
        assertEquals("PUBLISHED", response.getBody().getStatus());
    }

    @Test
    @DisplayName("Should reorder table fields")
    void testReorderTableFields() {
        FormField f1 = FormField.builder().id(101L).displayOrder(5).build();
        FormField f2 = FormField.builder().id(102L).displayOrder(6).build();

        when(formFieldRepository.findById(101L)).thenReturn(Optional.of(f1));
        when(formFieldRepository.findById(102L)).thenReturn(Optional.of(f2));

        ResponseEntity<java.util.Map<String, Object>> res = adminConfigController.reorderFields(50L, null, List.of(102L, 101L));
        assertEquals(200, res.getStatusCode().value());
        assertTrue((Boolean) res.getBody().get("success"));
        assertEquals(1, f2.getDisplayOrder());
        assertEquals(2, f1.getDisplayOrder());
    }

    @Test
    @DisplayName("Should reorder section top-level fields")
    void testReorderSectionFields() {
        FormField f1 = FormField.builder().id(201L).displayOrder(10).build();
        FormField f2 = FormField.builder().id(202L).displayOrder(20).build();

        when(formFieldRepository.findById(201L)).thenReturn(Optional.of(f1));
        when(formFieldRepository.findById(202L)).thenReturn(Optional.of(f2));

        ResponseEntity<java.util.Map<String, Object>> res = adminConfigController.reorderFields(null, 10L, List.of(202L, 201L));
        assertEquals(200, res.getStatusCode().value());
        assertTrue((Boolean) res.getBody().get("success"));
        assertEquals(1, f2.getDisplayOrder());
        assertEquals(2, f1.getDisplayOrder());
    }
}

