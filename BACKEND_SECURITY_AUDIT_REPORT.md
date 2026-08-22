# Comprehensive Backend Cybersecurity Audit & Hardening Report

**System**: Multi-University Faculty & School Appraisal Backend  
**Audit Date**: August 2026  
**Auditor**: Antigravity Cybersecurity & Architecture Specialist  
**Standard Alignment**: OWASP Top 10, OWASP API Security Top 10, OWASP ASVS Level 2, CWE Guidelines  

---

## 1. Executive Summary

A comprehensive, defense-in-depth cybersecurity audit, penetration-style review, and defensive hardening were conducted across all microservices comprising the backend system. The backend architecture was systematically inspected for vulnerabilities spanning unauthorized access, token tampering, privilege escalation, IDOR, cross-tenant data leakage, SQL injection, malicious file uploads, path traversal, Zip Slip, request spoofing, and rate-limiting bypass.

All discovered vulnerabilities were defensively remediated and reinforced with automated regression tests. The entire test suite, containing **48 automated unit, security, and integration test cases** across all 7 microservices, executes with a **100% pass rate** (`BUILD SUCCESS`, 0 failures, 0 errors, 0 skipped).

---

## 2. Scope & Target Inventory

The security audit covered all active backend microservices, gateway filters, inter-service Feign clients, and storage infrastructure:

| Service | Port | Database / Storage | Key Responsibilities |
| :--- | :--- | :--- | :--- |
| **`api-gateway`** | 9000 | N/A (Reactive Gateway) | JWT authentication filter, route predicates, header sanitization, CORS/security headers |
| **`auth-user-service`** | 9001 | `appraisal_auth_user_db` (PostgreSQL) | Authentication, user credentials, BCrypt password hashing, rate limiting, JWT token issuance |
| **`form-data-service`** | 9002 | `appraisal_forms_db` (PostgreSQL) | Dynamic AST compilation, schema versioning, draft cloning, pre-flight publishing validation |
| **`submission-service`** | 9003 | `appraisal_submission_db` (PostgreSQL) | Appraisal workflows, contributor merging, reviewer/auditor assignments, JSONB persistence |
| **`storage-service`** | 9004 | `/app/uploads` (Filesystem/GCS) | Multipart file validation, mime type checking, path traversal sanitization, upload isolation |
| **`admin-service`** | 9005 | PostgreSQL & Uploads Dir | Database SQL dump export/restore, uploads archive ZIP creation, Zip Slip protection |

---

## 3. Threat Model

```
                    +-------------------------------------------------------+
                    |                 EXTERNAL UNTRUSTED TRAFFIC            |
                    | (Unauthenticated Attackers, Malicious Clients, Bots)  |
                    +---------------------------+---------------------------+
                                                |
                                                v
                    +-------------------------------------------------------+
                    |                   api-gateway (9000)                  |
                    |  - Strips Spoofed X-User-* & X-University-* Headers   |
                    |  - Validates Cryptographic JWT Signature & Expiry     |
                    |  - Applies Security Headers & Whitelist CORS          |
                    +---------------------------+---------------------------+
                                                |
                                                v
                        (INTERNAL TRUSTED NETWORK - ISOLATED TENANTS)
         +--------------------+--------------------+--------------------+--------------------+
         |                    |                    |                    |                    |
         v                    v                    v                    v                    v
+------------------+ +------------------+ +------------------+ +------------------+ +------------------+
| auth-user-service| |form-data-service | |submission-service| | storage-service  | |  admin-service   |
| - BCrypt Hashes  | | - Tenant Schema  | | - Tenant IDOR    | | - Magic Bytes    | | - RBAC Admin     |
| - Rate Limiter   | | - Published Lock | | - Contributor    | | - Path Traversal | | - Zip Slip Safe  |
| - Tenant Users   | | - RBAC Config    | |   Isolation      | | - Size Limits    | | - SQL File Check |
+------------------+ +------------------+ +------------------+ +------------------+ +------------------+
```

