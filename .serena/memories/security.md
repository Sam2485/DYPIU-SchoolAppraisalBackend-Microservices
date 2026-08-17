# Security & JWT Memory

## Security Invariants

### 1. Centralized Gateway Authentication
- `api-gateway` implements `JwtAuthenticationFilter`.
- JWT secret is shared across gateway and `auth-user-service` via environment variable `JWT_SECRET`.
- Public Whitelist Routes:
  - `/api/auth/login`
  - `/api/auth/register`
  - `/api/auth/refresh`
  - `/api/auth/forgot-password`
  - `/api/auth/reset-password`
  - `/api/auth/verify-otp`
  - `/api/auth/mfa`
  - `/api/attachments/**` (public view/download)

### 2. Downstream Identity Propagation
- Gateway extracts authenticated user email from JWT claims.
- Request header mutated with `X-User-Email: <user_email>`.
- Internal services read `X-User-Email` directly without needing to re-parse or verify JWT cryptographic signatures.

### 3. File Security
- Path traversal mitigation implemented in `BackupService` (`Zip-Slip` guard).
- Upload limits configured at Nginx (`client_max_body_size 500M`) and Spring Boot Multipart settings.
