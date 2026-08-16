# Service Layer & OpenFeign Architecture Documentation

This document describes the business service layer, domain decoupling, OpenFeign inter-service communication, and storage workflows across the **School Appraisal Microservices Backend**.

---

## 1. Domain Decoupling & Microservices Breakdown

The backend business logic is cleanly partitioned into 6 specialized microservice domains:

```text
┌───────────────────────────┐         OpenFeign HTTP Calls        ┌───────────────────────────┐
│                           │ ──────────────────────────────────> │                           │
│    submission-service     │   AuthUserClient (Port 8081)        │     auth-user-service     │
│        (Port 8083)        │                                     │        (Port 8081)        │
│                           │ ──────────────────────────────────> │                           │
└─────────────┬─────────────┘   FormDataClient (Port 8082)        └───────────────────────────┘
              │                                                   ┌───────────────────────────┐
              │                                                   │                           │
              └─────────────────────────────────────────────────> │     form-data-service     │
                                                                  │        (Port 8082)        │
                                                                  │                           │
                                                                  └───────────────────────────┘
```

### Domain Responsibilities:

#### 1. `auth-user-service` (Port 8081)
- **`UserService`**: Handles user authentication, profile CRUD, password resets, and user role authority mapping.
- **`RefreshTokenService`**: Manages 7-day long-lived session renewal tokens.
- **`EmailService`**: Sends password reset and OTP verification emails via JavaMailSender.

#### 2. `form-data-service` (Port 8082)
- **`AcademicFormServices` & `AdministrativeFormServices`**: Manages all 64 relational section tables (`StudentStrengthService`, `CoursesOfferedService`, `ResearchPublicationsService`, etc.).
- **`TableDataPromotionService`**: Promotes section data between academic years.

#### 3. `submission-service` (Port 8083)
- **`SubmissionService`**: Master form lifecycle (`DRAFT` $\rightarrow$ `SUBMITTED` $\rightarrow$ `AUDITOR_COMPLETED` $\rightarrow$ `APPROVED`), auditor assignment matching, snapshot capturing, and versioning.
- **`AuditCycleService`**: Manages active working academic year audit cycles.
- **`AuthUserClient` & `FormDataClient`**: OpenFeign interfaces executing inter-service HTTP REST calls to fetch user/auditor metadata and section form data without direct database cross-talk.

#### 4. `storage-service` (Port 8084)
- **`LocalFileStorageService`**: Handles PDF file uploads, SHA-256 deduplication, attachment streaming, and storage resolution (`./uploads`).

#### 5. `admin-service` (Port 8085)
- **`BackupService`**: Executes native OS shell processes for database dumps (`pg_dump`), database restores (`psql`), and attachment backup archives.

---

## 2. Inter-Service OpenFeign Interfaces

`submission-service` utilizes Spring Cloud OpenFeign to interact with partner services:

### `AuthUserClient.java`
```java
@FeignClient(name = "auth-user-service", url = "${AUTH_SERVICE_URL:http://localhost:8081}")
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
@FeignClient(name = "form-data-service", url = "${FORMS_SERVICE_URL:http://localhost:8082}")
public interface FormDataClient {
    @GetMapping("/api/academic/sections/{sectionName}")
    Object getAcademicSectionData(@PathVariable("sectionName") String sectionName, @RequestParam("submissionId") Long submissionId);
}
```

---

## 3. Attachment Engine & File Resolution Workflow

The attachment engine in `storage-service` resolves local file streams using fuzzy normalization and key hash security:

1. **SHA-256 Checksum Deduplication**: On file upload, `storage-service` generates a unique storage key path:
   `/app/uploads/users/<userKey_hash>/attachments/<content_sha256>.pdf`
2. **Fuzzy Normalized Filename Search**: If direct file lookup fails during bulk ZIP download generation, `LocalFileStorageService` executes fuzzy search across `/app/uploads` by stripping UUID prefixes and punctuation to guarantee 100% attachment resolution.
3. **Ownership Verification**: Deletions verify that the requesting user's key hash matches the target file prefix before executing file removal.
