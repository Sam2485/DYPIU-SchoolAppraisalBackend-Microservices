# API Endpoints Documentation & Gateway Routing Catalog

This document details the complete catalog of **82 REST API endpoints** exposed by the **Multi-University Dynamic Faculty & School Appraisal Backend** and their routing specifications across the API Gateway.

---

## 🚦 API Gateway Routing Architecture

All client requests route through the centralized **API Gateway** (`http://localhost:9000`). The Gateway executes JWT Bearer token validation, sliding-window rate limiting, and forwards context headers (`X-Correlation-Id`, `X-User-Email`, `X-User-Role`, `X-User-School`, `X-User-Name`, `X-University-Id`, `X-University-Code`) to downstream microservices:

| Path Prefix | Target Service | Port | Access Level | Description |
| :--- | :--- | :---: | :--- | :--- |
| `/api/auth/**` | `auth-user-service` | `9001` | Public / Whitelisted | Authentication, Login, MFA, Password Reset, Refresh Token |
| `/api/users/**` | `auth-user-service` | `9001` | JWT Authenticated | User Profiles, Avatars, Admin User Management |
| `/api/config/**` | `form-data-service` | `9002` | Public / Authenticated | Active Dynamic Schema AST, Version Schema, University Branding |
| `/api/admin/config/**` | `form-data-service` | `9002` | Admin Role Required | Admin Form Studio: Schema, Version, Section, Table, Field CRUD |
| `/api/universities/**` | `form-data-service` | `9002` | Public / Admin | University Directory & Tenant Management |
| `/api/academic/**` | `form-data-service` | `9002` | JWT Authenticated | Legacy Academic Section Tables (Part A & B) |
| `/api/administrative/**`| `form-data-service` | `9002` | JWT Authenticated | Legacy Administrative Section Tables |
| `/api/submissions/**` | `submission-service`| `9003` | JWT Authenticated | Draft Save/Load, Final Submission, Reviews, Snapshots, Exports |
| `/api/audit-cycles/**` | `submission-service`| `9003` | Admin / Reviewer | Academic Year Cycles, Active Cycle Lookup, Next Year Creation |
| `/api/attachments/**` | `storage-service` | `9004` | JWT Authenticated | Multipart Attachment Upload, Multi-Upload, Delete |
| `/uploads/**` | `storage-service` | `9004` | Public Static Proxy | Public Static Attachment Streaming |
| `/api/backup/**` | `admin-service` | `9005` | Admin / IQAC | Database SQL Dump/Restore, Attachments Archive Backup/Restore |

---

## 1. Authentication & Identity (`auth-user-service` - Port 9001)

### `POST /api/auth/login`
Authenticates user with email/username and password. Supports sliding-window rate limiting.
* **Request Payload**:
  ```json
  {
    "identifier": "director@dypiu.ac.in",
    "password": "[PASSWORD]"
  }
  ```
* **Response (`200 OK`)**:
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "refreshToken": "a6afec4d-c239-402b-91f2-e065c7b1d742",
    "tokenType": "Bearer",
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
* **Response (`200 OK`)**: `{"token": "...", "refreshToken": "...", "tokenType": "Bearer"}`

### `POST /api/auth/verify-otp` & `POST /api/auth/mfa`
Completes MFA login challenge with one-time password verification.

### `POST /api/auth/forgot-password` & `POST /api/auth/reset-password`
Initiates and completes self-service password reset flows.

---

## 2. Dynamic Form Configuration & Universities (`form-data-service` - Port 9002)

### `GET /api/config/active`
Retrieves the compiled active form schema AST for a given university and audit type.
* **Query Parameters**: `auditType` (`academic` or `administrative`), `universityCode` (`dypiu`)
* **Response (`200 OK`)**:
  ```json
  {
    "schemaId": 1,
    "versionId": 2,
    "versionNumber": 2,
    "status": "PUBLISHED",
    "universityId": 1,
    "sections": [
      {
        "id": 10,
        "sectionKey": "academic_activities",
        "title": "Part A: Academic Activities",
        "displayOrder": 1,
        "tables": [
          {
            "id": 25,
            "tableKey": "board_of_studies",
            "title": "Board of Studies Meetings",
            "isRepeatable": true,
            "fields": [
              { "fieldKey": "sr_no", "label": "Sr No", "fieldType": "TEXT" },
              { "fieldKey": "date_of_meeting", "label": "Date of Meeting", "fieldType": "DATE", "isRequired": true },
              { "fieldKey": "mom_doc", "label": "Meeting Minutes", "fieldType": "ATTACHMENT" }
            ]
          }
        ]
      }
    ]
  }
  ```

