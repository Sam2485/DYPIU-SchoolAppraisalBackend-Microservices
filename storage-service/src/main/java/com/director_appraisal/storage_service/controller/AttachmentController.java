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

    @GetMapping({"/download", "/view"})
    public ResponseEntity<?> downloadFile(
            @RequestParam("url") String url,
            @RequestParam(value = "filename", required = false) String originalFilename,
            @RequestParam(value = "inline", required = false, defaultValue = "true") boolean inline) {
        try {
            InputStream stream = attachmentService.downloadAttachmentStream(url, originalFilename);
            InputStreamResource resource = new InputStreamResource(stream);
            String downloadName = originalFilename != null && !originalFilename.isBlank()
                    ? originalFilename
                    : extractFilenameFromUrl(url);

            MediaType mediaType = resolveMediaType(downloadName);
            String disposition = (inline ? "inline" : "attachment") + "; filename=\"" + downloadName + "\"";

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, disposition)
                    .contentType(mediaType)
                    .body(resource);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "File not found: " + e.getMessage()));
        }
    }

    private MediaType resolveMediaType(String filename) {
        if (filename == null || filename.isBlank()) {
            return MediaType.APPLICATION_OCTET_STREAM;
        }
        String lower = filename.toLowerCase();
        if (lower.endsWith(".pdf")) {
            return MediaType.APPLICATION_PDF;
        } else if (lower.endsWith(".png")) {
            return MediaType.IMAGE_PNG;
        } else if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) {
            return MediaType.IMAGE_JPEG;
        } else if (lower.endsWith(".gif")) {
            return MediaType.IMAGE_GIF;
        } else if (lower.endsWith(".webp")) {
            return MediaType.parseMediaType("image/webp");
        } else if (lower.endsWith(".txt") || lower.endsWith(".csv")) {
            return MediaType.TEXT_PLAIN;
        } else if (lower.endsWith(".html") || lower.endsWith(".htm")) {
            return MediaType.TEXT_HTML;
        } else if (lower.endsWith(".json")) {
            return MediaType.APPLICATION_JSON;
        } else if (lower.endsWith(".doc")) {
            return MediaType.parseMediaType("application/msword");
        } else if (lower.endsWith(".docx")) {
            return MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        } else if (lower.endsWith(".xls")) {
            return MediaType.parseMediaType("application/vnd.ms-excel");
        } else if (lower.endsWith(".xlsx")) {
            return MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        }
        return org.springframework.http.MediaTypeFactory.getMediaType(filename).orElse(MediaType.APPLICATION_OCTET_STREAM);
    }

    private String extractFilenameFromUrl(String url) {
        if (url == null || url.isBlank()) return "downloaded-file";
        String clean = url.replace("\\", "/");
        int lastSlash = clean.lastIndexOf('/');
        String name = lastSlash >= 0 ? clean.substring(lastSlash + 1) : clean;
        name = name.replaceAll("^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}-", "");
        return name.isBlank() ? "downloaded-file" : name;
    }
}
