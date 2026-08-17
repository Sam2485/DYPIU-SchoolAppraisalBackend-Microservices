# Services Inventory & Mapping Memory

## Microservices Breakdown

### 1. `api-gateway` (:9000)
- **Module**: `api-gateway`
- **Type**: Reactive Gateway (Spring Cloud Gateway, WebFlux)
- **Routes Configured**:
  - `/api/auth/**`, `/api/users/**` -> `auth-user-service` (:9001)
  - `/api/academic/**`, `/api/administrative/**` -> `form-data-service` (:9002)
  - `/api/submissions/**`, `/api/audit-cycles/**` -> `submission-service` (:9003)
  - `/api/attachments/**`, `/uploads/**` -> `storage-service` (:9004)
  - `/api/backup/**` -> `admin-service` (:9005)

### 2. `auth-user-service` (:9001)
- **Module**: `auth-user-service`
- **Controllers**: `AuthController`, `UserController`
- **Database**: `appraisal_auth_user_db`
- **Entities**: `User`, `UserAdministrativePost`, `MfaLoginSession`, `RefreshToken`, `PasswordResetToken`
- **Features**: JWT token generation, MFA verification, email OTPs via JavaMailSender, user profile management.

### 3. `form-data-service` (:9002)
- **Module**: `form-data-service`
- **Controllers**: 64 REST Controllers (39 Academic + 25 Administrative forms)
- **Database**: `appraisal_forms_db`
- **Key Sections**: Research Publications, Patents, Funded Projects, Teaching Feedback, Academic Admin Activities.

### 4. `submission-service` (:9003)
- **Module**: `submission-service`
- **Controllers**: `SubmissionController`, `AuditCycleController`
- **Database**: `appraisal_submission_db`
- **Entities**: `Submission`, `SubmissionAuditorAssignment`, `SubmissionReportVersion`, `Snapshot`, `AcademicYear`
- **Workflow**: `DRAFT` -> `SUBMITTED` -> `AUDITOR_COMPLETED` -> `APPROVED`.
- **Feign Dependencies**: `AuthUserClient`, `FormDataClient`.

### 5. `storage-service` (:9004)
- **Module**: `storage-service`
- **Controllers**: `AttachmentController`
- **Storage**: Local filesystem directory (`./uploads` or `/app/uploads`)
- **Features**: Multi-part file upload, file streaming, MIME detection.

### 6. `admin-service` (:9005)
- **Module**: `admin-service`
- **Controllers**: `BackupController`
- **Storage**: Backup directory (`./backups` or `/app/backups`)
- **Features**: Native OS execution of `pg_dump` and `psql` for cluster backups, Zip-slip protected archive restore.