### `GET /api/config/branding`
Retrieves university colors, logos, and custom display properties (`GET /api/config/branding?universityCode=dypiu`).

### Admin Form Studio Configuration APIs (`/api/admin/config/**`):
* **`GET /api/admin/config/schemas`**: List schemas by university.
* **`POST /api/admin/config/schemas`**: Create new schema definition.
* **`POST /api/admin/config/schemas/{schemaId}/draft`**: Clone schema into an editable DRAFT version.
* **`GET /api/admin/config/versions/{versionId}`**: Fetch full editable AST for builder canvas.
* **`POST /api/admin/config/versions/{versionId}/publish`**: Freeze and activate schema version.
* **`POST /api/admin/config/schemas/{schemaId}/rollback?targetVersionId={id}`**: Rollback active version.
* **`POST /api/admin/config/sections`**, **`PUT /api/admin/config/sections/{id}`**, **`DELETE /api/admin/config/sections/{id}`**: Section CRUD.
* **`PUT /api/admin/config/versions/{versionId}/reorder-sections`**: Reorder sections.
* **`POST /api/admin/config/tables`**, **`PUT /api/admin/config/tables/{id}`**, **`DELETE /api/admin/config/tables/{id}`**: Table CRUD.
* **`PUT /api/admin/config/sections/{sectionId}/reorder-tables`**: Reorder tables.
* **`POST /api/admin/config/fields`**, **`PUT /api/admin/config/fields/{id}`**, **`DELETE /api/admin/config/fields/{id}`**: Field CRUD.
* **`PUT /api/admin/config/tables/{tableId}/reorder-fields`**: Reorder fields.

---

## 3. Appraisal Submissions & Reviews (`submission-service` - Port 9003)

### `GET /api/submissions/my-draft`
Fetches the active contributor's saved draft based on JWT identity and audit cycle.

### `POST /api/submissions/save-draft`
Saves incremental form data as JSONB.
* **Request Payload**:
  ```json
  {
    "auditType": "academic",
    "valuesData": "{\"directorName\":\"Prof. Dr. Director\"}",
    "tablesData": "{\"board_of_studies\":[{\"date_of_meeting\":\"2026-01-15\",\"mom_doc\":\"/uploads/...\"}]}",
    "attachments": "[\"/uploads/...\"]"
  }
  ```

### `POST /api/submissions/submit`
Validates required fields, freezes draft, and transitions status to `SUBMITTED`.

### `POST /api/submissions/{id}/review`
IQAC / VC review action (approve, request changes, or forward to auditor).

### `GET /api/submissions/export/excel` & `GET /api/submissions/export/pdf`
Streams generated binary reports for an individual submission.

### `GET /api/submissions/export/consolidated-excel`
Streams multi-sheet consolidated Excel workbook for all school submissions.

---

## 4. File Storage & Attachments (`storage-service` - Port 9004)

### `POST /api/attachments/upload`
Uploads a multipart file with MIME and extension validation.
* **Content-Type**: `multipart/form-data`
* **Response (`200 OK`)**:
  ```json
  {
    "url": "/uploads/users/a9f1b2c3/attachments/grant_letter-7b19de34.pdf",
    "filename": "grant_letter.pdf",
    "size": 184320
  }
  ```

### `POST /api/attachments/upload-multiple`
Batch multipart file upload returning an array of attachment metadata objects.

### `DELETE /api/attachments/delete`
Deletes attachment reference with ownership key verification.

---

## 5. System Backups (`admin-service` - Port 9005)

* **`GET /api/backup/db`**: Generates and streams PostgreSQL SQL database dump.
* **`POST /api/backup/db/restore`**: Restores database state from uploaded `.sql` file.
* **`GET /api/backup/uploads`**: Generates and streams `.zip` archive of user file attachments.
* **`POST /api/backup/uploads/restore`**: Unpacks and restores attachment archive.

---

## 6. Standardized Error Response Contract

All microservices return structured `ApiErrorResponse` JSON objects for any 4xx or 5xx response:

```json
{
  "timestamp": "2026-08-22T20:38:16.336Z",
  "status": 404,
  "error": "Not Found",
  "code": "RESOURCE_NOT_FOUND",
  "message": "Schema not found: 999",
  "path": "/api/config/schemas/999",
  "correlationId": "e1a3f742-8321-4f91-912a-48d5c4129b01",
  "details": []
}
```
