# System-Wide Logging, Error Diagnostics & Tracing Guide

**Scope**: Multi-University Appraisal System (Full-Stack Observability)  
**Standard**: Spring Boot SLF4J/MDC + Reactive Gateway + Feign Tracing + React Axios Interceptors  

---

## 1. Overview & Observability Architecture

This application features an end-to-end request tracing and structured diagnostic error system. Every user interaction from the browser travels across the network with a unique **Correlation ID** (`X-Correlation-Id`), linking frontend DevTools, API Gateway ingress, inter-service microservice communications, database operations, and error responses.

```
+-----------------------------------------------------------------------------------+
|                              REACT FRONTEND CLIENTS                               |
|   (Main Frontend: DYPIU-SchoolAppraisal  |  Admin Studio: DYPIU-SchoolAppraisal-admin)  |
|                                                                                   |
|  - Generates UUID v4 X-Correlation-Id for every API call                          |
|  - Measures request duration (durationMs)                                         |
|  - DevTools Collapsed Group: [API REQUEST] & [API RESPONSE] / [API ERROR]         |
|  - Sanitizes sensitive keys (passwords, tokens, secrets)                          |
+------------------------------------------+----------------------------------------+
                                           | HTTP + X-Correlation-Id
                                           v
+-----------------------------------------------------------------------------------+
|                                API GATEWAY (9000)                                 |
|  - JwtAuthenticationFilter: Extracts or generates X-Correlation-Id                |
|  - Purges spoofed client claims; attaches verified JWT tenant/user claims         |
|  - Ingress/Egress Logging: [GATEWAY_REQUEST_START] & [GATEWAY_REQUEST_END]         |
|  - Returns structured ApiErrorResponse on 401/403 with correlationId              |
+------------------------------------------+----------------------------------------+
                                           | Internal HTTP + Forwarded Context
         +---------------------------------+---------------------------------+
         |                                 |                                 |
         v                                 v                                 v
+------------------------+     +------------------------+     +------------------------+
|   auth-user-service    |     |   form-data-service    |     |   submission-service   |
|         (9001)         |     |         (9002)         |     |         (9003)         |
| - MdcLoggingFilter     |     | - MdcLoggingFilter     |     | - MdcLoggingFilter     |
| - GlobalExceptionHandler|    | - GlobalExceptionHandler|    | - FeignCorrelation     |
| - Slf4j MDC Context    |     | - Slf4j MDC Context    |     |   Interceptor          |
+------------------------+     +------------------------+     +-----------+------------+
                                                                          | Downstream Feign
                                                                          v
                                                              +------------------------+
                                                              |    storage-service     |
                                                              |         (9004)         |
                                                              +------------------------+
                                                              |     admin-service      |
                                                              |         (9005)         |
                                                              +------------------------+
```

---

## 2. Correlation ID & Header Propagation

Every request carries the following tracing and context headers:

| Header Name | Purpose | Example Value |
| :--- | :--- | :--- |
| `X-Correlation-Id` | Unique distributed trace ID | `c7f997cb-3734-407e-8ce0-00508c77996e` |
| `X-User-Email` | Authenticated user email | `director@dypiu.ac.in` |
| `X-User-Role` | Authenticated user role | `director` / `super_admin` / `iqac` |
| `X-University-Id` | Tenant university database ID | `1` |
| `X-University-Code` | Tenant university code identifier | `dypiu` |

---

## 3. Standardized Error Response Format

All microservices and the API gateway return a standardized JSON error response structure:

```json
{
  "timestamp": "2026-08-22T18:45:00.123Z",
  "status": 400,
  "error": "Bad Request",
  "code": "VALIDATION_ERROR",
  "message": "Schema name is required.",
  "service": "form-data-service",
  "path": "/api/admin/config/schemas",
  "correlationId": "c7f997cb-3734-407e-8ce0-00508c77996e",
  "details": {
    "name": "must not be blank"
  }
}
```

### Stable Error Codes:
- `AUTH_TOKEN_MISSING` / `AUTH_TOKEN_INVALID` / `AUTH_INVALID_CREDENTIALS`
- `ACCESS_DENIED` / `TENANT_ACCESS_DENIED`
- `INVALID_ARGUMENT` / `VALIDATION_ERROR` / `INVALID_STATE`
- `RESOURCE_NOT_FOUND` / `DUPLICATE_RESOURCE`
- `DATABASE_CONSTRAINT_VIOLATION`
- `ATTACHMENT_TOO_LARGE` / `FILE_NOT_FOUND`
- `DOWNSTREAM_SERVICE_ERROR`
- `INTERNAL_SERVER_ERROR`

