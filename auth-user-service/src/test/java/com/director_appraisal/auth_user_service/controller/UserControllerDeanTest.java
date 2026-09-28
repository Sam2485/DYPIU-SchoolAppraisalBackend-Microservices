package com.director_appraisal.auth_user_service.controller;

import com.director_appraisal.auth_user_service.model.User;
import com.director_appraisal.auth_user_service.repository.UserAdministrativePostRepository;
import com.director_appraisal.auth_user_service.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("User Controller - Dean Role & Multi-School Tests")
class UserControllerDeanTest {

    @Mock
    private UserService userService;
    @Mock
    private UserAdministrativePostRepository userAdministrativePostRepository;
    @Mock
    private Authentication authentication;

    private UserController userController;

    private User iqacUser;

    @BeforeEach
    void setUp() {
        userController = new UserController(userService, userAdministrativePostRepository);
        iqacUser = User.builder()
                .id(1L)
                .email("iqac@dypiu.ac.in")
                .role("iqac")
                .name("IQAC Coordinator")
                .build();
    }

    @Test
    @DisplayName("GET /api/users/roles should include 'dean'")
    void testGetRolesIncludesDean() {
        ResponseEntity<?> response = userController.getRoles();
        assertEquals(HttpStatus.OK, response.getStatusCode());
        @SuppressWarnings("unchecked")
        List<String> roles = (List<String>) response.getBody();
        assertNotNull(roles);
        assertTrue(roles.contains("dean"), "Roles list must include 'dean'");
    }

    @Test
    @DisplayName("Create Dean user with standing multi-school assignment should persist schools and return correct payload")
    void testCreateDeanUser() {
        when(authentication.isAuthenticated()).thenReturn(true);
        when(authentication.getPrincipal()).thenReturn(iqacUser);
        when(userService.findByEmail("dean.engineering@dypiu.ac.in")).thenReturn(Optional.empty());

        when(userService.createUser(any(User.class))).thenAnswer(invocation -> {
            User u = invocation.getArgument(0);
            u.setId(99L);
            return u;
        });

        UserController.CreateUserRequest request = new UserController.CreateUserRequest();
        request.setName("Dr. Dean Engineering");
        request.setEmail("dean.engineering@dypiu.ac.in");
        request.setPassword("SecretPass123");
        request.setRole("dean");
        request.setAccountType("dean");
        request.setUserType("dean");
        request.setCategory("academic");
        request.setAuditCategory("academic");
        request.setDesignation("Dean of Engineering & Architecture");
        request.setSchools(List.of("SOAA", "SOCE"));

        ResponseEntity<?> response = userController.createUser(authentication, request);
        assertEquals(HttpStatus.CREATED, response.getStatusCode());

        @SuppressWarnings("unchecked")
        Map<String, Object> body = (Map<String, Object>) response.getBody();
        assertNotNull(body);
        @SuppressWarnings("unchecked")
        Map<String, Object> userMap = (Map<String, Object>) body.get("user");
        assertNotNull(userMap);

        assertEquals("dean", userMap.get("role"));
        assertEquals("dean", userMap.get("accountType"));
        assertEquals("academic", userMap.get("category"));

        @SuppressWarnings("unchecked")
        List<String> returnedSchools = (List<String>) userMap.get("schools");
        assertNotNull(returnedSchools);
        assertEquals(2, returnedSchools.size());
        assertTrue(returnedSchools.contains("SOAA"));
        assertTrue(returnedSchools.contains("SOCE"));

        // Check frontend compatibility aliases
        assertEquals(returnedSchools, userMap.get("assignedSchools"));
        assertEquals(returnedSchools, userMap.get("academicSchools"));
        assertEquals(returnedSchools, userMap.get("schoolCodes"));
    }

    @Test
    @DisplayName("GET /api/users/me for Dean should return schools array and role=dean")
    void testGetMeForDean() {
        User deanUser = User.builder()
                .id(99L)
                .name("Dr. Dean")
                .email("dean@dypiu.ac.in")
                .role("dean")
                .accountType("dean")
                .category("academic")
                .designation("Dean")
                .school("SOAA")
                .schools("SOAA,SOCE")
                .build();

        when(authentication.getPrincipal()).thenReturn(deanUser);
        when(userService.findByEmail("dean@dypiu.ac.in")).thenReturn(Optional.of(deanUser));

        ResponseEntity<?> response = userController.getMyProfile(authentication);
        assertEquals(HttpStatus.OK, response.getStatusCode());

        @SuppressWarnings("unchecked")
        Map<String, Object> body = (Map<String, Object>) response.getBody();
        assertNotNull(body);
        @SuppressWarnings("unchecked")
        Map<String, Object> data = (Map<String, Object>) body.get("data");
        assertNotNull(data);

        assertEquals("dean", data.get("role"));
        assertEquals("dean", data.get("accountType"));

        @SuppressWarnings("unchecked")
        List<String> schools = (List<String>) data.get("schools");
        assertNotNull(schools);
        assertEquals(List.of("SOAA", "SOCE"), schools);
        assertEquals(schools, data.get("assignedSchools"));
    }
}
