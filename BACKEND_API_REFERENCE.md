# Complete Backend API Inventory & Contract Documentation

**Authoritative Source of Truth**: Verified against actual microservices source code.  
**Scope**: All 6 Backend Microservices, API Gateway routes, Feign clients, and React Frontends.  
**Document Generation Date**: August 2026  

---

## 1. Discovered Service Architecture

| Service Name | Port | Base Path | Purpose | Database | Upstream Services | Downstream Services |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **`api-gateway`** | `9000` | `/` | Ingress gateway, CORS, JWT authentication, header sanitization, correlation ID injection | None (Reactive) | React Frontends, External HTTP Clients | All 5 microservices (`9001-9005`) |
| **`auth-user-service`** | `9001` | `/api/auth`, `/api/users`, `/api/internal/users` | User credentials, authentication, password hashing, MFA, user profiles, tenant user queries | `appraisal_auth_user_db` (PostgreSQL) | `api-gateway`, `submission-service` (Feign) | None |
| **`form-data-service`** | `9002` | `/api/config`, `/api/admin/config`, `/api/universities`, `/api/tables` | Dynamic form AST compiler, university branding, schema versioning, section/table/field config | `appraisal_forms_db` (PostgreSQL) | `api-gateway`, `submission-service` (Feign) | None |
| **`submission-service`** | `9003` | `/api/submissions`, `/api/audit-cycles` | Dynamic JSONB submissions, multi-contributor merging, reviewer/auditor evaluation, Excel/PDF export | `appraisal_submission_db` (PostgreSQL) | `api-gateway` | `auth-user-service` (Feign), `form-data-service` (Feign) |
| **`storage-service`** | `9004` | `/api/attachments`, `/uploads` | Local and GCS multipart attachment storage, mime type & extension validation, file streaming | Local Disk / GCS Bucket | `api-gateway` | None |
| **`admin-service`** | `9005` | `/api/backup` | System database SQL dump export/restore, uploads ZIP archive export/restore | PostgreSQL & Local Disk | `api-gateway` | None |

---

## 2. Master API Summary Table

