package com.director_appraisal.admin_service.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.nio.file.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

@Service
public class BackupService {

    private static final Logger log = LoggerFactory.getLogger(BackupService.class);

    private final String localUploadPath;
    private final String backupPath;

    @Value("${app.backup.db.host:localhost}")
    private String dbHost;

    @Value("${app.backup.db.port:5432}")
    private String dbPort;

    @Value("${app.backup.db.name:postgres}")
    private String dbName;

    @Value("${app.backup.db.username:postgres}")
    private String dbUsername;

    @Value("${app.backup.db.password:postgres}")
    private String dbPassword;

    public BackupService(
            @Value("${app.upload.local-path:./uploads}") String localUploadPath,
            @Value("${app.backup.path:${BACKUP_PATH:./backups}}") String backupPath) {
        String cleanUpload = cleanPathQuotes(localUploadPath);
        String cleanBackup = cleanPathQuotes(backupPath);

        this.localUploadPath = resolveEffectiveUploadPath(cleanUpload);
        this.backupPath = resolveEffectiveBackupPath(cleanBackup, this.localUploadPath);
        log.info("Initialized BackupService. Local upload path: '{}', Backup path: '{}'", this.localUploadPath, this.backupPath);
    }

    private static String resolveEffectiveUploadPath(String configuredPath) {
        String clean = configuredPath != null ? configuredPath.trim() : "";
        if (!clean.isBlank() && !clean.equalsIgnoreCase("./uploads") && !clean.equalsIgnoreCase("/app/uploads")) {
            return clean;
        }
        Path testDir = Paths.get("/app/uploads-test");
        if (Files.exists(testDir) && Files.isDirectory(testDir)) {
            return "/app/uploads-test";
        }
        return !clean.isBlank() ? clean : "./uploads";
    }

    private static String resolveEffectiveBackupPath(String configuredPath, String effectiveUploadPath) {
        String clean = configuredPath != null ? configuredPath.trim() : "";
        if (!clean.isBlank() && !clean.equalsIgnoreCase("./backups") && !clean.equalsIgnoreCase("/app/backups") && !clean.contains("./uploads/backups")) {
            return clean;
        }
        Path testBackupDir = Paths.get("/app/backups-test");
        if (Files.exists(testBackupDir) && Files.isDirectory(testBackupDir)) {
            return "/app/backups-test";
        }
        if (effectiveUploadPath != null && effectiveUploadPath.contains("uploads-test")) {
            return "/app/backups-test";
        }
        return !clean.isBlank() ? clean : "./backups";
    }

    private String cleanPathQuotes(String path) {
        if (path == null) return null;
        String cleaned = path.trim();
        if (cleaned.startsWith("\"") && cleaned.endsWith("\"")) {
            cleaned = cleaned.substring(1, cleaned.length() - 1);
        }
        if (cleaned.startsWith("'") && cleaned.endsWith("'")) {
            cleaned = cleaned.substring(1, cleaned.length() - 1);
        }
        return cleaned.trim();
    }

    // ────────────────────────────────────────────────────────────────────────
    // Uploads backup (ZIP)
    // ────────────────────────────────────────────────────────────────────────

    public void createUploadsBackup(OutputStream outputStream) throws IOException {
        Path sourceDir = Paths.get(localUploadPath).toAbsolutePath().normalize();
        log.info("Starting zipping of uploads directory: '{}'", sourceDir);
        if (!Files.exists(sourceDir)) {
            log.info("Uploads directory does not exist, creating it: '{}'", sourceDir);
            Files.createDirectories(sourceDir);
        }

        try (ZipOutputStream zos = new ZipOutputStream(outputStream)) {
            Files.walk(sourceDir).forEach(path -> {
                try {
                    if (Files.isDirectory(path)) {
                        return;
                    }
                    String filename = path.getFileName().toString().toLowerCase();
                    if (filename.endsWith(".zip") || filename.endsWith(".sql")) {
                        log.debug("Skipping backup/restore system file during walk: {}", filename);
                        return;
                    }
                    String zipEntryName = sourceDir.relativize(path).toString().replace("\\", "/");
                    log.info("Adding zip entry: {}", zipEntryName);

                    ZipEntry zipEntry = new ZipEntry(zipEntryName);
                    zos.putNextEntry(zipEntry);
                    Files.copy(path, zos);
                    zos.closeEntry();
                } catch (IOException e) {
                    log.error("Failed to write zip entry for path: '{}'", path, e);
                    throw new RuntimeException("Error writing zip entry: " + path, e);
                }
            });
            log.info("Successfully finished zipping uploads directory.");
        } catch (RuntimeException e) {
            log.error("Error during walking/zipping uploads directory", e);
            if (e.getCause() instanceof IOException) {
                throw (IOException) e.getCause();
            }
            throw e;
        }
    }