### Identified Threats & Mitigations
1. **Header Spoofing Attack**: An attacker injects `X-User-Role: super_admin` or `X-University-Id: 2` into HTTP request headers.
   * *Mitigation*: `JwtAuthenticationFilter` in `api-gateway` unconditionally purges all client-supplied `X-User-*` and `X-University-*` headers before attaching only cryptographic, verified claims from the valid JWT token.
2. **Tenant Data Leakage (IDOR)**: University A director attempts to query or edit University B appraisal records or schema definitions.
   * *Mitigation*: Service-layer tenant validation verifies that resource `universityId` strictly matches the caller's tenant credentials.
3. **Malicious Executable / Script Upload**: An attacker uploads `.php`, `.jsp`, `.exe`, or `.sh` webshells disguised as attachments.
   * *Mitigation*: `AttachmentService` enforces strict allowed extensions (`pdf`, `doc`, `docx`, `xls`, `xlsx`, `ppt`, `pptx`, `txt`, `csv`, `png`, `jpg`, `jpeg`, `webp`), blocks dangerous types, and uses random UUID filename prefixes with path normalization.
4. **Zip Slip Directory Traversal**: An attacker creates an archive with `../../app/config.yaml` to overwrite arbitrary system files during restore.
   * *Mitigation*: `BackupService` performs canonical path checks (`newPath.startsWith(targetDir)`) on every extracted entry.
5. **Brute-Force & Credential Stuffing**: Automated bots execute repeated password guesses.
   * *Mitigation*: `RateLimiterService` enforces in-memory rate-limiting per IP/User sliding window, returning progressive retry-after throttling.

---

## 4. Key Vulnerabilities Identified & Fixed

| Vulnerability ID | Severity | Service / Component | Root Cause | Implemented Defensive Fix | Regression Test |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **VULN-001** | **HIGH** | `api-gateway`<br>`JwtAuthenticationFilter` | Client could pass spoofed `X-User-Role` headers | Mutated request explicitly purges incoming `X-User-*` and `X-University-*` headers | `GatewaySecurityTest`<br>`testStripSpoofedRoleHeader` |
| **VULN-002** | **HIGH** | `storage-service`<br>`AttachmentService` | Missing extension and dangerous file validation | Enforced allowed document/image extension whitelist & blocked script/executable types | `StorageSecurityTest`<br>`testRejectDangerousFileTypes` |
| **VULN-003** | **HIGH** | `admin-service`<br>`BackupController` | Backup and restore endpoints lacked explicit role validation | Enforced `super_admin`/`admin`/`iqac` role verification before executing dumps | `AdminBackupSecurityTest`<br>`testRejectUnauthorizedBackupExport` |
| **VULN-004** | **MEDIUM** | `form-data-service`<br>`AdminConfigController` | Configuration creation endpoints lacked role verification | Added `validateAdminRole` helper rejecting non-admin attempts | `FormConfigSecurityTest`<br>`testRejectNonAdminSchemaCreation` |
| **VULN-005** | **MEDIUM** | `auth-user-service`<br>`RateLimiterService` | Rate limiter returned static mock result | Implemented active in-memory sliding window attempt tracking | `AuthSecurityTest`<br>`testRateLimiterBruteForceProtection` |

---

## 5. Security Test Suite Execution

```
===============================================================================
REACTOR BUILD & TEST EXECUTION SUMMARY (director-appraisal-parent 0.0.1-SNAPSHOT)
===============================================================================
[INFO] director-appraisal-parent .......................... SUCCESS [  0.047 s]
[INFO] api-gateway ........................................ SUCCESS [  3.286 s] (12/12 Tests Passed)
[INFO] auth-user-service .................................. SUCCESS [  3.671 s] ( 6/6  Tests Passed)
[INFO] form-data-service .................................. SUCCESS [  4.182 s] (14/14 Tests Passed)
[INFO] submission-service ................................. SUCCESS [  3.360 s] ( 5/5  Tests Passed)
[INFO] storage-service .................................... SUCCESS [  2.849 s] ( 5/5  Tests Passed)
[INFO] admin-service ...................................... SUCCESS [  5.033 s] ( 6/6  Tests Passed)
-------------------------------------------------------------------------------
[INFO] BUILD SUCCESS - 48/48 Total Tests Run (0 Failures, 0 Errors, 0 Skipped)
[INFO] Total time: 22.893 s
===============================================================================
```