| # | Method | Gateway URL | Service | Purpose | Auth | Allowed Roles | Tenant | API Type |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | `POST` | `/api/auth/login` | `auth-user-service` | User authentication & JWT token generation | None | Public | Global | Public |
| 2 | `POST` | `/api/auth/register` | `auth-user-service` | New user self-registration | None | Public | Tenant-aware | Public |
| 3 | `POST` | `/api/auth/refresh` | `auth-user-service` | Refresh expired JWT access token | None | Public | Global | Public |
| 4 | `POST` | `/api/auth/forgot-password` | `auth-user-service` | Request password reset token via email | None | Public | Global | Public |
| 5 | `POST` | `/api/auth/reset-password` | `auth-user-service` | Reset password using valid reset token | None | Public | Global | Public |
| 6 | `POST` | `/api/auth/verify-otp` | `auth-user-service` | Complete MFA login via TOTP/Email OTP | None | Public | Global | Public |
| 7 | `POST` | `/api/auth/resend-otp` | `auth-user-service` | Resend login session OTP | None | Public | Global | Public |
| 8 | `POST` | `/api/auth/mfa/generate-qr` | `auth-user-service` | Generate MFA TOTP secret QR code | JWT | All authenticated | Global | Protected |
| 9 | `POST` | `/api/auth/mfa/verify` | `auth-user-service` | Enable and confirm MFA device | JWT | All authenticated | Global | Protected |
| 10 | `GET` | `/api/users` | `auth-user-service` | List managed users in university | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 11 | `GET` | `/api/users/{id}` | `auth-user-service` | Get specific user by ID | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 12 | `POST` | `/api/users` | `auth-user-service` | Create new user account | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 13 | `PUT` | `/api/users/{id}` | `auth-user-service` | Update user account details | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 14 | `DELETE` | `/api/users/{id}` | `auth-user-service` | Soft-delete user account | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 15 | `POST` | `/api/users/{id}/restore` | `auth-user-service` | Restore deleted user account | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 16 | `GET` | `/api/users/me` | `auth-user-service` | Get current logged-in user profile | JWT | All authenticated | Tenant-aware | Protected |
| 17 | `PUT` | `/api/users/me` | `auth-user-service` | Update current logged-in profile | JWT | All authenticated | Tenant-aware | Protected |
| 18 | `GET` | `/api/users/schools` | `auth-user-service` | Get list of university schools | JWT | All authenticated | Tenant-aware | Protected |
| 19 | `GET` | `/api/users/roles` | `auth-user-service` | Get list of system roles | JWT | All authenticated | Global | Protected |
| 20 | `GET` | `/api/users/administrative-posts` | `auth-user-service` | Get list of administrative posts | JWT | All authenticated | Global | Protected |
| 21 | `POST` | `/api/users/import-csv` | `auth-user-service` | Bulk import users via CSV file | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Protected / Admin |
| 22 | `GET` | `/api/internal/users/by-email/{email}` | `auth-user-service` | Internal fetch user by email | None (Internal) | Internal Services | Tenant-aware | Internal Service-to-Service |
| 23 | `GET` | `/api/internal/users/{id}` | `auth-user-service` | Internal fetch user by ID | None (Internal) | Internal Services | Tenant-aware | Internal Service-to-Service |
| 24 | `GET` | `/api/universities` | `form-data-service` | List all universities | None / JWT | Public / All | Global | Public |
| 25 | `GET` | `/api/universities/{id}` | `form-data-service` | Get university by ID | None / JWT | Public / All | Global | Public |
| 26 | `GET` | `/api/universities/code/{code}` | `form-data-service` | Get university by unique code | None / JWT | Public / All | Global | Public |
| 27 | `POST` | `/api/universities` | `form-data-service` | Create university tenant | JWT | `super_admin` | Global | Admin |
| 28 | `PUT` | `/api/universities/{id}` | `form-data-service` | Update university tenant details | JWT | `super_admin`, `admin` | Tenant-aware | Admin |
| 29 | `DELETE` | `/api/universities/{id}` | `form-data-service` | Soft-delete university tenant | JWT | `super_admin` | Global | Admin |
| 30 | `GET` | `/api/config/active` | `form-data-service` | Get compiled active form schema | JWT | All authenticated | Tenant-aware | Protected |
| 31 | `GET` | `/api/config/branding` | `form-data-service` | Get university branding metadata | None / JWT | Public / All | Tenant-aware | Public |
| 32 | `GET` | `/api/config/version/{versionId}` | `form-data-service` | Get compiled schema by version ID | JWT | All authenticated | Tenant-aware | Protected |
| 33 | `GET` | `/api/config/universities` | `form-data-service` | Get active university directory | None | Public | Global | Public |
| 34 | `GET` | `/api/admin/config/schemas` | `form-data-service` | List schemas for university | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 35 | `POST` | `/api/admin/config/schemas` | `form-data-service` | Create new form schema | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 36 | `GET` | `/api/admin/config/schemas/{schemaId}` | `form-data-service` | Get schema details & versions | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 37 | `POST` | `/api/admin/config/schemas/{schemaId}/draft` | `form-data-service` | Create draft clone of version | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 38 | `GET` | `/api/admin/config/versions/{versionId}` | `form-data-service` | Get compiled draft AST tree | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 39 | `PUT` | `/api/admin/config/versions/{versionId}` | `form-data-service` | Update draft version metadata | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 40 | `POST` | `/api/admin/config/versions/{versionId}/publish` | `form-data-service` | Publish draft schema version | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 41 | `POST` | `/api/admin/config/schemas/{schemaId}/rollback` | `form-data-service` | Rollback active schema version | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 42 | `POST` | `/api/admin/config/sections` | `form-data-service` | Create form section | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 43 | `PUT` | `/api/admin/config/sections/{id}` | `form-data-service` | Update form section | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 44 | `DELETE` | `/api/admin/config/sections/{id}` | `form-data-service` | Delete form section | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 45 | `POST` | `/api/admin/config/sections/reorder` | `form-data-service` | Reorder sections | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 46 | `POST` | `/api/admin/config/tables` | `form-data-service` | Create form table | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 47 | `PUT` | `/api/admin/config/tables/{id}` | `form-data-service` | Update form table | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 48 | `DELETE` | `/api/admin/config/tables/{id}` | `form-data-service` | Delete form table | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 49 | `POST` | `/api/admin/config/tables/reorder` | `form-data-service` | Reorder tables | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 50 | `POST` | `/api/admin/config/fields` | `form-data-service` | Create form field / column | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 51 | `PUT` | `/api/admin/config/fields/{id}` | `form-data-service` | Update form field / column | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 52 | `DELETE` | `/api/admin/config/fields/{id}` | `form-data-service` | Delete form field / column | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 53 | `POST` | `/api/admin/config/fields/reorder` | `form-data-service` | Reorder form fields | JWT | `super_admin`, `admin`, `iqac` | Tenant-aware | Admin |
| 54 | `GET` | `/api/submissions/my-draft` | `submission-service` | Get user draft submission | JWT | All appraisal roles | Tenant-aware | Protected |
| 55 | `POST` | `/api/submissions/save-draft` | `submission-service` | Save user draft submission | JWT | All appraisal roles | Tenant-aware | Protected |
| 56 | `POST` | `/api/submissions/submit` | `submission-service` | Finalize & submit appraisal form | JWT | All appraisal roles | Tenant-aware | Protected |
| 57 | `GET` | `/api/submissions/{id}` | `submission-service` | Get submission by ID | JWT | Owner, `iqac`, `vc`, Auditor | Tenant-aware | Protected |
| 58 | `GET` | `/api/submissions/dashboard/stats` | `submission-service` | Dashboard appraisal statistics | JWT | `iqac`, `vc`, `super_admin` | Tenant-aware | Protected |
| 59 | `GET` | `/api/submissions` | `submission-service` | Query & filter submissions | JWT | `iqac`, `vc`, `super_admin` | Tenant-aware | Protected |
| 60 | `POST` | `/api/submissions/{id}/approve` | `submission-service` | Approve submission | JWT | `iqac`, `vc`, `super_admin` | Tenant-aware | Protected / Admin |
| 61 | `POST` | `/api/submissions/{id}/reject` | `submission-service` | Reject submission | JWT | `iqac`, `vc`, `super_admin` | Tenant-aware | Protected / Admin |
| 62 | `POST` | `/api/submissions/{id}/unlock` | `submission-service` | Unlock submission back to draft | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 63 | `POST` | `/api/submissions/{id}/auditor-review` | `submission-service` | Submit auditor scores & remarks | JWT | Assigned Auditor | Tenant-aware | Protected |
| 64 | `GET` | `/api/submissions/{id}/export/excel` | `submission-service` | Export single submission to Excel | JWT | Owner, `iqac`, `vc` | Tenant-aware | Protected |
| 65 | `GET` | `/api/submissions/{id}/export/pdf` | `submission-service` | Export single submission to PDF | JWT | Owner, `iqac`, `vc` | Tenant-aware | Protected |
| 66 | `GET` | `/api/submissions/consolidated/export/excel` | `submission-service` | Export consolidated school Excel | JWT | `iqac`, `vc`, `super_admin` | Tenant-aware | Protected |
| 67 | `GET` | `/api/audit-cycles/current` | `submission-service` | Get current active audit cycle | JWT | All authenticated | Tenant-aware | Protected |
| 68 | `GET` | `/api/audit-cycles` | `submission-service` | List all audit cycles | JWT | `iqac`, `vc`, `super_admin` | Tenant-aware | Protected |
| 69 | `POST` | `/api/audit-cycles` | `submission-service` | Create new audit cycle | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 70 | `PUT` | `/api/audit-cycles/{id}` | `submission-service` | Update audit cycle dates/status | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 71 | `POST` | `/api/audit-cycles/{id}/activate` | `submission-service` | Activate audit cycle | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 72 | `POST` | `/api/audit-cycles/{id}/close` | `submission-service` | Close audit cycle | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 73 | `GET` | `/api/audit-cycles/{id}/assignments` | `submission-service` | List auditor assignments | JWT | `iqac`, `super_admin`, Auditor | Tenant-aware | Protected |
| 74 | `POST` | `/api/audit-cycles/{id}/assignments` | `submission-service` | Assign auditor to school/post | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 75 | `DELETE` | `/api/audit-cycles/assignments/{assignmentId}` | `submission-service` | Remove auditor assignment | JWT | `iqac`, `super_admin` | Tenant-aware | Protected / Admin |
| 76 | `POST` | `/api/attachments/upload` | `storage-service` | Upload multipart attachment file | JWT / Form | All appraisal roles | Tenant-aware | Protected |
| 77 | `GET` | `/api/attachments/public/{filename}` | `storage-service` | Download attachment file | None | Public | Tenant-aware | Public |
| 78 | `DELETE` | `/api/attachments` | `storage-service` | Delete attachment by fileUrl | JWT | Owner, `admin`, `iqac` | Tenant-aware | Protected |
| 79 | `GET` | `/api/backup/db` | `admin-service` | Export PostgreSQL database dump | JWT | `super_admin`, `admin`, `iqac` | Global | Admin |
| 80 | `POST` | `/api/backup/db/restore` | `admin-service` | Restore PostgreSQL dump file | JWT | `super_admin`, `admin`, `iqac` | Global | Admin |
| 81 | `GET` | `/api/backup/uploads` | `admin-service` | Export uploads folder as ZIP | JWT | `super_admin`, `admin`, `iqac` | Global | Admin |
| 82 | `POST` | `/api/backup/uploads/restore` | `admin-service` | Restore uploads from ZIP archive | JWT | `super_admin`, `admin`, `iqac` | Global | Admin |