    public void restoreUploadsBackup(MultipartFile file) throws IOException {
        Path backupDir = Paths.get(backupPath).toAbsolutePath().normalize();
        log.info("Restoring uploads backup. Active backup directory: '{}'", backupDir);
        if (!Files.exists(backupDir)) {
            log.info("Backup directory does not exist, creating it: '{}'", backupDir);
            Files.createDirectories(backupDir);
        }

        String originalFilename = file.getOriginalFilename();
        String savedBackupName = "uploads-backup-" + System.currentTimeMillis() + "-" +
                (originalFilename != null ? originalFilename : "backup.zip");
        Path savedBackupPath = backupDir.resolve(savedBackupName).normalize();
        try {
            try (InputStream is = file.getInputStream()) {
                Files.copy(is, savedBackupPath, StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException e) {
            log.error("Failed to copy uploaded ZIP file to target path '{}'. Error: {}", savedBackupPath, e.getMessage(), e);
            throw e;
        }
        log.info("ZIP copy completed successfully. File size: {} bytes", Files.size(savedBackupPath));

        Path targetDir = Paths.get(localUploadPath).toAbsolutePath().normalize();
        log.info("Extracting ZIP contents to target uploads folder: '{}'", targetDir);
        if (!Files.exists(targetDir)) {
            log.info("Target uploads directory does not exist, creating it: '{}'", targetDir);
            Files.createDirectories(targetDir);
        }

        try (ZipInputStream zis = new ZipInputStream(Files.newInputStream(savedBackupPath))) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                String entryName = entry.getName();
                if (entryName.startsWith("uploads/")) {
                    entryName = entryName.substring("uploads/".length());
                } else if (entryName.startsWith("uploads\\")) {
                    entryName = entryName.substring("uploads\\".length());
                }

                if (entryName.isEmpty()) {
                    continue;
                }

                Path newPath = targetDir.resolve(entryName).normalize();
                if (!newPath.startsWith(targetDir)) {
                    throw new IOException("Zip Slip security check failed for entry: " + entry.getName());
                }

                if (entry.isDirectory()) {
                    Files.createDirectories(newPath);
                } else {
                    Files.createDirectories(newPath.getParent());
                    Files.copy(zis, newPath, StandardCopyOption.REPLACE_EXISTING);
                }
                zis.closeEntry();
            }
            log.info("Successfully extracted uploads ZIP archive.");
        }
    }

    // ────────────────────────────────────────────────────────────────────────
    // Database backup (SQL)
    // ────────────────────────────────────────────────────────────────────────

    public byte[] createDatabaseBackup() throws IOException {
        log.info("Starting database backup dump. DB Name: '{}', Host: '{}', Port: '{}'", dbName, dbHost, dbPort);

        ProcessBuilder pb = new ProcessBuilder(
                "pg_dump",
                "-h", dbHost,
                "-p", dbPort,
                "-U", dbUsername,
                "-F", "p",
                "-b",
                "-v",
                dbName
        );

        pb.environment().put("PGPASSWORD", dbPassword);

        Process process = pb.start();
        try (InputStream is = process.getInputStream();
             ByteArrayOutputStream baos = new ByteArrayOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                baos.write(buffer, 0, bytesRead);
            }

            int exitCode = process.waitFor();
            log.info("pg_dump process completed with exit code: {}", exitCode);
            return baos.toByteArray();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("pg_dump process was interrupted", e);
        }
    }

    public void restoreDatabaseBackup(MultipartFile file) throws IOException {
        Path backupDir = Paths.get(backupPath).toAbsolutePath().normalize();
        log.info("Restoring database backup. Active backup directory: '{}'", backupDir);
        if (!Files.exists(backupDir)) {
            Files.createDirectories(backupDir);
        }

        String originalFilename = file.getOriginalFilename();
        String savedBackupName = "db-backup-" + System.currentTimeMillis() + "-" +
                (originalFilename != null ? originalFilename : "backup.sql");
        Path savedSqlPath = backupDir.resolve(savedBackupName).normalize();
        try (InputStream is = file.getInputStream()) {
            Files.copy(is, savedSqlPath, StandardCopyOption.REPLACE_EXISTING);
        }

        ProcessBuilder pb = new ProcessBuilder(
                "psql",
                "-h", dbHost,
                "-p", dbPort,
                "-U", dbUsername,
                "-d", dbName,
                "-f", savedSqlPath.toString()
        );

        pb.environment().put("PGPASSWORD", dbPassword);

        Process process = pb.start();
        try {
            int exitCode = process.waitFor();
            log.info("psql restore process completed with exit code: {}", exitCode);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IOException("psql restore process was interrupted", e);
        }
    }
}
