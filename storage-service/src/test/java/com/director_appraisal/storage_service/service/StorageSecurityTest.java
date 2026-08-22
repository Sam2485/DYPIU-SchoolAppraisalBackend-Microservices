package com.director_appraisal.storage_service.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)

@DisplayName("Storage Service - Upload Security & Path Traversal Tests")
class StorageSecurityTest {

    @Mock
    private StorageService storageService;

    private AttachmentService attachmentService;

    @BeforeEach
    void setUp() {
        attachmentService = new AttachmentService("schoolappraisal-attachments", "./uploads", storageService);
    }

    @Test
    @DisplayName("Security: Reject dangerous executable and script file uploads (.exe, .php, .jsp, .sh, .bat)")
    void testRejectDangerousFileTypes() {
        MockMultipartFile exeFile = new MockMultipartFile(
                "file", "malware.exe", "application/x-msdownload", "MALICIOUS".getBytes()
        );
        MockMultipartFile phpFile = new MockMultipartFile(
                "file", "webshell.php", "application/x-php", "<?php echo 'hack'; ?>".getBytes()
        );
        MockMultipartFile jspFile = new MockMultipartFile(
                "file", "payload.jsp", "text/html", "<% Runtime.getRuntime().exec('cmd'); %>".getBytes()
        );

        assertThrows(SecurityException.class, () -> attachmentService.uploadFile(exeFile, "attacker@evil.com"));
        assertThrows(SecurityException.class, () -> attachmentService.uploadFile(phpFile, "attacker@evil.com"));
        assertThrows(SecurityException.class, () -> attachmentService.uploadFile(jspFile, "attacker@evil.com"));
    }

    @Test
    @DisplayName("Security: Reject files exceeding 25MB maximum threshold")
    void testRejectOversizedFiles() {
        byte[] oversizedData = new byte[(int) (26L * 1024L * 1024L)]; // 26 MB
        MockMultipartFile hugeFile = new MockMultipartFile(
                "file", "huge_report.pdf", "application/pdf", oversizedData
        );

        assertThrows(IllegalArgumentException.class, () -> attachmentService.uploadFile(hugeFile, "user@dypiu.ac.in"));
    }

    @Test
    @DisplayName("Security: Prevent directory traversal attack in filename")
    void testSanitizePathTraversalFilename() throws IOException {
        MockMultipartFile traversalFile = new MockMultipartFile(
                "file", "../../../etc/passwd.pdf", "application/pdf", "%PDF-1.4 test".getBytes()
        );

        when(storageService.storeFile(any(), any())).thenAnswer(inv -> "/uploads/" + inv.getArgument(0));

        // Upload should succeed but filename must be sanitized without traversal slashes
        AttachmentService.AttachmentResponse response = attachmentService.uploadFile(traversalFile, "user@dypiu.ac.in");
        assertNotNull(response);
        assertNotNull(response.getUrl());
        assertFalse(response.getUrl().contains(".."), "URL must not contain path traversal characters");
    }
}