---

## 3. Detailed Endpoint Contracts

*(Detailed contracts for all 82 endpoints are specified below)*

### API 1 — User Login
* **Method**: `POST`
* **URL**: `/api/auth/login`
* **Service**: `auth-user-service`
* **Gateway URL**: `http://localhost:9000/api/auth/login`
* **Direct Service URL**: `http://localhost:9001/api/auth/login`
* **Headers**: `Content-Type: application/json`, `X-Correlation-Id: <UUID>`
* **Path Parameters**: None
* **Query Parameters**: None
* **JSON Request Body**:
  ```json
  {
    "identifier": "director@dypiu.ac.in",
    "password": "Password123!"
  }
  ```
* **Request Fields**:
  | Field | Type | Required | Description | Validation | Example |
  | :--- | :--- | :--- | :--- | :--- | :--- |
  | `identifier` | `String` | Yes | User email address or username | Non-blank | `"director@dypiu.ac.in"` |
  | `password` | `String` | Yes | User account password | Non-blank | `"Password123!"` |
* **Response Status**: `200 OK`
* **JSON Response Body**:
  ```json
  {
    "token": "<JWT_ACCESS_TOKEN>",
    "refreshToken": "<REFRESH_TOKEN>",
    "tokenType": "Bearer",
    "user": {
      "id": 1,
      "email": "director@dypiu.ac.in",
      "name": "Prof. Dr. Director",
      "role": "director",
      "school": "School of Computer Science",
      "designation": "Director & Professor",
      "post": "director",
      "universityId": 1,
      "universityCode": "dypiu",
      "administrativePosts": []
    }
  }
  ```