---

## 4. Backend Log Format & SLF4J MDC

Logs in terminal and log files use the following format:
```text
%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} [svc=${appName}, corr=%X{correlationId:-NONE}, usr=%X{userEmail:-anon}, uni=%X{universityId:-none}] - %msg%n
```

### Sample Log Output:
```text
2026-08-22 18:49:33.450 [http-nio-9003-exec-2] INFO  c.d.s.config.MdcLoggingFilter [svc=submission-service, corr=a1b2c3d4-e5f6, usr=director@dypiu.ac.in, uni=1] - [REQUEST_START] correlationId=a1b2c3d4-e5f6 service=submission-service method=POST path=/api/submissions/save-draft user=director@dypiu.ac.in role=director uniId=1
2026-08-22 18:49:33.465 [http-nio-9003-exec-2] INFO  c.d.s.c.FeignCorrelationInterceptor [svc=submission-service, corr=a1b2c3d4-e5f6, usr=director@dypiu.ac.in, uni=1] - [DOWNSTREAM_REQUEST] targetService=form-data-service method=GET url=/api/config/active correlationId=a1b2c3d4-e5f6
2026-08-22 18:49:33.510 [http-nio-9003-exec-2] INFO  c.d.s.config.MdcLoggingFilter [svc=submission-service, corr=a1b2c3d4-e5f6, usr=director@dypiu.ac.in, uni=1] - [REQUEST_END] correlationId=a1b2c3d4-e5f6 service=submission-service method=POST path=/api/submissions/save-draft status=200 durationMs=60
```

---

## 5. Frontend Console Diagnostics

In browser developer tools, expand the collapsed diagnostic group:

```
▼ [API ERROR] POST /api/submissions/submit → 500 (142ms) [corr: a1b2c3d4-e5f6]
    ▶ {
        correlationId: "a1b2c3d4-e5f6",
        durationMs: 142,
        errorCode: "DATABASE_CONSTRAINT_VIOLATION",
        errorMessage: "Request failed with status code 500",
        method: "POST",
        params: undefined,
        requestBody: { auditType: "academic", valuesData: { ... } },
        responseBody: {
          code: "DATABASE_CONSTRAINT_VIOLATION",
          correlationId: "a1b2c3d4-e5f6",
          error: "Conflict",
          message: "Database constraint violation.",
          path: "/api/submissions/submit",
          service: "submission-service",
          status: 500,
          timestamp: "2026-08-22T18:49:33.510Z"
        },
        status: 500,
        url: "/api/submissions/submit"
      }
```

---

## 6. How to Debug a Production or Development Failure

When an issue is reported:
1. **Copy the `correlationId`** from the frontend console error, toast, or browser Network response tab (e.g. `a1b2c3d4-e5f6`).
2. **Search server logs**:
   ```bash
   grep "a1b2c3d4-e5f6" logs/*.log
   ```
   Or on Docker:
   ```bash
   docker-compose logs | grep "a1b2c3d4-e5f6"
   ```
3. **Trace the exact execution path**:
   - `api-gateway`: Ingress timestamp, path, method, and client IP.
   - `submission-service`: Incoming parameters, user email, tenant ID.
   - `form-data-service`: Downstream Feign call and schema compiler status.
   - Root cause exception: Exact Java class, line number, SQL constraint name, and complete stack trace.

---

## 7. Sensitive Data Redaction Rules

Automatic redaction is applied across backend logs, frontend console logs, and error responses:
- **Redacted fields**: `password`, `confirmPassword`, `currentPassword`, `newPassword`, `token`, `accessToken`, `refreshToken`, `jwt`, `authorization`, `cookie`, `secret`, `apiKey`, `clientSecret`, `privateKey`.
- **Large payload protection**: Payloads > 50KB are truncated in logs with `[TRUNCATED originalLength=...]` to avoid memory exhaustion and disk exhaustion.
- **Binary data**: Files, Blobs, and multipart binaries are logged with metadata only (`[Blob size=2.4MB type=application/pdf]`).
