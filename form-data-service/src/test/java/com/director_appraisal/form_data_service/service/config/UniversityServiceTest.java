package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.model.config.*;
import com.director_appraisal.form_data_service.repository.config.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Config Service - UniversityService Tests")
class UniversityServiceTest {

    @Mock
    private UniversityRepository universityRepository;

    @Mock
    private DefaultSchemaTemplateService defaultSchemaTemplateService;

    @Mock
    private UniversitySchoolRepository universitySchoolRepository;

    @Mock
    private UniversityPostRepository universityPostRepository;

    @Mock
    private FormSchemaRepository formSchemaRepository;

    @Mock
    private FormConfigService formConfigService;

    @Mock
    private UniversityAuditLogRepository auditLogRepository;

    private UniversityService universityService;

    @BeforeEach
    void setUp() {
        universityService = new UniversityService(
                universityRepository,
                defaultSchemaTemplateService,
                universitySchoolRepository,
                universityPostRepository,
                formSchemaRepository,
                formConfigService,
                auditLogRepository
        );
    }

    @Test
    @DisplayName("Should create new university with valid unique code")
    void testCreateUniversity() {
        University uni = University.builder()
                .code("apex_uni")
                .name("Apex Global University")
                .domain("apex.edu.in")
                .build();

        when(universityRepository.existsByCodeIgnoreCase("apex_uni")).thenReturn(false);
        when(universityRepository.save(any())).thenAnswer(inv -> {
            University u = inv.getArgument(0);
            u.setId(2L);
            return u;
        });

        University created = universityService.createUniversity(uni);
        assertNotNull(created);
        assertEquals(2L, created.getId());
        assertEquals("apex_uni", created.getCode());
    }

    @Test
    @DisplayName("Should throw exception when attempting to create university with duplicate code")
    void testDuplicateUniversityCodeThrows() {
        University uni = University.builder()
                .code("dypiu")
                .name("DYPIU Duplicate")
                .build();

        when(universityRepository.existsByCodeIgnoreCase("dypiu")).thenReturn(true);

        assertThrows(IllegalArgumentException.class, () -> universityService.createUniversity(uni));
    }

    @Test
    @DisplayName("Should update existing university branding and address")
    void testUpdateUniversity() {
        University existing = University.builder()
                .id(1L)
                .code("dypiu")
                .name("Old Name")
                .address("Old Address")
                .build();

        when(universityRepository.findById(1L)).thenReturn(Optional.of(existing));
        when(universityRepository.save(any())).thenAnswer(inv -> inv.getArgument(0));

        University updateReq = University.builder()
                .name("D Y Patil International University Akurdi Pune")
                .address("Sector 29, Pradhikaran, Akurdi, Pune")
                .primaryColor("#1e3a8a")
                .build();

        University updated = universityService.updateUniversity(1L, updateReq);
        assertEquals("D Y Patil International University Akurdi Pune", updated.getName());
        assertEquals("Sector 29, Pradhikaran, Akurdi, Pune", updated.getAddress());
        assertEquals("#1e3a8a", updated.getPrimaryColor());
    }

    @Test
    @DisplayName("Soft-Delete/Archive: Should cascade archive to schools, posts, and schemas and write audit log")
    void testSoftDeleteArchiveUniversity() {
        University existing = University.builder()
                .id(1L)
                .code("dypiu")
                .name("DYPIU")
                .status("ACTIVE")
                .build();

        when(universityRepository.findById(1L)).thenReturn(Optional.of(existing));
        when(universitySchoolRepository.findByUniversityIdOrderByDisplayOrderAscIdAsc(1L)).thenReturn(List.of(
                UniversitySchool.builder().id(10L).universityId(1L).code("soet").status("ACTIVE").build()
        ));
        when(universityPostRepository.findByUniversityIdOrderByDisplayOrderAscNameAsc(1L)).thenReturn(List.of(
                UniversityPost.builder().id(20L).universityId(1L).code("director").status("ACTIVE").build()
        ));
        when(formSchemaRepository.findByUniversityId(1L)).thenReturn(List.of(
                FormSchema.builder().id(30L).universityId(1L).name("Academic Appraisal").status("ACTIVE").build()
        ));

        universityService.deleteUniversity(1L, false, "super_admin", "admin@platform.local", "Super Admin", "corr-123");

        assertEquals("ARCHIVED", existing.getStatus());
        verify(universityRepository).save(existing);
        verify(universitySchoolRepository).save(argThat(s -> "ARCHIVED".equals(s.getStatus())));
        verify(universityPostRepository).save(argThat(p -> "ARCHIVED".equals(p.getStatus())));
        verify(formSchemaRepository).save(argThat(sc -> "ARCHIVED".equals(sc.getStatus())));
        verify(auditLogRepository).save(argThat(log -> "ARCHIVED".equals(log.getAction()) && "dypiu".equals(log.getUniversityCode())));
    }

    @Test
    @DisplayName("Hard-Delete: Should cascade hard deletion of schemas, schools, posts, and university when no submissions exist")
    void testHardDeleteSuccess() {
        University existing = University.builder()
                .id(2L)
                .code("test_uni")
                .name("Test University")
                .status("ACTIVE")
                .build();

        when(universityRepository.findById(2L)).thenReturn(Optional.of(existing));

        universityService.deleteUniversity(2L, true, "super_admin", "admin@platform.local", "Super Admin", "corr-456");

        verify(formConfigService).deleteAllSchemasForUniversity(2L);
        verify(universitySchoolRepository).deleteByUniversityId(2L);
        verify(universityPostRepository).deleteByUniversityId(2L);
        verify(universityRepository).delete(existing);
        verify(auditLogRepository).save(argThat(log -> "HARD_DELETE".equals(log.getAction())));
    }

    @Test
    @DisplayName("Delete: Non-existent university throws NoSuchElementException (404)")
    void testDeleteNonExistentThrows404() {
        when(universityRepository.findById(999L)).thenReturn(Optional.empty());

        assertThrows(NoSuchElementException.class, () -> {
            universityService.deleteUniversity(999L, false, "super_admin", "admin@platform.local", "Admin", "c-1");
        });
    }
}
