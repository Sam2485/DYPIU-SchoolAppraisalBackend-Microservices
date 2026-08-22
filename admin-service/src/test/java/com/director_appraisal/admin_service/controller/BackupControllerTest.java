package com.director_appraisal.admin_service.controller;

import com.director_appraisal.admin_service.service.BackupService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("Admin Service - BackupController Tests")
class BackupControllerTest {

    @Mock
    private BackupService backupService;

    private BackupController backupController;

    @BeforeEach
    void setUp() {
        backupController = new BackupController(backupService);
    }

    @Test
    @DisplayName("Should successfully create database backup and return SQL byte array")
    void testDownloadDbDump() throws Exception {
        byte[] mockSql = "-- PostgreSQL database dump\nSELECT 1;".getBytes();
        when(backupService.createDatabaseBackup()).thenReturn(mockSql);

        ResponseEntity<?> response = backupController.downloadDbDump("super_admin");
        assertEquals(200, response.getStatusCode().value());
        assertArrayEquals(mockSql, (byte[]) response.getBody());
    }

    @Test
    @DisplayName("Should reject non-SQL files on restore")
    void testRestoreInvalidFileType() {
        MockMultipartFile nonSqlFile = new MockMultipartFile(
                "file",
                "malicious.exe",
                "application/octet-stream",
                "data".getBytes()
        );

        ResponseEntity<?> response = backupController.restoreDbDump(nonSqlFile, "super_admin");
        assertEquals(400, response.getStatusCode().value());
    }

    @Test
    @DisplayName("Should accept valid .sql dump file and restore successfully")
    void testRestoreValidSqlDump() throws Exception {
        MockMultipartFile sqlFile = new MockMultipartFile(
                "file",
                "backup.sql",
                "text/plain",
                "CREATE TABLE test (id INT);".getBytes()
        );

        doNothing().when(backupService).restoreDatabaseBackup(any());

        ResponseEntity<?> response = backupController.restoreDbDump(sqlFile, "super_admin");
        assertEquals(200, response.getStatusCode().value());
    }
}


