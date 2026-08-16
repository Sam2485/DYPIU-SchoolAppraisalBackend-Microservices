# Security & Gateway Authentication Architecture

This document describes the centralized authentication, authorization, and security framework implemented across the **School Appraisal Microservices Backend**.

## Core Security Technologies
- **API Gateway Security**: Reactive Spring Cloud Gateway WebFilter (`JwtAuthenticationFilter.java`).
- **Token Mechanism**: Dual-Token Strategy using JSON Web Tokens (JWT) via `io.jsonwebtoken` (jjwt) version 0.12.x:
  - **Access Token**: Short/Medium-lived stateless token (24 hours duration).
  - **Refresh Token**: Long-lived persisted UUID token (7 days duration) stored in PostgreSQL (`refresh_tokens` table in `appraisal_auth_user_db`).
- **Header Propagation**: API Gateway validates JWT tokens and injects trusted context headers (`X-User-Email`, `X-User-Role`) to downstream services.
- **Hashing Algorithm**: BCrypt (strength 10) for user password hashing.
- **Session Policy**: Stateless (`SessionCreationPolicy.STATELESS`).

---

## 1. Centralized Gateway JWT Filter (`api-gateway`)

All external client traffic passes through the **API Gateway** on Port `8080`. The Gateway enforces centralized security before forwarding requests downstream:

```text
HTTP Request (Header: Authorization: Bearer <jwt-token>)
                     │
                     ▼
┌─────────────────────────────────────────┐
│     JwtAuthenticationFilter (Gateway)   │
└────────────────────┬────────────────────┘
                     │ (Validate JWT Signature & Claims)
                     ▼
┌─────────────────────────────────────────┐
│ Inject Headers:                         │
│   X-User-Email: director@dypiu.ac.in    │
│   X-User-Role: ROLE_DIRECTOR            │
└────────────────────┬────────────────────┘
                     │ (Forward to Downstream Microservices)
                     ▼
┌─────────────────────────────────────────┐
│ Downstream Microservice (8081 - 8085)   │
└─────────────────────────────────────────┘
```

### Whitelisted Public Endpoints (No JWT Required):
- `/api/auth/login`
- `/api/auth/register`
- `/api/auth/refresh`
- `/api/auth/forgot-password`
- `/api/auth/reset-password`
- `/api/auth/verify-otp`
- `/api/auth/mfa`
- `/uploads/**` (Static file proxying)

---

## 2. Role-Based Access Control (RBAC)

Roles are mapped dynamically from database user accounts to Spring Security authorities:

### Granted Authorities Mapping:
- `"director"` $\rightarrow$ `ROLE_DIRECTOR`
- `"administrative"` $\rightarrow$ `ROLE_ADMINISTRATIVE`
- `"vice-chancellor"` $\rightarrow$ `ROLE_VICE-CHANCELLOR`
- `"iqac"` $\rightarrow$ `ROLE_IQAC`
- `"academic-internal-auditor"` $\rightarrow$ `ROLE_ACADEMIC-INTERNAL-AUDITOR`
- `"academic-external-auditor"` $\rightarrow$ `ROLE_ACADEMIC-EXTERNAL-AUDITOR`
- `"administrative-internal-auditor"` $\rightarrow$ `ROLE_ADMINISTRATIVE-INTERNAL-AUDITOR`
- `"administrative-external-auditor"` $\rightarrow$ `ROLE_ADMINISTRATIVE-EXTERNAL-AUDITOR`

### Microservice Authorization Rules:
1. **User Management (`auth-user-service`)**: `/api/users/**` endpoints require `ROLE_IQAC`.
2. **Submissions & Workflows (`submission-service`)**: `/api/submissions/all` is scoped based on role (IQAC sees all active forms, VC sees `AUDITOR_COMPLETED` forms, Auditors see assigned/matched forms).
3. **System Backups (`admin-service`)**: `/api/backup/**` endpoints require `ROLE_IQAC`.

---

## 3. JWT & Refresh Token Schema

### Access Token Schema:
- **Lifespan**: 24 hours (`86400000` ms).
- **Subject (`sub`)**: User email address.
- **Claims Payload**: `name`, `designation`, `school`, `role`, `category`, `accountType`.

### Refresh Token Schema:
- **Lifespan**: 7 days (`604800000` ms).
- **Storage**: Persisted in PostgreSQL table `refresh_tokens` inside `appraisal_auth_user_db`.
- **Revocation**: Revoked upon `POST /api/auth/logout`. Re-issuance via `POST /api/auth/refresh` grants a fresh 24-hour Access Token.

---

## 4. CORS Policy

API Gateway configures reactive CORS headers to support frontend clients (e.g. Vite/React on localhost:5173 / 3000):
- **Allowed Origin Patterns**: `*`
- **Allowed HTTP Methods**: `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS`, `PATCH`
- **Allowed Headers**: `*`
- **Exposed Headers**: `Authorization`, `Content-Type`
- **Allow Credentials**: `true`