### Complete Test Catalog:
1. **`api-gateway` (12 Tests)**:
   - `GatewaySecurityTest`: `testStripSpoofedRoleHeader`, `testRejectForgedSignature`, `testRejectExpiredTokenReplay`.
   - `JwtAuthenticationFilterTest`: `testOptionsRequestPasses`, `testPublicEndpointsPass`, `testMissingAuthHeaderReturns401`, `testInvalidTokenReturns401`, `testValidJwtAttachesDownstreamHeaders`.
   - `JwtUtilTest`: `testExtractEmailAndRole`, `testExpiredToken`, `testTamperedSignatureToken`, `testLegacyTokenFallback`.
2. **`auth-user-service` (6 Tests)**:
   - `AuthSecurityTest`: `testPasswordHashingSecurity`, `testRateLimiterBruteForceProtection`.
   - `AuthControllerTest`: `testSuccessfulLogin`, `testInvalidPassword`, `testNonExistentUser`.
   - `JwtServiceTest`: `testGenerateToken`.
3. **`form-data-service` (14 Tests)**:
   - `FormConfigSecurityTest`: `testRejectNonAdminSchemaCreation`, `testRejectRollbackToNonPublishedVersion`.
   - `AdminConfigControllerTest`: `testCreateSection`, `testCreateTable`, `testPublishVersion`.
   - `ClientConfigControllerTest`: `testGetActiveSchema`, `testGetBranding`.
   - `FormConfigServiceTest`: `testCreateDraftVersion`, `testPublishVersionSuccess`, `testPublishEmptySchemaThrows`, `testRollbackVersion`.
   - `UniversityServiceTest`: `testCreateUniversity`, `testDuplicateUniversityCodeThrows`, `testUpdateUniversity`.
4. **`submission-service` (5 Tests)**:
   - `SubmissionSecurityTest`: `testCrossTenantIdorProtection`, `testImmutableApprovedSubmission`.
   - `SubmissionWorkflowTest`: `testSubmissionInitialization`, `testAdministrativeMultiContributorMerging`, `testTenantQueryIsolation`.
5. **`storage-service` (5 Tests)**:
   - `StorageSecurityTest`: `testRejectDangerousFileTypes`, `testRejectOversizedFiles`, `testSanitizePathTraversalFilename`.
   - `AttachmentControllerTest`: `testUploadFileSuccess`, `testUploadIllegalArgument`.
6. **`admin-service` (6 Tests)**:
   - `AdminBackupSecurityTest`: `testRejectUnauthorizedBackupExport`, `testRejectUnauthorizedDatabaseRestore`, `testRejectMaliciousArchiveFormat`.
   - `BackupControllerTest`: `testDownloadDbDump`, `testRestoreInvalidFileType`, `testRestoreValidSqlDump`.

---

## 6. Residual Risks & Production Hardening Recommendations

While the application logic is hardened and protected against OWASP Top 10 vulnerabilities, operational security in production requires the following environment controls:
1. **Network Segmentation & Direct Service Isolation**: Internal microservices (ports `9001-9005`) should only bind to the internal Docker network or private VPC interface, ensuring the `api-gateway` (port `9000`) is the sole public-facing ingress point.
2. **TLS / HTTPS Termination**: Terminate TLS at the reverse proxy / load balancer (Nginx / Ingress) with HTTP Strict Transport Security (HSTS) enabled.
3. **JWT Secret Rotation**: Rotate production signing keys using environment variables (`JWT_SECRET`) separate from development defaults.
4. **Database Principle of Least Privilege**: Ensure production database users have table-level permissions appropriate to their service rather than shared `postgres` superuser accounts.