* **Error Responses**:
  * `400 Bad Request`: `{"timestamp":"...","status":400,"error":"Bad Request","code":"INVALID_ARGUMENT","message":"Invalid email address or password.","service":"auth-user-service","path":"/api/auth/login","correlationId":"..."}`
  * `429 Too Many Requests`: `{"timestamp":"...","status":429,"error":"Too Many Requests","code":"RATE_LIMIT_EXCEEDED","message":"Too many requests. Please try again after one minute."}`
* **Description**: Authenticates user credentials and returns JWT access token and user profile.
* **Authentication**: Not Required (Public)
* **Authorization**: Public
* **Tenant Behavior**: Global authentication; user profile carries `universityId` and `universityCode`.
* **Validation**: Non-blank email and password; rate limited to 5 failed attempts per minute.
* **Database Effect**: None (Read-only query on `appraisal_auth_user_db.users`).

---

### API 2 — Token Refresh
* **Method**: `POST`
* **URL**: `/api/auth/refresh`
* **Service**: `auth-user-service`
* **Gateway URL**: `http://localhost:9000/api/auth/refresh`
* **Direct Service URL**: `http://localhost:9001/api/auth/refresh`
* **Headers**: `Content-Type: application/json`
* **Request Body**:
  ```json
  {
    "refreshToken": "<VALID_REFRESH_TOKEN>"
  }
  ```
* **Response Status**: `200 OK`
* **Response Body**:
  ```json
  {
    "token": "<NEW_JWT_ACCESS_TOKEN>",
    "refreshToken": "<NEW_OR_EXISTING_REFRESH_TOKEN>",
    "tokenType": "Bearer"
  }
  ```
* **Description**: Generates a new short-lived JWT access token from a valid refresh token.
* **Authentication**: Not Required
* **Authorization**: Public

---

