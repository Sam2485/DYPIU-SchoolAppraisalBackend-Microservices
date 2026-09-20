package com.director_appraisal.form_data_service.controller.config;

import com.director_appraisal.form_data_service.dto.config.CompiledSchemaDto;
import com.director_appraisal.form_data_service.model.config.University;
import com.director_appraisal.form_data_service.service.config.FormConfigService;
import com.director_appraisal.form_data_service.service.config.UniversityService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;

import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("Form Config Service - ClientConfigController Tests")
class ClientConfigControllerTest {

    @Mock
    private FormConfigService formConfigService;
    @Mock
    private UniversityService universityService;

    private ClientConfigController clientConfigController;

    @BeforeEach
    void setUp() {
        clientConfigController = new ClientConfigController(formConfigService, universityService);
    }

    @Test
    @DisplayName("Should return active compiled schema for given audit type and university code")
    void testGetActiveSchema() {
        CompiledSchemaDto dto = CompiledSchemaDto.builder()
                .schemaId(1L)
                .versionId(10L)
                .versionNumber(1)
                .auditType("academic")
                .title("External Academic Audit")
                .build();

        when(formConfigService.getActiveCompiledSchema(null, "academic", null)).thenReturn(dto);

        ResponseEntity<CompiledSchemaDto> response = clientConfigController.getActiveSchema("academic", null, null);
        assertEquals(200, response.getStatusCode().value());
        assertNotNull(response.getBody());
        assertEquals("External Academic Audit", response.getBody().getTitle());
        assertEquals(1, response.getBody().getVersionNumber());
    }

    @Test
    @DisplayName("Should return university branding info")
    void testGetBranding() {
        University u = University.builder()
                .id(1L)
                .code("dypiu")
                .name("D Y Patil International University Akurdi Pune")
                .domain("dypiu.ac.in")
                .primaryColor("#1e3a8a")
                .build();

        when(universityService.getInstitution()).thenReturn(u);

        ResponseEntity<Map<String, Object>> response = clientConfigController.getBranding();
        assertEquals(200, response.getStatusCode().value());
        assertEquals("D Y Patil International University Akurdi Pune", response.getBody().get("universityName"));
        assertEquals("#1e3a8a", response.getBody().get("primaryColor"));
    }

    @Test
    @DisplayName("Branding Update: Reject unauthorized role with 403 Forbidden")
    void testUpdateBrandingForbiddenRole() {
        com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto req =
                new com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto();
        req.setUniversityName("DYPIU");

        ResponseEntity<?> response = clientConfigController.updateBranding(req, "director", null);
        assertEquals(403, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Branding Update: Reject empty universityName with 400 Bad Request")
    void testUpdateBrandingEmptyName() {
        com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto req =
                new com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto();
        req.setUniversityName("   ");

        University u = University.builder().id(1L).code("dypiu").name("Existing").build();
        when(universityService.getInstitution()).thenReturn(u);

        ResponseEntity<?> response = clientConfigController.updateBranding(req, "iqac", null);
        assertEquals(400, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Branding Update: Reject invalid / garbage logoUrl with 400 Bad Request")
    void testUpdateBrandingInvalidLogoUrl() {
        com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto req =
                new com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto();
        req.setUniversityName("Valid University");
        req.setLogoUrl("<script>alert('hack')</script>");

        University u = University.builder().id(1L).code("dypiu").name("Existing").build();
        when(universityService.getInstitution()).thenReturn(u);

        ResponseEntity<?> response = clientConfigController.updateBranding(req, "iqac", null);
        assertEquals(400, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Branding Update: Successfully update university branding and return full object")
    void testUpdateBrandingSuccess() {
        com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto req =
                new com.director_appraisal.form_data_service.dto.config.UpdateBrandingRequestDto();
        req.setUniversityName("D Y Patil International University");
        req.setDomain("dypiu.ac.in");
        req.setAddress("Sector 29, Akurdi, Pune");
        req.setAct("Maharashtra Act No. VI of 2019");
        req.setLogoUrl("/uploads/users/123/attachments/logo.png");
        req.setIqacLogoUrl("/uploads/users/123/attachments/iqac_logo.png");

        University existing = University.builder()
                .id(1L)
                .code("dypiu")
                .name("Old Name")
                .primaryColor("#1e3a8a")
                .build();

        University updated = University.builder()
                .id(1L)
                .code("dypiu")
                .name(req.getUniversityName())
                .domain(req.getDomain())
                .address(req.getAddress())
                .establishmentAct(req.getAct())
                .logoUrl(req.getLogoUrl())
                .iqacLogoUrl(req.getIqacLogoUrl())
                .primaryColor("#1e3a8a")
                .build();

        when(universityService.getInstitution()).thenReturn(existing);
        when(universityService.updateUniversity(org.mockito.ArgumentMatchers.eq(1L), org.mockito.ArgumentMatchers.any())).thenReturn(updated);

        ResponseEntity<?> response = clientConfigController.updateBranding(req, "iqac", null);
        assertEquals(200, response.getStatusCode().value());
        assertTrue(response.getBody() instanceof Map);
        Map<?, ?> body = (Map<?, ?>) response.getBody();
        assertEquals("D Y Patil International University", body.get("universityName"));
        assertEquals("/uploads/users/123/attachments/logo.png", body.get("logoUrl"));
        assertEquals("/uploads/users/123/attachments/iqac_logo.png", body.get("iqacLogoUrl"));
        assertEquals("dypiu.ac.in", body.get("domain"));
        assertEquals("#1e3a8a", body.get("primaryColor"));
    }
}
