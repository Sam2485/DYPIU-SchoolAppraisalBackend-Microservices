# API Endpoints Documentation & Gateway Routing Catalog

This document catalogs all the REST API endpoints exposed by the **School Appraisal System** and their routing specifications across the microservices architecture.

---

## 🚦 API Gateway Routing Overview

All frontend requests route through the centralized **API Gateway** (`http://localhost:8080`). The Gateway validates JWT Bearer tokens and forwards context headers (`X-User-Email`, `X-User-Role`) to target microservices:

| Path Prefix | Targeted Microservice Module | Internal Port | Whitelisted / Public Endpoints |
| :--- | :--- | :---: | :--- |
| `/api/auth/**` | `auth-user-service` | `8081` | `/login`, `/register`, `/refresh`, `/forgot-password`, `/reset-password`, `/verify-otp`, `/mfa` |
| `/api/users/**` | `auth-user-service` | `8081` | Requires `ROLE_IQAC` |
| `/api/academic/**` | `form-data-service` | `8082` | Requires JWT Bearer Token |
| `/api/administrative/**` | `form-data-service` | `8082` | Requires JWT Bearer Token |
| `/api/submissions/**` | `submission-service` | `8083` | Requires JWT Bearer Token |
| `/api/audit-cycles/**` | `submission-service` | `8083` | Requires JWT Bearer Token |
| `/api/attachments/**` | `storage-service` | `8084` | Requires JWT Bearer Token |
| `/uploads/**` | `storage-service` | `8084` | Public Static Uploads Proxy |
| `/api/backup/**` | `admin-service` | `8085` | Requires `ROLE_IQAC` |

---

## 1. Authentication Module (`auth-user-service` - Port 8081)
**Base Path**: `/api/auth`

### User Login
- **URL**: `/login`
- **Method**: `POST`
- **Headers**: `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "username": "director@dypiu.ac.in",
    "password": "Director@123"
  }
  ```
- **Response (200 OK)**:
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "refreshToken": "a6afec4d-c239-402b-91f2-e065c7b1d742",
    "refreshTokenExpiresIn": 604800,
    "email": "director@dypiu.ac.in",
    "name": "Director of Schools",
    "designation": "Director",
    "school": "School of Computer Science Engg. & App.",
    "role": "director",
    "id": 2,
    "userId": 2,
    "accountType": "user",
    "category": "academic"
  }
  ```

### Refresh Access Token
- **URL**: `/refresh`
- **Method**: `POST`
- **Headers**: `Content-Type: application/json`
- **Request Body**:
  ```json
  {
    "refreshToken": "a6afec4d-c239-402b-91f2-e065c7b1d742"
  }
  ```
- **Response (200 OK)**:
  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "accessToken": "eyJhbGciOiJIUzI1NiJ9...",
    "refreshToken": "a6afec4d-c239-402b-91f2-e065c7b1d742",
    "tokenType": "Bearer",
    "expiresIn": 86400
  }
  ```

### User Logout
- **URL**: `/logout`
- **Method**: `POST`
- **Request Body**: `{"refreshToken": "..."}`
- **Response (200 OK)**: `{"message": "Logged out successfully."}`

### Forgot Password
- **URL**: `/forgot-password`
- **Method**: `POST`
- **Request Body**: `{"email": "director@dypiu.ac.in"}`
- **Response (200 OK)**: `{"message": "If that email is registered, a reset link has been generated."}`

### Reset Password
- **URL**: `/reset-password`
- **Method**: `POST`
- **Request Body**: `{"token": "...", "newPassword": "newSecretPassword123"}`
- **Response (200 OK)**: `{"message": "Password has been reset successfully."}`

---

## 2. Appraisal Submissions Module (`submission-service` - Port 8083)
**Base Path**: `/api/submissions`
**Headers**: `Authorization: Bearer <jwt-token>`

### Get Submitter's Draft
- **URL**: `/my-draft`
- **Method**: `GET`
- **Query Params**: `auditType` (`academic` or `administrative`)
- **Response (200 OK)**: `Submission` entity object.

### Save Form Draft
- **URL**: `/save-draft`
- **Method**: `POST` | `PUT`
- **Request Body**: Draft payload (`auditType`, `valuesData`, `tablesData`, `attachments`).

### Submit Form
- **URL**: `/submit`
- **Method**: `POST` | `PUT`
- **Response (200 OK)**: Submission object with status `SUBMITTED`.

### Get All Submissions
- **URL**: `/all`
- **Method**: `GET`
- **Access Rule**: Role-based scoping for IQAC, VC, and assigned Auditors.

---

## 3. Attachments & Storage Module (`storage-service` - Port 8084)
**Base Path**: `/api/attachments`

### Upload Document
- **URL**: `/upload`
- **Method**: `POST`
- **Content-Type**: `multipart/form-data`
- **Request Params**: `file` (PDF file, max 10MB)
- **Response (200 OK)**: `{"name": "...", "url": "/uploads/..."}`

### Delete Document
- **URL**: `/delete`
- **Method**: `DELETE`
- **Query Params**: `url` (Attachment URL)
- **Response (200 OK)**: `{"message": "File deleted successfully."}`

---

## 4. User Management Module (`auth-user-service` - Port 8081)
**Base Path**: `/api/users`
**Headers**: `Authorization: Bearer <jwt-token>` (IQAC Only)

- **GET `/`**: Retrieve all user profiles.
- **POST `/`**: Create standard user or auditor account.
- **PUT `/{id}`**: Update user profile or password.
- **DELETE `/{id}`**: Delete user profile.

---

## 5. System Backup Module (`admin-service` - Port 8085)
**Base Path**: `/api/backup`
**Headers**: `Authorization: Bearer <jwt-token>` (IQAC Only)

- **GET `/db`**: Export database dump file (`.sql`).
- **POST `/db/restore`**: Restore database from dump file.
- **GET `/uploads`**: Export user upload attachments archive (`.zip`).
- **POST `/uploads/restore`**: Restore user upload attachments from archive.