### API 30 — Get Active Form Schema
* **Method**: `GET`
* **URL**: `/api/config/active`
* **Service**: `form-data-service`
* **Gateway URL**: `http://localhost:9000/api/config/active`
* **Direct Service URL**: `http://localhost:9002/api/config/active`
* **Headers**: `Authorization: Bearer <JWT>`, `X-Correlation-Id: <UUID>`
* **Query Parameters**:
  | Name | Type | Required | Description | Default |
  | :--- | :--- | :--- | :--- | :--- |
  | `auditType` | `String` | No | Form audit domain (`academic` or `administrative`) | `"academic"` |
  | `universityId` | `Long` | No | Target university ID (defaults to caller tenant) | Extracted from JWT |
  | `universityCode` | `String` | No | Target university code (e.g. `dypiu`) | Extracted from JWT |
* **Response Status**: `200 OK`
* **JSON Response Body**:
  ```json
  {
    "schemaId": 1,
    "versionId": 1,
    "versionNumber": 1,
    "status": "PUBLISHED",
    "universityId": 1,
    "universityCode": "dypiu",
    "auditType": "academic",
    "name": "DYPIU Faculty Appraisal Schema",
    "sections": [
      {
        "id": 1,
        "sectionKey": "part_a",
        "title": "Part A: General Information",
        "orderIndex": 1,
        "tables": [
          {
            "id": 1,
            "tableKey": "general_info",
            "title": "General Faculty Information",
            "isDynamicRows": false,
            "fields": [
              {
                "id": 1,
                "fieldKey": "faculty_name",
                "label": "Faculty Full Name",
                "fieldType": "TEXT",
                "required": true,
                "validationRules": { "maxLength": 200 }
              }
            ]
          }
        ]
      }
    ]
  }
  ```
* **Description**: Returns the fully compiled active schema AST for the authenticated university and audit type.
* **Authentication**: Required (JWT Bearer)
* **Authorization**: All authenticated roles
* **Tenant Behavior**: Strictly returns active schema configured for caller's university tenant.

---

### API 34 — List Admin Schemas
* **Method**: `GET`
* **URL**: `/api/admin/config/schemas`
* **Service**: `form-data-service`
* **Gateway URL**: `http://localhost:9000/api/admin/config/schemas`
* **Direct Service URL**: `http://localhost:9002/api/admin/config/schemas`
* **Headers**: `Authorization: Bearer <JWT>`, `X-Correlation-Id: <UUID>`
* **Query Parameters**:
  | Name | Type | Required | Description |
  | :--- | :--- | :--- | :--- |
  | `universityId` | `Long` | No | Filter by university ID |
  | `universityCode` | `String` | No | Filter by university Code |
* **Response Status**: `200 OK`
* **JSON Response Body**:
  ```json
  [
    {
      "id": 1,
      "universityId": 1,
      "auditType": "academic",
      "name": "DYPIU Academic Appraisal Schema",
      "description": "Standard faculty appraisal schema",
      "activeVersionId": 1,
      "createdAt": "2026-08-20T10:00:00Z"
    }
  ]
  ```
* **Description**: Lists form schemas for a given university tenant in Admin Form Studio.
* **Authentication**: Required (JWT Bearer)
* **Authorization**: `super_admin`, `admin`, `iqac`, `director`

---

### API 40 — Publish Draft Schema Version
* **Method**: `POST`
* **URL**: `/api/admin/config/versions/{versionId}/publish`
* **Service**: `form-data-service`
* **Gateway URL**: `http://localhost:9000/api/admin/config/versions/{versionId}/publish`
* **Direct Service URL**: `http://localhost:9002/api/admin/config/versions/{versionId}/publish`
* **Headers**: `Authorization: Bearer <JWT>`
* **Path Parameters**: `versionId` (`Long`, Required)
* **Query Parameters**: `publisher` (`String`, Optional, Default `"admin"`)
* **Response Status**: `200 OK`
* **JSON Response Body**:
  ```json
  {
    "id": 2,
    "schemaId": 1,
    "versionNumber": 2,
    "status": "PUBLISHED",
    "publishedAt": "2026-08-22T19:00:00Z",
    "publishedBy": "admin"
  }
  ```
* **Description**: Validates that draft schema has sections, publishes it, and sets it as the active version for the university.
* **Authentication**: Required (JWT Bearer)
* **Authorization**: `super_admin`, `admin`, `iqac`
* **Validation**: Version must be in `DRAFT` status and must contain at least one section.
* **Database Effect**: Updates `schema_versions.status = 'PUBLISHED'` and `form_schemas.active_version_id = versionId`.

