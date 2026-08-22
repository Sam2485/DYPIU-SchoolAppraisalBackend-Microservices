package com.director_appraisal.admin_service.controller;

import com.director_appraisal.admin_service.service.BackupService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Admin Service - Backup & Restore Security Tests")
class AdminBackupSecurityTest {

    @Mock
    private BackupService backupService;

    private BackupController backupController;

    @BeforeEach
    void setUp() {
        backupController = new BackupController(backupService);
    }

    @Test
    @DisplayName("Security: Reject database backup export from unauthorized roles (e.g. faculty / student / auditor)")
    void testRejectUnauthorizedBackupExport() {
        ResponseEntity<?> response = backupController.downloadDbDump("faculty");
        assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode().value());

        ResponseEntity<?> auditorResponse = backupController.downloadDbDump("auditor");
        assertEquals(HttpStatus.FORBIDDEN.value(), auditorResponse.getStatusCode().value());
    }

    @Test
    @DisplayName("Security: Reject database restore from unauthorized roles")
    void testRejectUnauthorizedDatabaseRestore() {
        MockMultipartFile file = new MockMultipartFile(
                "file", "backup.sql", "text/plain", "SELECT 1;".getBytes()
        );

        ResponseEntity<?> response = backupController.restoreDbDump(file, "contributor");
        assertEquals(HttpStatus.FORBIDDEN.value(), response.getStatusCode().value());
    }

    @Test
    @DisplayName("Security: Reject malicious file format during upload backup restore")
    void testRejectMaliciousArchiveFormat() {
        MockMultipartFile exeFile = new MockMultipartFile(
                "file", "payload.exe", "application/octet-stream", "MALICIOUS".getBytes()
        );

        ResponseEntity<?> response = backupController.restoreUploadsZip(exeFile, "super_admin");
        assertEquals(HttpStatus.BAD_REQUEST.value(), response.getStatusCode().value());
    }
}
