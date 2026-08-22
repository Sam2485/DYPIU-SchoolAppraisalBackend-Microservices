package com.director_appraisal.auth_user_service.controller;

import com.director_appraisal.auth_user_service.model.User;
import com.director_appraisal.auth_user_service.repository.MfaLoginSessionRepository;
import com.director_appraisal.auth_user_service.repository.UserAdministrativePostRepository;
import com.director_appraisal.auth_user_service.service.*;
import jakarta.servlet.http.HttpServletRequest;
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
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("Auth User Service - AuthController Tests")
class AuthControllerTest {

    @Mock
    private UserService userService;
    @Mock
    private JwtService jwtService;
    @Mock
    private UserAdministrativePostRepository userAdministrativePostRepository;
    @Mock
    private RateLimiterService rateLimiterService;
    @Mock
    private MfaService mfaService;
    @Mock
    private RefreshTokenService refreshTokenService;
    @Mock
    private MfaLoginSessionRepository mfaLoginSessionRepository;
    @Mock
    private HttpServletRequest httpServletRequest;

    private AuthController authController;

    @BeforeEach
    void setUp() {
        authController = new AuthController(
                userService,
                jwtService,
                userAdministrativePostRepository,
                rateLimiterService,
                mfaService,
                refreshTokenService,
                mfaLoginSessionRepository,
                httpServletRequest
        );

        when(rateLimiterService.getClientIp(any())).thenReturn("127.0.0.1");
        when(rateLimiterService.checkLimit(anyString(), anyString(), anyString()))
                .thenReturn(new RateLimiterService.RateLimitResult(true, 5, 5, 0));
    }

    @Test
    @DisplayName("Should successfully login user and return LoginResponse with tenant claims")
    void testSuccessfulLogin() {
        User user = User.builder()
                .id(1L)
                .email("director@dypiu.ac.in")
                .password("encodedSecret")
                .name("Dr. Director")
                .role("director")
                .school("School of Engineering")
                .universityId(1L)
                .universityCode("dypiu")
                .build();

        when(userService.findByEmail("director@dypiu.ac.in")).thenReturn(Optional.of(user));
        when(userService.checkPassword("password123", "encodedSecret")).thenReturn(true);
        when(jwtService.generateToken(eq(user), any())).thenReturn("mocked.jwt.token");
        when(userAdministrativePostRepository.findByUserId(1L)).thenReturn(List.of());

        AuthController.LoginRequest loginRequest = new AuthController.LoginRequest();
        loginRequest.setEmail("director@dypiu.ac.in");
        loginRequest.setPassword("password123");

        ResponseEntity<?> response = authController.login(loginRequest);
        assertEquals(200, response.getStatusCode().value());
        assertTrue(response.getBody() instanceof AuthController.LoginResponse);

        AuthController.LoginResponse res = (AuthController.LoginResponse) response.getBody();
        assertEquals("director@dypiu.ac.in", res.getEmail());
        assertEquals("mocked.jwt.token", res.getToken());
        assertEquals(1L, res.getUniversityId());
        assertEquals("dypiu", res.getUniversityCode());
    }

    @Test
    @DisplayName("Should return 400 when invalid password is provided")
    void testInvalidPassword() {
        User user = User.builder()
                .id(1L)
                .email("director@dypiu.ac.in")
                .password("encodedSecret")
                .build();

        when(userService.findByEmail("director@dypiu.ac.in")).thenReturn(Optional.of(user));
        when(userService.checkPassword("wrongPassword", "encodedSecret")).thenReturn(false);

        AuthController.LoginRequest loginRequest = new AuthController.LoginRequest();
        loginRequest.setEmail("director@dypiu.ac.in");
        loginRequest.setPassword("wrongPassword");

        ResponseEntity<?> response = authController.login(loginRequest);
        assertEquals(400, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Should return 400 when user does not exist")
    void testNonExistentUser() {
        when(userService.findByEmail("nonexistent@dypiu.ac.in")).thenReturn(Optional.empty());

        AuthController.LoginRequest loginRequest = new AuthController.LoginRequest();
        loginRequest.setEmail("nonexistent@dypiu.ac.in");
        loginRequest.setPassword("anyPassword");

        ResponseEntity<?> response = authController.login(loginRequest);
        assertEquals(400, response.getStatusCode().value());
    }
}
