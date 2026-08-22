# Service Layer & OpenFeign Architecture Documentation

This document describes the business service layer, domain decoupling, OpenFeign inter-service communication, and dynamic schema compilation workflows across the **Multi-University Dynamic Faculty & School Appraisal Backend**.

---

## 1. Domain Decoupling & Microservices Breakdown

The system is partitioned into 6 specialized microservice domains:

```text
┌───────────────────────────┐         OpenFeign HTTP Calls        ┌───────────────────────────┐
│                           │ ──────────────────────────────────> │                           │
│    submission-service     │   AuthUserClient (Port 9001)        │     auth-user-service     │
│        (Port 9003)        │                                     │        (Port 9001)        │
│                           │ ──────────────────────────────────> │                           │
└─────────────┬─────────────┘   FormDataClient (Port 9002)        └───────────────────────────┘
              │                                                   ┌───────────────────────────┐
              │                                                   │                           │
              └─────────────────────────────────────────────────> │     form-data-service     │
                                                                  │        (Port 9002)        │
                                                                  │                           │
                                                                  └───────────────────────────┘
```

### Domain Responsibilities:

#### 1. `auth-user-service` (Port 9001)
- **`UserService`**: User authentication, profile CRUD, password hashing, avatar management, and user role authority mapping.
- **`RefreshTokenService`**: Manages 7-day long-lived session renewal tokens.
- **`EmailService`**: Sends password reset links and MFA OTP verification emails via JavaMailSender.

#### 2. `form-data-service` (Port 9002)
- **`UniversityService`**: Manages university directory, tenant codes, custom branding, and logos.
- **`FormConfigService`**: Handles schema versioning, draft cloning, section/table/field visual tree mutations, and version rollbacks.
- **`SchemaCompilerService`**: Compiles hierarchical relational definitions (`FormSection` $\rightarrow$ `FormTable` $\rightarrow$ `FormField`) into an optimized AST JSON snapshot (`CompiledSchemaDto`).
- **`AcademicFormServices` & `AdministrativeFormServices`**: Manages legacy relational tables.

#### 3. `submission-service` (Port 9003)
- **`SubmissionService`**: Master appraisal lifecycle (`DRAFT` $\rightarrow$ `SUBMITTED` $\rightarrow$ `UNDER_REVIEW` $\rightarrow$ `AUDITOR_COMPLETED` $\rightarrow$ `APPROVED`), JSONB data persistence, and snapshot generation.
- **`AuditCycleService`**: Manages active academic year audit cycles.
- **`ExcelExportService` & `PdfExportService`**: Compiles dynamic JSONB submission payloads into downloadable binary Excel workbooks and PDF reports.
- **`AuthUserClient` & `FormDataClient`**: OpenFeign interfaces executing inter-service HTTP REST calls without cross-database coupling.

#### 4. `storage-service` (Port 9004)
- **`LocalFileStorageService`**: Handles multipart document uploads, MIME validation, extension whitelisting, attachment streaming, and storage directory resolution (`./uploads`).

#### 5. `admin-service` (Port 9005)
- **`BackupService`**: Orchestrates database SQL dumps (`pg_dump`), database restores (`psql`), and attachment archive compression/restoration.

---

## 2. Inter-Service OpenFeign Interfaces

`submission-service` utilizes Spring Cloud OpenFeign to interact with partner microservices:

### `AuthUserClient.java`
```java
@FeignClient(name = "auth-user-service", url = "${AUTH_SERVICE_URL:http://localhost:9001}")
public interface AuthUserClient {
    @GetMapping("/api/users/by-email")
    UserDto getUserByEmail(@RequestParam("email") String email);

    @GetMapping("/api/users/{id}")
    UserDto getUserById(@PathVariable("id") Long id);

    @GetMapping("/api/users/all")
    List<UserDto> getAllUsers();
}
```

### `FormDataClient.java`
```java
@FeignClient(name = "form-data-service", url = "${FORMS_SERVICE_URL:http://localhost:9002}")
public interface FormDataClient {
    @GetMapping("/api/config/active")
    CompiledSchemaDto getActiveSchema(@RequestParam("auditType") String auditType, @RequestParam("universityCode") String universityCode);

    @GetMapping("/api/config/version/{versionId}")
    CompiledSchemaDto getSchemaByVersion(@PathVariable("versionId") Long versionId);
}
```

---

## 3. Dynamic Schema Compilation Pipeline

```text
[Admin Form Studio]
      ↓ (Visual Section/Table/Field Mutations)
[FormConfigService]
      ↓ (Persists relational rows in form_sections, form_tables, form_fields)
[SchemaCompilerService.compile(versionId)]
      ↓ (Builds AST with ordered sections, repeatable tables, and typed fields)
[schema_versions.compiled_schema]
      ↓ (Pre-rendered JSON snapshot saved on PUBLISH)
[GET /api/config/active]
      ↓ (Returns cached AST in O(1) time without runtime DB joins)
[Main React Frontend]
      ↓ (DynamicFormRenderer constructs UI dynamically)
```

---

## 4. Attachment Storage & Streaming Workflow

1. **Security & Type Validation**: Incoming files are validated against allowed MIME types (`application/pdf`, `image/jpeg`, `image/png`, `application/vnd.openxmlformats-officedocument.wordprocessingml.document`).
2. **Storage Path Resolution**: Files are saved with unique UUID suffixes under tenant user folders:
   `/app/uploads/users/<userKey_hash>/attachments/<filename>-<uuid>.<ext>`
3. **Public Streaming**: Static files are streamed via `/uploads/**` with `Content-Disposition` and `Content-Type` headers for seamless browser previews.
