# Service Layer & OpenFeign Architecture Documentation

This document describes the business service layer, domain decoupling, OpenFeign inter-service communication, and dynamic schema compilation workflows across the **Multi-University Dynamic Faculty & School Appraisal Backend**.

---

## 1. Domain Decoupling & Microservices Breakdown

The system is partitioned into 6 specialized microservice domains:

```text
┌───────────────────────────┐         OpenFeign HTTP Calls        ┌───────────────────────────┐
│                           │ ──────────────────────────────────> │                           │
│    submission-service     │   AuthUserClient (Port 9001)        │     auth-user-service     │
│        (Port 9003)        │   (/api/internal/users/**)          │        (Port 9001)        │
│                           │ ──────────────────────────────────> │                           │
└─────────────┬─────────────┘   FormDataClient (Port 9002)        └───────────────────────────┘
              │                 (/api/config/**)                  ┌───────────────────────────┐
              │                                                   │                           │
              └─────────────────────────────────────────────────> │     form-data-service     │
                                                                  │        (Port 9002)        │
                                                                  │                           │
                                                                  └───────────────────────────┘
```

### Domain Responsibilities:

#### 1. `auth-user-service` (Port 9001)
- **`UserService`**: User authentication, profile CRUD, password hashing via BCrypt (cost factor 12), avatar management, and tenant scoping (`universityId`, `universityCode`).
- **`InternalUserController`**: Exposes `/api/internal/users/**` endpoints specifically for inter-service communication from partner microservices.
- **`RefreshTokenService`**: Manages 7-day long-lived session renewal tokens in PostgreSQL.
- **`EmailService`**: Sends password reset links and MFA OTP verification emails via JavaMailSender.
- **`RateLimiterService`**: In-memory sliding-window rate limiting tracking failed authentication attempts.

#### 2. `form-data-service` (Port 9002)
- **`UniversityService`**: Manages university tenant registry, codes, custom branding, and logos.
- **`FormConfigService`**: Handles schema versioning, draft cloning, section/table/field visual tree mutations, and version rollbacks.
- **`SchemaCompilerService`**: Compiles hierarchical relational definitions (`FormSection` $\rightarrow$ `FormTable` $\rightarrow$ `FormField`) into an optimized AST JSON snapshot (`CompiledSchemaDto`) saved directly to `schema_versions.compiled_schema`.
- **`UniversitySchoolService` & `UniversityPostService`**: Manages department listings and recognized administrative post titles per university.

#### 3. `submission-service` (Port 9003)
- **`SubmissionService`**: Master appraisal lifecycle (`DRAFT` $\rightarrow$ `SUBMITTED` $\rightarrow$ `UNDER_REVIEW` $\rightarrow$ `AUDITOR_COMPLETED` $\rightarrow$ `APPROVED`), JSONB data persistence, snapshot generation, and administrative post section aggregation.
- **`ReportExportService`**: Compiles dynamic JSONB submission payloads into downloadable binary Excel workbooks (Apache POI) and hyperlinked PDF dossiers (iText) using non-blocking `StreamingResponseBody`.
- **`AuthUserClient` & `FormDataClient`**: OpenFeign interfaces executing inter-service HTTP REST calls with correlation header propagation via `FeignCorrelationInterceptor`.

#### 4. `storage-service` (Port 9004)
- **`AttachmentService` / `LocalFileStorageService`**: Handles multipart document uploads, MIME validation, extension whitelisting, attachment streaming, and storage directory resolution (`/app/uploads`).

#### 5. `admin-service` (Port 9005)
- **`BackupService`**: Orchestrates database SQL dumps (`pg_dump`), database restores (`psql`), and attachment archive compression/restoration with canonical path validation against Zip-Slip vulnerabilities.

---

## 2. Inter-Service OpenFeign Interfaces

`submission-service` utilizes Spring Cloud OpenFeign to interact with partner microservices:

### `AuthUserClient.java`
```java
@FeignClient(name = "auth-user-service", url = "${AUTH_SERVICE_URL:http://localhost:9001}")
public interface AuthUserClient {
    @GetMapping("/api/internal/users/by-email/{email}")
    UserDto getUserByEmail(@PathVariable("email") String email);

    @GetMapping("/api/internal/users/{id}")
    UserDto getUserById(@PathVariable("id") Long id);

    @GetMapping("/api/internal/users")
    List<UserDto> getAllUsers();
}
```

### `FormDataClient.java`
```java
@FeignClient(name = "form-data-service", url = "${FORMS_SERVICE_URL:http://localhost:9002}")
public interface FormDataClient {
    @GetMapping("/api/academic-year/info")
    Map<String, Object> getAcademicYearInfo();

    @GetMapping("/api/config/active")
    Map<String, Object> getActiveConfig(
            @RequestParam("auditType") String auditType,
            @RequestParam(value = "school", required = false) String school);

    @GetMapping("/api/config/version/{versionId}")
    Map<String, Object> getConfigByVersion(@PathVariable("versionId") Long versionId);

    @GetMapping("/api/config/posts")
    List<Map<String, Object>> getUniversityPosts();

    @GetMapping("/api/config/branding")
    Map<String, Object> getBranding();
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
      ↓ (Returns cached AST in O(1) time (<8ms) without runtime DB joins)
[Main React Frontend]
      ↓ (DynamicFormRenderer constructs UI dynamically from AST)
```
