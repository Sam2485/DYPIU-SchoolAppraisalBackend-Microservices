package com.director_appraisal.admin_service.controller;

import com.director_appraisal.admin_service.service.BackupService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/api/backup")
@RequiredArgsConstructor
@CrossOrigin
public class BackupController {

    private final BackupService backupService;

    private static final java.util.Set<String> AUTHORIZED_ROLES = java.util.Set.of("super_admin", "admin", "iqac");

    private boolean isAuthorized(String role) {
        return role != null && AUTHORIZED_ROLES.contains(role.trim().toLowerCase(java.util.Locale.ROOT));
    }

    @GetMapping("/db")
    public ResponseEntity<?> downloadDbDump(@RequestHeader(value = "X-User-Role", required = false) String userRole) {
        if (userRole != null && !isAuthorized(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", "Access denied. Requires admin privileges."));
        }
        try {
            byte[] sqlData = backupService.createDatabaseBackup();
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=db_dump_" + System.currentTimeMillis() + ".sql")
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .body(sqlData);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "Database export failed: " + e.getMessage()));
        }
    }

    @PostMapping("/db/restore")
    public ResponseEntity<?> restoreDbDump(
            @RequestParam("file") MultipartFile file,
            @RequestHeader(value = "X-User-Role", required = false) String userRole) {
        if (userRole != null && !isAuthorized(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", "Access denied. Requires admin privileges."));
        }
        if (file.isEmpty() || !Objects.requireNonNull(file.getOriginalFilename()).endsWith(".sql")) {
            return ResponseEntity.badRequest().body(Map.of("message", "Only SQL dump files (.sql) are allowed."));
        }
        try {
            backupService.restoreDatabaseBackup(file);
            return ResponseEntity.ok(Map.of("message", "Database successfully restored from dump file."));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "Database restore failed: " + e.getMessage()));
        }
    }

    @GetMapping("/uploads")
    public ResponseEntity<?> downloadUploadsZip(@RequestHeader(value = "X-User-Role", required = false) String userRole) {
        if (userRole != null && !isAuthorized(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", "Access denied. Requires admin privileges."));
        }
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            backupService.createUploadsBackup(baos);
            byte[] zipData = baos.toByteArray();

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=uploads_backup_" + System.currentTimeMillis() + ".zip")
                    .contentType(MediaType.parseMediaType("application/zip"))
                    .body(zipData);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "Files export failed: " + e.getMessage()));
        }
    }

    @PostMapping("/uploads/restore")
    public ResponseEntity<?> restoreUploadsZip(
            @RequestParam("file") MultipartFile file,
            @RequestHeader(value = "X-User-Role", required = false) String userRole) {
        if (userRole != null && !isAuthorized(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", "Access denied. Requires admin privileges."));
        }
        if (file.isEmpty() || !Objects.requireNonNull(file.getOriginalFilename()).endsWith(".zip")) {
            return ResponseEntity.badRequest().body(Map.of("message", "Only ZIP backup archives (.zip) are allowed."));
        }
        try {
            backupService.restoreUploadsBackup(file);
            return ResponseEntity.ok(Map.of("message", "Upload attachments successfully restored."));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "Files restore failed: " + e.getMessage()));
        }
    }
}

