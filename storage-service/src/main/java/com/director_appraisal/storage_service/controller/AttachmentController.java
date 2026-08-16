package com.director_appraisal.storage_service.controller;

import com.director_appraisal.storage_service.service.AttachmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

@RestController
@RequestMapping("/api/attachments")
@RequiredArgsConstructor
@CrossOrigin
public class AttachmentController {

    private final AttachmentService attachmentService;

    @PostMapping("/upload")
    public ResponseEntity<?> uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "section", required = false) String section,
            @RequestHeader(value = "X-User-Email", required = false) String headerUserEmail,
            @RequestParam(value = "userEmail", required = false) String paramUserEmail) {
        try {
            String userEmail = headerUserEmail != null && !headerUserEmail.isBlank() ? headerUserEmail : paramUserEmail;
            AttachmentService.AttachmentResponse response = attachmentService.uploadFile(file, userEmail);
            return ResponseEntity.ok(response);
        } catch (SecurityException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", e.getMessage()));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body(Map.of("message", "Failed to upload file: " + e.getMessage()));
        }
    }

    @PostMapping("/upload-multiple")
    public ResponseEntity<?> uploadFiles(
            @RequestParam(value = "files", required = false) MultipartFile[] files,
            @RequestParam(value = "file", required = false) MultipartFile[] fallbackFiles,
            @RequestParam(value = "section", required = false) String section,
            @RequestHeader(value = "X-User-Email", required = false) String headerUserEmail,
            @RequestParam(value = "userEmail", required = false) String paramUserEmail) {
        try {
            String userEmail = headerUserEmail != null && !headerUserEmail.isBlank() ? headerUserEmail : paramUserEmail;
            MultipartFile[] uploadFiles = files != null && files.length > 0 ? files : fallbackFiles;
            return ResponseEntity.ok(attachmentService.uploadFiles(uploadFiles, userEmail));
        } catch (SecurityException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", e.getMessage()));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body(Map.of("message", "Failed to upload files: " + e.getMessage()));
        }
    }

    @DeleteMapping("/delete")
    public ResponseEntity<?> deleteFile(
            @RequestParam(value = "url", required = false) String url,
            @RequestParam(value = "section", required = false) String section,
            @RequestHeader(value = "X-User-Email", required = false) String headerUserEmail,
            @RequestBody(required = false) Map<String, String> request) {
        try {
            String fileUrl = url != null && !url.isBlank()
                    ? url
                    : request != null ? request.get("url") : null;
            String userEmail = headerUserEmail != null && !headerUserEmail.isBlank()
                    ? headerUserEmail
                    : request != null ? request.get("userEmail") : null;
            boolean deleted = attachmentService.deleteFile(fileUrl, userEmail);
            if (!deleted) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "File not found."));
            }
            return ResponseEntity.ok(Map.of("message", "File deleted successfully."));
        } catch (SecurityException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", e.getMessage()));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body(Map.of("message", "Failed to delete file: " + e.getMessage()));
        }
    }

    @GetMapping("/download")
    public ResponseEntity<?> downloadFile(
            @RequestParam("url") String url,
            @RequestParam(value = "filename", required = false) String originalFilename) {
        try {
            InputStream stream = attachmentService.downloadAttachmentStream(url, originalFilename);
            InputStreamResource resource = new InputStreamResource(stream);
            String downloadName = originalFilename != null && !originalFilename.isBlank()
                    ? originalFilename
                    : "downloaded-file";

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + downloadName + "\"")
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .body(resource);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "File not found: " + e.getMessage()));
        }
    }
}