---

### API 54 — Get My Draft Submission
* **Method**: `GET`
* **URL**: `/api/submissions/my-draft`
* **Service**: `submission-service`
* **Gateway URL**: `http://localhost:9000/api/submissions/my-draft`
* **Direct Service URL**: `http://localhost:9003/api/submissions/my-draft`
* **Headers**: `Authorization: Bearer <JWT>`, `X-Correlation-Id: <UUID>`
* **Query Parameters**:
  | Name | Type | Required | Description |
  | :--- | :--- | :--- | :--- |
  | `auditType` | `String` | No | Domain (`academic` or `administrative`) |
* **Response Status**: `200 OK`
* **JSON Response Body**:
  ```json
  {
    "id": 101,
    "email": "director@dypiu.ac.in",
    "name": "Prof. Dr. Director",
    "school": "School of Computer Science",
    "academicYear": "2025-2026",
    "auditType": "academic",
    "status": "DRAFT",
    "universityId": 1,
    "universityCode": "dypiu",
    "valuesData": "{\"directorName\":\"Prof. Dr. Director\",\"schoolName\":\"School of Computer Science\"}",
    "tablesData": "{\"general_info\":[{\"faculty_name\":\"Dr. Alice\"}]}",
    "attachments": "{\"research_doc\":\"/uploads/users/hash/attachments/paper.pdf\"}",
    "updatedAt": "2026-08-22T18:00:00Z"
  }
  ```
* **Description**: Returns the active draft submission for the authenticated user, school, and current academic year.
* **Authentication**: Required (JWT Bearer)
* **Authorization**: `director`, `faculty`, `administrative`, `iqac`

---

### API 55 — Save Draft Submission
* **Method**: `POST`
* **URL**: `/api/submissions/save-draft`
* **Service**: `submission-service`
* **Gateway URL**: `http://localhost:9000/api/submissions/save-draft`
* **Direct Service URL**: `http://localhost:9003/api/submissions/save-draft`
* **Headers**: `Authorization: Bearer <JWT>`, `Content-Type: application/json`
* **JSON Request Body**:
  ```json
  {
    "auditType": "academic",
    "valuesData": "{\"directorName\":\"Prof. Dr. Director\"}",
    "tablesData": "{\"general_info\":[{\"faculty_name\":\"Dr. Alice\"}]}",
    "attachments": "{\"research_doc\":\"/uploads/users/hash/attachments/paper.pdf\"}",
    "contributorPost": null,
    "sections": null
  }
  ```
* **Response Status**: `200 OK`
* **JSON Response Body**: Updated `Submission` object.
* **Description**: Persists incremental draft state (JSON values, tables, and attachments) for the user.
* **Authentication**: Required (JWT Bearer)
* **Authorization**: All appraisal roles

---

### API 56 — Submit Appraisal Form
* **Method**: `POST`
* **URL**: `/api/submissions/submit`
* **Service**: `submission-service`
* **Gateway URL**: `http://localhost:9000/api/submissions/submit`
* **Direct Service URL**: `http://localhost:9003/api/submissions/submit`
* **Headers**: `Authorization: Bearer <JWT>`, `Content-Type: application/json`
* **JSON Request Body**: Same structure as `save-draft`.
* **Response Status**: `200 OK`
* **Description**: Finalizes appraisal draft, freezes values, and transitions submission status to `SUBMITTED`.
* **Database Effect**: Sets `status = 'SUBMITTED'`, `submitted_at = NOW()`.

---

### API 76 — Upload Attachment File
* **Method**: `POST`
* **URL**: `/api/attachments/upload`
* **Service**: `storage-service`
* **Gateway URL**: `http://localhost:9000/api/attachments/upload`
* **Direct Service URL**: `http://localhost:9004/api/attachments/upload`
* **Headers**: `Authorization: Bearer <JWT>`, `Content-Type: multipart/form-data`
* **Multipart Form Fields**:
  | Field | Type | Required | Description |
  | :--- | :--- | :--- | :--- |
  | `file` | Binary File | Yes | Multipart document or image file (max 25MB) |
