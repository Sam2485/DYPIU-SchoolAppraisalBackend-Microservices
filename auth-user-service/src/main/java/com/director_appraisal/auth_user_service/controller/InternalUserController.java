package com.director_appraisal.auth_user_service.controller;

import com.director_appraisal.auth_user_service.model.User;
import com.director_appraisal.auth_user_service.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/internal/users")
@RequiredArgsConstructor
public class InternalUserController {

    private final UserService userService;
    private final UserController userController;

    @GetMapping
    public ResponseEntity<List<Map<String, Object>>> getAllUsers(
            @RequestParam(required = false, defaultValue = "false") boolean includeDeleted) {
        List<User> users = includeDeleted ? userService.findAllUsers() : userService.findAllUsers();
        List<Map<String, Object>> result = users.stream()
                .map(userController::toUserResponse)
                .toList();
        return ResponseEntity.ok(result);
    }

    @GetMapping("/by-email/{email}")
    public ResponseEntity<Map<String, Object>> getUserByEmail(@PathVariable String email) {
        if (email == null || email.isBlank()) {
            return ResponseEntity.notFound().build();
        }
        return userService.findByEmail(email)
                .map(u -> ResponseEntity.ok(userController.toUserResponse(u)))
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getUserById(@PathVariable Long id) {
        if (id == null) {
            return ResponseEntity.notFound().build();
        }
        return userService.findById(id)
                .map(u -> ResponseEntity.ok(userController.toUserResponse(u)))
                .orElseGet(() -> ResponseEntity.notFound().build());
    }
}
