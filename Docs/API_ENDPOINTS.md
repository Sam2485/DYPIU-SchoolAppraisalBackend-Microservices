# API Endpoints Documentation & Gateway Routing Catalog

This document details the complete, verified catalog of REST API endpoints exposed across the **Multi-University Dynamic Faculty & School Appraisal Backend** and their routing specifications across the API Gateway.

---

## 🚦 API Gateway Routing Architecture

All client requests route through the centralized **API Gateway** (`http://localhost:9000`). The Gateway executes JWT Bearer token validation, strips client-spoofed headers, and injects context headers (`X-Correlation-Id`, `X-User-Email`, `X-User-Role`, `X-User-School`, `X-University-Id`, `X-University-Code`) to downstream microservices:

| Path Prefix | Target Service | Port | Access Level | Description |
| :--- | :--- | :---: | :--- | :--- |
| `/api/auth/**` | `auth-user-service` | `9001` | Public / Whitelisted | Authentication, Login, MFA, Password Reset, Refresh Token, Logout |
| `/api/users/**` | `auth-user-service` | `9001` | JWT Authenticated | User Profiles, Avatars, Admin User Directory & CRUD |
| `/api/config/**` | `form-data-service` | `9002` | Public / Authenticated | Active Dynamic Schema AST, Version Schema, University Branding |
| `/api/admin/config/**` | `form-data-service` | `9002` | Admin Role Required | Admin Form Studio: Schema, Version, Section, Table, Field CRUD, Excel Import, University Schools/Posts |
| `/api/submissions/**` | `submission-service`| `9003` | JWT Authenticated | Draft Save/Load, Final Submission, Administrative Status/Submit, Reviews, Snapshots, Attachments ZIP, Excel/PDF Reports |
| `/api/audit-cycles/**` | `submission-service`| `9003` | Authenticated / Admin | Current Active Cycle, All Cycles, Start Next Academic Year |
| `/api/attachments/**` | `storage-service` | `9004` | JWT Authenticated | Multipart Attachment Upload, Multi-Upload, Delete, Streaming View |
| `/uploads/**` | `storage-service` | `9004` | Public Static Proxy | Public Static Attachment File Streaming |
| `/api/backup/**` | `admin-service` | `9005` | Admin / IQAC | Database SQL Dump/Restore, Attachments Archive Backup/Restore |

---

## 1. Authentication & Identity (`auth-user-service` - Port 9001)

### `POST /api/auth/login`
Authenticates user with username (email) and password. Returns access token, refresh token, and user profile.
* **Request Payload**:
  ```json
  {
    "username": "director@dypiu.ac.in",
    "password": "[PASSWORD]"
  }
  ```
