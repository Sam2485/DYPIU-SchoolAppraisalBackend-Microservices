package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.controller.config.UniversityController;
import com.director_appraisal.form_data_service.model.config.University;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("University Controller - Super-Admin Authorization & Role Isolation Tests")
class UniversityControllerSecurityTest {

    @Mock
    private UniversityService universityService;

    private UniversityController controller;

    @BeforeEach
    void setUp() {
        controller = new UniversityController(universityService);
    }

    @Test
    @DisplayName("Security: Reject DELETE attempt by tenant IQAC role with 403 Forbidden")
    void testRejectDeleteByIqac() {
        SecurityException ex = assertThrows(SecurityException.class, () -> {
            controller.deleteUniversity(1L, false, "iqac", "iqac@dypiu.ac.in", "IQAC Coordinator", "corr-1");
        });
        assertTrue(ex.getMessage().contains("Platform Administrator / Super Admin role required"));
        verifyNoInteractions(universityService);
    }

    @Test
    @DisplayName("Security: Reject DELETE attempt by Vice-Chancellor role with 403 Forbidden")
    void testRejectDeleteByViceChancellor() {
        SecurityException ex = assertThrows(SecurityException.class, () -> {
            controller.deleteUniversity(1L, false, "vice-chancellor", "vc@dypiu.ac.in", "Vice Chancellor", "corr-2");
        });
        assertTrue(ex.getMessage().contains("Platform Administrator / Super Admin role required"));
        verifyNoInteractions(universityService);
    }

    @Test
    @DisplayName("Security: Reject DELETE attempt by School Director role with 403 Forbidden")
    void testRejectDeleteByDirector() {
        SecurityException ex = assertThrows(SecurityException.class, () -> {
            controller.deleteUniversity(1L, false, "director", "director.soet@dypiu.ac.in", "Director", "corr-3");
        });
        assertTrue(ex.getMessage().contains("Platform Administrator / Super Admin role required"));
        verifyNoInteractions(universityService);
    }

    @Test
    @DisplayName("Security: Allow DELETE attempt by super_admin role and return 204 No Content")
    void testAllowDeleteBySuperAdmin() {
        ResponseEntity<Void> response = controller.deleteUniversity(
                1L, false, "super_admin", "admin@saas-platform.gov", "Super Admin", "corr-4"
        );

        assertNotNull(response);
        assertEquals(HttpStatus.NO_CONTENT, response.getStatusCode());
        verify(universityService).deleteUniversity(1L, false, "super_admin", "admin@saas-platform.gov", "Super Admin", "corr-4");
    }

    @Test
    @DisplayName("Security: Allow DELETE attempt by platform_admin role and return 204 No Content")
    void testAllowDeleteByPlatformAdmin() {
        ResponseEntity<Void> response = controller.deleteUniversity(
                1L, false, "platform_admin", "platform@appraisal.in", "Platform Admin", "corr-5"
        );

        assertNotNull(response);
        assertEquals(HttpStatus.NO_CONTENT, response.getStatusCode());
        verify(universityService).deleteUniversity(1L, false, "platform_admin", "platform@appraisal.in", "Platform Admin", "corr-5");
    }

    @Test
    @DisplayName("Security: Reject POST attempt by faculty role with 403 Forbidden")
    void testRejectPostByFaculty() {
        University req = University.builder().name("Unauthorized Uni").code("bad_uni").build();
        SecurityException ex = assertThrows(SecurityException.class, () -> {
            controller.createUniversity(req, "faculty");
        });
        assertTrue(ex.getMessage().contains("Platform Administrator / Super Admin role required"));
        verifyNoInteractions(universityService);
    }
}
