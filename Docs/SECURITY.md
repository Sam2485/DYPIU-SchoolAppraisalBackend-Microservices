# Security, Authentication & Multi-Tenancy Architecture

This document describes the authentication, authorization, multi-tenant isolation, and threat protection mechanisms implemented across the **Multi-University Dynamic Faculty & School Appraisal Backend**.

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
│  3. Claim Extraction & Tenant Scoping                  │
└──────────────────────────┬─────────────────────────────┘
                           │ (Inject Verified Context Headers)
                           ▼
┌────────────────────────────────────────────────────────┐
│ Context Headers:                                       │
│   X-User-Email: director@dypiu.ac.in                   │
│   X-User-Role: ROLE_DIRECTOR                           │
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

All client traffic arrives through the **API Gateway** on Port `9000`. The Gateway enforces centralized authentication and defensive filtering:

### A. JWT Bearer Token Validation
- **Token Format**: Standard RFC 7519 JSON Web Token signed with HMAC-SHA256 (`jjwt 0.12.5`).
- **Token Lifespan**: 24 hours (`86400000` ms).
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
- `/api/auth/verify-otp` & `/api/auth/mfa` (MFA challenges)
- `/api/config/active` & `/api/config/branding` (Dynamic public form definitions)
- `/api/universities/**` (`GET` operations)
- `/uploads/**` (Static attachment streaming)

---

## 2. Multi-Factor Authentication & Rate Limiting

### A. Multi-Factor Authentication (MFA)
- Users with MFA enabled receive a 6-digit cryptographic OTP via email upon password verification.
- OTP verification is enforced before the JWT access token is granted.
- Failed attempts exceed limits and invalidate the login session.

### B. Sliding-Window Rate Limiting
- Prevents brute-force credential stuffing and DoS attacks.
- Configured on sensitive routes (e.g. `POST /api/auth/login` capped at **5 requests per minute per IP**).
- Violations return `429 Too Many Requests` with a standard `Retry-After` header.

---

## 3. Multi-Tenant Security & Tenant Isolation

Tenant boundary enforcement operates at 3 levels:

1. **Ingress Extraction**: Gateway parses `universityId` and `universityCode` from JWT claims or request parameters and forwards them downstream.
2. **Service Scoping**: `form-data-service` and `submission-service` queries enforce database-level tenant filters (`WHERE university_id = :uniId`).
3. **Cross-Tenant Guarding**: Prevents user from University A accessing or modifying resources belonging to University B.

---

## 4. Role-Based Access Control (RBAC)

Spring Security authorities are mapped directly from user roles:

| Role String | Granted Authority | Authorized Operations |
| :--- | :--- | :--- |
| `"super_admin"` / `"admin"` | `ROLE_SUPER_ADMIN` / `ROLE_ADMIN` | Form Studio visual canvas, schema publishing, version rollbacks |
| `"iqac"` | `ROLE_IQAC` | Full system audit review, user management, system backups |
| `"vice-chancellor"` | `ROLE_VICE-CHANCELLOR` | Executive appraisal reviews, institutional reporting |
| `"director"` | `ROLE_DIRECTOR` | Academic appraisal draft creation, document uploads, submission |
| `"administrative"` | `ROLE_ADMINISTRATIVE` | Administrative section draft editing and submission |
| `"auditor"` | `ROLE_AUDITOR` | Per-school auditor evaluations, scoring, and feedback |

---

## 5. Defensive Logging & Sanitization

- **Zero Secret Exposure**: Request and response log interceptors in frontends and backend filters redact all passwords, JWT tokens, refresh tokens, and private keys.
- **End-to-End Tracing**: `X-Correlation-Id` is generated at client request initiation, propagated across Gateway and OpenFeign clients, and bound to SLF4J MDC context.