* **Response (`200 OK`)**:
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "refreshToken": "a6afec4d-c239-402b-91f2-e065c7b1d742",
    "user": {
      "id": 1,
      "email": "director@dypiu.ac.in",
      "name": "Prof. Dr. Director",
      "role": "director",
      "school": "School of Computer Science",
      "universityId": 1,
      "universityCode": "dypiu"
    }
  }
  ```

### `POST /api/auth/refresh`
Rotates access token using a valid refresh token.
* **Request Payload**: `{"refreshToken": "a6afec4d-c239-402b-91f2-e065c7b1d742"}`
* **Response (`200 OK`)**: `{"token": "...", "refreshToken": "..."}`

### `POST /api/auth/verify-otp` & `POST /api/auth/resend-otp`
Completes or resends MFA login challenges for multi-factor authenticated sessions.

### `POST /api/auth/logout`
Revokes the refresh token and clears active session tracking.

### `POST /api/auth/forgot-password` & `POST /api/auth/reset-password`
Initiates self-service password reset links and sets a new password using a validated token.

### User Management Endpoints (`/api/users/**`):
* `GET /api/users`: List users in tenant (supports `?includeDeleted=true`).
* `GET /api/users/{id}`: Fetch user by ID.
* `POST /api/users`: Create user account.
* `PUT /api/users/{id}`: Update user account.
* `DELETE /api/users/{id}`: Soft-delete user account.
* `GET /api/users/roles`: List recognized system roles.
* `GET /api/users/me`: Fetch profile of currently authenticated user.
* `PUT /api/users/me`: Update profile details.
* `POST /api/users/me/avatar`: Upload profile picture.
* `DELETE /api/users/me/avatar`: Remove profile picture.
* `PUT /api/users/me/password`: Change account password.

---

## 2. Dynamic Form Configuration & Schema Engine (`form-data-service` - Port 9002)

### Client Configuration (`/api/config/**`):
* `GET /api/config/active`: Retrieves the pre-compiled AST JSON for the active published schema (`?auditType=academic&school=...`).
* `GET /api/config/version/{versionId}`: Retrieves the pre-compiled AST for a specific historical schema version.
* `GET /api/config/branding`: Retrieves tenant logo URLs, institutional name, and primary theme colors.
* `PUT /api/config/branding`: Updates university branding parameters (Admin/IQAC only).

### Admin Form Studio Configuration (`/api/admin/config/**`):
* **Schema Management**:
  * `GET /api/admin/config/schemas`: List schemas for tenant.
  * `POST /api/admin/config/schemas`: Create a new schema.
  * `GET /api/admin/config/schemas/{schemaId}`: Fetch schema metadata and version history.
  * `PUT /api/admin/config/schemas/{schemaId}`: Update schema master details.
  * `DELETE /api/admin/config/schemas/{schemaId}`: Delete schema.
  * `POST /api/admin/config/schemas/{schemaId}/clone`: Clone an entire schema structure.
  * `POST /api/admin/config/schemas/{schemaId}/versions/draft`: Create a working DRAFT clone from the active version.
  * `POST /api/admin/config/schemas/{schemaId}/rollback/{targetVersionId}`: Rollback active schema to a target version.
* **Version Management**:
  * `GET /api/admin/config/versions/{versionId}/tree`: Get full editable AST tree for Form Studio canvas.
  * `POST /api/admin/config/versions/{versionId}/publish`: Compile AST and activate schema version.
  * `DELETE /api/admin/config/versions/{versionId}`: Delete draft version.
* **Section, Table, and Field CRUD & Reordering**:
  * `POST /api/admin/config/versions/{versionId}/sections`: Create section.
  * `PUT /api/admin/config/sections/{id}`: Update section.
  * `DELETE /api/admin/config/sections/{id}`: Delete section.
  * `PUT /api/admin/config/versions/{versionId}/reorder-sections`: Reorder section IDs.
  * `POST /api/admin/config/sections/{sectionId}/tables`: Create table.
  * `PUT /api/admin/config/tables/{id}`: Update table.
  * `DELETE /api/admin/config/tables/{id}`: Delete table.
  * `PUT /api/admin/config/sections/{sectionId}/reorder-tables`: Reorder table IDs.
  * `POST /api/admin/config/tables/{tableId}/fields`: Create field/column.
  * `PUT /api/admin/config/fields/{id}`: Update field/column.
  * `DELETE /api/admin/config/fields/{id}`: Delete field/column.
  * `PUT /api/admin/config/tables/{tableId}/reorder-fields`: Reorder field IDs.
  * `POST /api/admin/config/tables/copy`: Copy existing table structure across sections.
  * `GET /api/admin/config/tables/available`: List reusable table definitions.
* **Excel Bulk Import**:
  * `POST /api/admin/config/sections/{sectionId}/batch-tables`: Batch import tables from Excel sheet into a section.
  * `POST /api/admin/config/versions/{versionId}/import-full-schema`: Import complete multi-section schema from Excel workbook.
* **University Schools & Posts**:
  * `GET /api/admin/config/universities/{universityId}/schools`: List schools.
  * `POST /api/admin/config/universities/{universityId}/schools`: Create school.
  * `PUT /api/admin/config/universities/{universityId}/schools/{schoolId}`: Update school.
  * `DELETE /api/admin/config/universities/{universityId}/schools/{schoolId}`: Delete school.
  * `GET /api/admin/config/universities/{universityId}/posts`: List administrative posts.
  * `POST /api/admin/config/universities/{universityId}/posts`: Create post.
  * `PUT /api/admin/config/universities/{universityId}/posts/{postId}`: Update post.
  * `DELETE /api/admin/config/universities/{universityId}/posts/{postId}`: Delete post.

---

## 3. Submissions & Audit Lifecycles (`submission-service` - Port 9003)

### Draft & Submission Lifecycle:
* `GET /api/submissions/my-draft`: Fetch active user's saved draft (`?auditType=academic&academicYear=...` or `?shared=true` for administrative).
* `POST /api/submissions/save-draft` & `PUT /api/submissions/save-draft`: Incremental save of form data as JSONB.
* `POST /api/submissions/submit` & `PUT /api/submissions/submit`: Final sign-off and submission of appraisal form.
* `PUT /api/submissions/{id}`: Direct update of submission content.
* `GET /api/submissions/all`: List all submissions across schools/posts for reviewers.
* `GET /api/submissions/{id}`: Fetch submission details by ID.
* `GET /api/submissions/previous-reports`: Fetch historical approved reports.
* `GET /api/submissions/{id}/snapshots`: Retrieve historical point-in-time immutable JSON snapshots.

### Collaborative Administrative Workflow:
* `GET /api/submissions/administrative/{cycleId}/status`: Check contribution progress across all administrative post sections.
* `POST /api/submissions/administrative/{cycleId}/submit`: Submit completed administrative post section.

### Auditor & Executive Review:
* `POST /api/submissions/{id}/auditor-submit`: Submit auditor scores, remarks, and verification findings.
* `POST /api/submissions/{id}/review`: General review action with remarks.
* `POST /api/submissions/{id}/approve`: Final institutional approval (VC / IQAC).
* `POST /api/submissions/{id}/reject`: Reject submission with correction remarks.
* `POST /api/submissions/{id}/unlock`: Return submitted form to contributor for revisions.
* `POST /api/submissions/{id}/next-cycle`: Rollover approved submission to initialize next academic cycle.

### Binary Document & Report Generation:
* `GET /api/submissions/{id}/report/pdf`: Streams formatted PDF dossier generated via iText.
* `GET /api/submissions/{id}/report/excel`: Streams multi-tabbed Excel workbook generated via Apache POI.
* `GET /api/submissions/{id}/attachments/download`: Streams a ZIP file containing all uploaded documentary proofs for the submission (`?includeAllContributors=true`).

### Audit Cycle Management (`/api/audit-cycles/**`):
* `GET /api/audit-cycles/current`: Fetch current active academic audit cycle.
* `GET /api/audit-cycles`: List all configured audit cycles.
* `POST /api/audit-cycles/start-next`: Initialize and activate next academic year cycle.

---

## 4. File Storage & Attachments (`storage-service` - Port 9004)

* `POST /api/attachments/upload`: Multipart upload of single document proof file.
* `POST /api/attachments/upload-multiple`: Multipart batch upload of multiple proof files.
* `DELETE /api/attachments/delete`: Delete attachment reference.
* `GET /api/attachments/download` & `GET /api/attachments/view`: Download or stream attachment proof file.
* `GET /uploads/**`: Public static file streaming endpoint reverse-proxied by Nginx.

---

## 5. System Backups & Disaster Recovery (`admin-service` - Port 9005)

* `GET /api/backup/db`: Executes native `pg_dump` and streams binary/SQL database cluster backup.
* `POST /api/backup/db/restore`: Restores PostgreSQL database state from uploaded `.sql` dump file.
* `GET /api/backup/uploads`: Packages `/app/uploads` and streams compressed `.zip` archive.
* `POST /api/backup/uploads/restore`: Safely unpacks uploaded ZIP archive with Zip-Slip path traversal defense.

---

## 6. Standardized Error Response Contract

All microservices return structured `ApiErrorResponse` JSON objects for any 4xx or 5xx response:

```json
{
  "timestamp": "2026-10-01T01:30:00.000Z",
  "status": 404,
  "error": "NOT_FOUND",
  "message": "Submission with ID 84 was not found for the specified academic year.",
  "path": "/api/submissions/84",
  "correlationId": "c-9e2b1f8c-8472"
}
```