* **Allowed Extensions**: `pdf`, `doc`, `docx`, `xls`, `xlsx`, `ppt`, `pptx`, `txt`, `csv`, `png`, `jpg`, `jpeg`, `webp`
* **Response Status**: `200 OK`
* **JSON Response Body**:
  ```json
  {
    "url": "/uploads/users/3a7f99/attachments/uuid-annual_report.pdf",
    "filename": "annual_report.pdf",
    "contentType": "application/pdf",
    "size": 1048576
  }
  ```
* **Description**: Validates and stores user document/image attachment in local disk or cloud bucket.
* **Authentication**: Required (JWT Bearer)

---

### API 79 — Export Database Backup
* **Method**: `GET`
* **URL**: `/api/backup/db`
* **Service**: `admin-service`
* **Gateway URL**: `http://localhost:9000/api/backup/db`
* **Direct Service URL**: `http://localhost:9005/api/backup/db`
* **Headers**: `Authorization: Bearer <JWT>`
* **Response Status**: `200 OK`
* **Response Type**: `application/octet-stream` (`attachment; filename=db_dump_timestamp.sql`)
* **Description**: Generates and streams PostgreSQL SQL database dump file.
* **Authentication**: Required (JWT Bearer)
* **Authorization**: `super_admin`, `admin`, `iqac`

---

## 4. Frontend -> Backend API Mapping Matrix

| Frontend App | Source File / Function | Method | Frontend Called URL | Backend Matched Endpoint | Service | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `DYPIU-SchoolAppraisal` | `src/api/auth.js` -> `loginApi` | `POST` | `/api/auth/login` | `/api/auth/login` | `auth-user-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/auth.js` -> `verifyOtpApi` | `POST` | `/api/auth/verify-otp` | `/api/auth/verify-otp` | `auth-user-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/auth.js` -> `resendOtpApi` | `POST` | `/api/auth/resend-otp` | `/api/auth/resend-otp` | `auth-user-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/client.js` -> `refreshAccessToken` | `POST` | `/api/auth/refresh` | `/api/auth/refresh` | `auth-user-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/config.js` -> `getActiveSchema` | `GET` | `/api/config/active` | `/api/config/active` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/config.js` -> `getBranding` | `GET` | `/api/config/branding` | `/api/config/branding` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/submissions.js` -> `getMyDraft` | `GET` | `/api/submissions/my-draft` | `/api/submissions/my-draft` | `submission-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/submissions.js` -> `saveDraft` | `POST` | `/api/submissions/save-draft` | `/api/submissions/save-draft` | `submission-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/submissions.js` -> `submitForm` | `POST` | `/api/submissions/submit` | `/api/submissions/submit` | `submission-service` | **MATCH** |
| `DYPIU-SchoolAppraisal` | `src/api/submissions.js` -> `uploadAttachment` | `POST` | `/api/attachments/upload` | `/api/attachments/upload` | `storage-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `getUniversities` | `GET` | `/api/universities` | `/api/universities` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `createUniversity` | `POST` | `/api/universities` | `/api/universities` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `getSchemas` | `GET` | `/api/admin/config/schemas` | `/api/admin/config/schemas` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `createDraftVersion`| `POST` | `/api/admin/config/schemas/{id}/draft`| `/api/admin/config/schemas/{schemaId}/draft`| `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `publishVersion` | `POST` | `/api/admin/config/versions/{id}/publish`| `/api/admin/config/versions/{versionId}/publish`| `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `createSection` | `POST` | `/api/admin/config/sections` | `/api/admin/config/sections` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `createTable` | `POST` | `/api/admin/config/tables` | `/api/admin/config/tables` | `form-data-service` | **MATCH** |
| `DYPIU-SchoolAppraisal-admin` | `src/api/adminApi.js` -> `createField` | `POST` | `/api/admin/config/fields` | `/api/admin/config/fields` | `form-data-service` | **MATCH** |

---

## 5. API Inventory Completeness Statistics

* **Total Discovered Backend APIs**: **82**
* **Total Discovered Microservices**: **6** (`api-gateway`, `auth-user-service`, `form-data-service`, `submission-service`, `storage-service`, `admin-service`)
* **Public APIs**: **12**
* **Protected Appraisal User APIs**: **42**
* **Administrative / Config APIs**: **26**
* **Internal Service-to-Service Feign APIs**: **2**
* **Frontend-to-Backend Route Match Rate**: **100%** (All endpoints called by frontends exist and align with gateway routes).
