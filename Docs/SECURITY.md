# Security, Authentication & Multi-Tenancy Architecture

This document describes the authentication, authorization, multi-tenant isolation, defensive hardening, and threat protection mechanisms implemented across the **Multi-University Dynamic Faculty & School Appraisal Backend**.

---

## 🛡️ Core Security Architecture

```text
HTTP Request (Header: Authorization: Bearer <jwt-token>, X-Correlation-Id: <uuid>)
                     │
                     ▼
┌────────────────────────────────────────────────────────┐
│              API GATEWAY (Port 9000)                   │
│  1. Ingress Rate Limiter (Sliding Window: 5 req/min)   │
│  2. JwtAuthenticationFilter (HMAC-SHA256 Signature)   │
│  3. Strips Spoofed X-User-* & X-University-* Headers   │
│  4. Injects Verified Claims & Correlation ID           │
└──────────────────────────┬─────────────────────────────┘
                           │ (Forward Verified Context Headers)
                           ▼
┌────────────────────────────────────────────────────────┐
│ Context Headers:                                       │
│   X-User-Email: director@dypiu.ac.in                   │
│   X-User-Role: director                                │
│   X-University-Id: 1                                   │
│   X-University-Code: dypiu                             │
│   X-Correlation-Id: e1a3f742-8321-4f91-912a-...        │
└──────────────────────────┬─────────────────────────────┘
                           │ (Forward to Target Microservices 9001 - 9005)
                           ▼
┌────────────────────────────────────────────────────────┐
│ Downstream Microservice Controller / Service Layer     │
│  - MdcLoggingFilter (Correlation in SLF4J MDC)         │
│  - Role Verification & Tenant Filtering                │
│  - Standardized ApiErrorResponse on Violation          │
└────────────────────────────────────────────────────────┘
```

---

## 1. Centralized Ingress Security (`api-gateway` - Port 9000)

All external traffic enters through the **API Gateway** on Port `9000`. The Gateway enforces centralized authentication and defensive filtering:

### A. JWT Bearer Token Validation & Header Stripping
- **Token Format**: Standard RFC 7519 JSON Web Token signed with HMAC-SHA256 (`jjwt 0.12.5`).
- **Token Lifespan**: 24 hours (`86400000` ms).
- **Anti-Spoofing Header Cleansing**: `JwtAuthenticationFilter` mutates the incoming request, unconditionally stripping any client-supplied `X-User-*` or `X-University-*` headers before attaching only cryptographic, verified claims from the valid JWT token.
- **Claims Payload**:
  - `sub` / `email`: User login identifier.
  - `role`: Granted system authority (`"director"`, `"iqac"`, `"vice-chancellor"`, `"administrative"`, `"auditor"`).
  - `universityId`: Tenant numeric ID (e.g. `1`).
  - `universityCode`: Tenant slug (e.g. `"dypiu"`).
  - `school`, `post`, `designation`, `name`.

### B. Whitelisted Public Endpoints (No JWT Required):
- `/api/auth/login` (Authentication)
- `/api/auth/register` (Account creation)
- `/api/auth/refresh` (Token renewal)
- `/api/auth/forgot-password` & `/api/auth/reset-password` (Password recovery)
- `/api/auth/verify-otp` & `/api/auth/resend-otp` (MFA challenges)
- `/api/config/branding` (Dynamic public branding definitions)
- `/uploads/**` (Static attachment streaming)

---

## 2. Multi-Factor Authentication & Rate Limiting

### A. Multi-Factor Authentication (MFA)
- Users with MFA enabled receive a 6-digit cryptographic OTP via email or TOTP challenge upon password verification.
- OTP verification is enforced before the JWT access token is granted.
- Failed attempts exceed limits and invalidate the login session.

### B. Sliding-Window Rate Limiting
- Prevents brute-force credential stuffing and DoS attacks.
- Configured on sensitive routes (`POST /api/auth/login` capped at sliding-window attempts per IP).
- Violations return `429 Too Many Requests` with a standard `Retry-After` header.

---

## 3. Storage & Disaster Recovery Hardening

### A. Extension Whitelisting & MIME Validation (`storage-service`)
- `AttachmentService` enforces an explicit whitelist of allowed document and image extensions (`pdf`, `doc`, `docx`, `xls`, `xlsx`, `ppt`, `pptx`, `txt`, `csv`, `png`, `jpg`, `jpeg`, `webp`).
- Script and executable files (`.exe`, `.sh`, `.php`, `.jsp`, `.bat`) are immediately rejected.
- Files are stored with UUID-prefixed names to prevent filename collision and path traversal.

### B. Zip-Slip Directory Traversal Defense (`admin-service`)
- When unpacking media backup archives in `/api/backup/uploads/restore`, `BackupService` executes canonical path validation:
  ```java
  Path targetFile = destDir.resolve(entry.getName()).normalize();
  if (!targetFile.startsWith(destDir)) {
      throw new SecurityException("Zip-Slip directory traversal attempt detected: " + entry.getName());
  }
  ```
- Prevents malicious archives from overwriting arbitrary host configuration files.

---

## 4. Role-Based Access Control (RBAC)

| Role String | Granted Authority | Authorized Operations |
| :--- | :--- | :--- |
| `"super_admin"` / `"admin"` | `ROLE_SUPER_ADMIN` / `ROLE_ADMIN` | Form Studio visual canvas, schema publishing, version rollbacks, database backup/restore |
| `"iqac"` | `ROLE_IQAC` | Full system audit review, user management, audit cycle management |
| `"vice-chancellor"` | `ROLE_VICE-CHANCELLOR` | Executive appraisal reviews, institutional sign-off |
| `"director"` | `ROLE_DIRECTOR` | Academic appraisal draft creation, document uploads, final submission |
| `"administrative"` | `ROLE_ADMINISTRATIVE` | Administrative post section drafting and collaborative submission |
| `"auditor"` | `ROLE_AUDITOR` | Independent evaluation, field-level scoring, and remarks |
