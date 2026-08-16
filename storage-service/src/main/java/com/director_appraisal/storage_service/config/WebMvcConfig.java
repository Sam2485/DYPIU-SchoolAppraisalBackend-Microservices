package com.director_appraisal.storage_service.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Value("${app.upload.local-path:./uploads}")
    private String localUploadPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String effectivePath = resolveEffectiveUploadPath(localUploadPath);
        Path uploadDir = Paths.get(effectivePath).toAbsolutePath().normalize();
        String uploadPath = uploadDir.toString().replace("\\", "/");
        if (!uploadPath.endsWith("/")) {
            uploadPath += "/";
        }

        List<String> locations = new ArrayList<>();
        locations.add("file:" + uploadPath);
        locations.add("file:" + uploadPath + "users/");
        locations.add("file:/app/uploads-test/");
        locations.add("file:/app/uploads-test/users/");
        locations.add("file:/app/uploads/");
        locations.add("file:/app/uploads/users/");

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(locations.toArray(new String[0]));
    }

    private static String resolveEffectiveUploadPath(String configuredPath) {
        String clean = configuredPath != null ? configuredPath.trim() : "";
        if (clean.startsWith("\"") && clean.endsWith("\"")) clean = clean.substring(1, clean.length() - 1);
        if (clean.startsWith("'") && clean.endsWith("'")) clean = clean.substring(1, clean.length() - 1);

        if (!clean.isBlank() && !clean.equalsIgnoreCase("./uploads") && !clean.equalsIgnoreCase("/app/uploads")) {
            return clean;
        }

        Path testDir = Paths.get("/app/uploads-test");
        if (Files.exists(testDir) && Files.isDirectory(testDir)) {
            return "/app/uploads-test";
        }

        return !clean.isBlank() ? clean : "./uploads";
    }
}
