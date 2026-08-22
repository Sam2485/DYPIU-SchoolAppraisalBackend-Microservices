package com.director_appraisal.storage_service.controller;

import com.director_appraisal.storage_service.service.AttachmentService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("Storage Service - AttachmentController Tests")
class AttachmentControllerTest {

    @Mock
    private AttachmentService attachmentService;

    private AttachmentController attachmentController;

    @BeforeEach
    void setUp() {
        attachmentController = new AttachmentController(attachmentService);
    }

    @Test
    @DisplayName("Should successfully upload file and return file URL and metadata")
    void testUploadFileSuccess() throws IOException {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "report.pdf",
                "application/pdf",
                "Test PDF Content".getBytes()
        );

        AttachmentService.AttachmentResponse mockResponse = new AttachmentService.AttachmentResponse(
                "report.pdf",
                "/uploads/12345_report.pdf"
        );

        when(attachmentService.uploadFile(any(), eq("director@dypiu.ac.in"))).thenReturn(mockResponse);

        ResponseEntity<?> response = attachmentController.uploadFile(file, "partA", "director@dypiu.ac.in", null);
        assertEquals(200, response.getStatusCode().value());
        assertTrue(response.getBody() instanceof AttachmentService.AttachmentResponse);

        AttachmentService.AttachmentResponse res = (AttachmentService.AttachmentResponse) response.getBody();
        assertEquals("report.pdf", res.getName());
        assertEquals("/uploads/12345_report.pdf", res.getUrl());
    }


    @Test
    @DisplayName("Should return 400 Bad Request when upload fails with IllegalArgumentException")
    void testUploadIllegalArgument() throws IOException {
        MockMultipartFile emptyFile = new MockMultipartFile("file", "", "text/plain", new byte[0]);

        when(attachmentService.uploadFile(any(), any()))
                .thenThrow(new IllegalArgumentException("File cannot be empty."));

        ResponseEntity<?> response = attachmentController.uploadFile(emptyFile, "partA", "director@dypiu.ac.in", null);
        assertEquals(400, response.getStatusCode().value());
    }
}
