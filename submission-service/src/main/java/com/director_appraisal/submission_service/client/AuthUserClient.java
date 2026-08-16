package com.director_appraisal.submission_service.client;

import com.director_appraisal.submission_service.dto.UserDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient(name = "auth-user-service", url = "${AUTH_SERVICE_URL:http://localhost:8081}")
public interface AuthUserClient {

    @GetMapping("/api/users/by-email/{email}")
    UserDto getUserByEmail(@PathVariable("email") String email);

    @GetMapping("/api/users/{id}")
    UserDto getUserById(@PathVariable("id") Long id);

    @GetMapping("/api/users")
    List<UserDto> getAllUsers();
}
