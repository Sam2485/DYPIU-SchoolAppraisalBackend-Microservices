# Multi-University Faculty & School Appraisal Microservices Documentation

Welcome to the comprehensive technical documentation for the **Multi-University Dynamic Faculty & School Appraisal System**. This project is an enterprise-grade, Spring Boot 3.3.4 & Spring Cloud 2023.0.3 microservices platform designed to orchestrate the end-to-end appraisal lifecycle for Academic Directors, Administrative Officers (Registrar, HR, DSW, Placement), Vice-Chancellors (VC), Quality Assurance Cells (IQAC), and External/Internal Auditors across multiple university tenants.

---

## 📖 Table of Contents

1. [API Endpoints Catalog](API_ENDPOINTS.md) - Complete catalog of verified REST API endpoints across all microservices and Spring Cloud Gateway routes.
2. [Database Schema & Architecture](DATABASE_SCHEMA.md) - Database-per-service topology, Flyway migrations (`V1` to `V22`), and dynamic AST data models.
3. [Security, Auth & Multi-Tenancy](SECURITY.md) - Centralized reactive JWT verification, sliding-window rate limiting, tenant scoping, and RBAC.
4. [Service Layer & Microservices Topology](SERVICE_LAYER.md) - Business domain breakdown, OpenFeign inter-service clients, and dynamic compiler engine.
5. [Latency & Performance Optimization](LATENCY_OPTIMIZATION.md) - Async WebFlux proxying, pre-compiled AST caching, composite database indexing, and container JVM tuning.
6. [Frontend Architecture & Dynamic Engine](FRONTEND_MAIN.md) - Consolidated React 19.2 SPA, Vite 8 tooling, Dynamic Form AST Renderer, and role dashboards.
7. [Admin Form Studio & Schema Management](FRONTEND_ADMIN.md) - Integrated Form Studio, visual schema builder, Excel bulk schema import, versioning, and publishing.

---

## 🛠️ System Architecture & Tech Stack

```text
                                +-------------------------------------------------------+
                                |                CLIENT WEB APPLICATION                 |
                                |                                                       |
                                |            DYPIU-SchoolAppraisal (React 19.2)         |
                                |       - Unified Contributor & Reviewer Portals        |
                                |       - Integrated Admin Form Studio & Preview        |
                                |       Port: 3003 (Nginx Production) / 5173 (Dev Vite) |
                                +---------------------------+---------------------------+
                                                            |
                                                            v (Reverse Proxy: /api, /uploads)
                                +-------------------------------------------------------+
                                |                   API GATEWAY (9000)                  |
                                |  - Spring Cloud Gateway (Netty Non-Blocking WebFlux)  |
                                |  - JwtAuthenticationFilter (Local HMAC-SHA256 Check)  |
                                |  - Strip Spoofed X-User-* & X-University-* Headers    |
                                |  - Downstream Identity Injection (Email, Role, School)|
                                |  - X-Correlation-Id Trace Header Propagation          |
                                +---------------------------+---------------------------+
                                                            |
                     +--------------------------------------+--------------------------------------+
                     |                      |                       |                      |       |
                     v                      v                       v                      v       v
         +-----------------------+ +------------------+ +-----------------------+ +------------------+ +---------------+
         |   auth-user-service   | |form-data-service | |  submission-service   | | storage-service  | | admin-service |
         |        (9001)         | |      (9002)      | |        (9003)         | |      (9004)      | |    (9005)     |
         | - Auth & MFA          | | - Dynamic Form   | | - JSONB Submissions   | | - File Uploads   | | - SQL Backup  |
         | - User Directory      | |   AST Compiler   | | - Review Workflows    | | - File Streaming | | - DB Restore  |
         | - BCrypt Passwords    | | - Versioning     | | - Auditor Evaluation  | | - Type Whitelist | | - Zip Slip    |
         | - Rate Limiter        | | - Branding & Post| | - Streaming Exports   | | - UUID Isolation | |   Safe Guard  |
         +-----------+-----------+ +--------+---------+ +-----------+-----------+ +------------------+ +---------------+
                     |                      |                       |
                     v                      v                       v
         +-----------------------+ +------------------+ +-----------------------+
         |appraisal_auth_user_db | |appraisal_forms_db| |appraisal_submission_db|
         |   (PostgreSQL 16)     | | (PostgreSQL 16)  | |    (PostgreSQL 16)    |
         +-----------------------+ +------------------+ +-----------------------+
```

### Core Technologies:
- **Runtime & Language**: OpenJDK Java 17 LTS (Container-aware JVM flags)
- **Backend Framework**: Spring Boot 3.3.4 & Spring Cloud 2023.0.3 (Maven Multi-Module `director-appraisal-parent`)
- **Frontend Application**: React 19.2.6, Vite 8.0.12, React Router DOM 7.18.0, Axios 1.18.0, Lucide-React 1.47.0, React Hook Form 7.79.0, SheetJS (XLSX) 0.18.5
- **API Gateway**: Spring Cloud Gateway running on Netty with reactive, non-blocking I/O and sub-millisecond JWT verification
- **Inter-Service Communication**: Spring Cloud OpenFeign REST clients (`AuthUserClient`, `FormDataClient`) with correlation interceptors
- **Databases**: PostgreSQL 16 (Three partitioned databases: `appraisal_auth_user_db`, `appraisal_forms_db`, `appraisal_submission_db`)
- **Database Migrations**: Flyway Core (`V1` to `V22`) executed automatically on microservice startup
- **Observability**: SLF4J + Logback MDC correlation tracing (`X-Correlation-Id`) propagated end-to-end

---

## ⚙️ Microservices Port Allocation & Environment Configuration

| Service Module | Internal Port | External Route | Database / Storage Target | Primary Responsibilities |
| :--- | :---: | :--- | :--- | :--- |
| **`api-gateway`** | `9000` | `/api/**`, `/uploads/**` | None (Stateless Netty WebFlux) | Ingress routing, CORS, JWT authentication, header sanitization, correlation ID injection |
| **`auth-user-service`** | `9001` | `/api/auth/**`, `/api/users/**` | PostgreSQL `appraisal_auth_user_db` | Authentication, password reset, MFA login, user directory, tenant scoping |
| **`form-data-service`** | `9002` | `/api/config/**`, `/api/admin/config/**` | PostgreSQL `appraisal_forms_db` | Dynamic AST compiler, Form Studio CRUD, schema versioning, university schools & posts |
| **`submission-service`** | `9003` | `/api/submissions/**`, `/api/audit-cycles/**` | PostgreSQL `appraisal_submission_db` | JSONB draft persistence, workflow state machine, auditor evaluation, streaming Excel/PDF exports |
| **`storage-service`** | `9004` | `/api/attachments/**`, `/uploads/**` | Mounted Disk (`/app/uploads`) | Multipart file upload, MIME & extension whitelisting, static file streaming |
| **`admin-service`** | `9005` | `/api/backup/**` | Mounted Disk (`/app/backups`) | Native `pg_dump`/`psql` database backup/restore, Zip-Slip safe media archive extraction |
| **Frontend Container** | `8080` (mapped to `3003`) | Web UI `/` | Nginx Static Host | Unified React 19 SPA for all roles and Form Studio |

---

## 🚀 Quickstart & Production Operations

### 1. Database Initialization
Ensure PostgreSQL 16 is running on port `5432`. Create the isolated microservice databases:
```sql
CREATE DATABASE appraisal_auth_user_db;
CREATE DATABASE appraisal_forms_db;
CREATE DATABASE appraisal_submission_db;
```

### 2. Build Backend Microservices
From the backend repository root (`director-appraisal`), compile and execute the test suite:
```bash
mvn clean test
```
All 56 automated unit, security, and integration tests execute with a 100% pass rate.

### 3. Docker Compose Orchestration
```bash
# Start all 6 microservices and PostgreSQL in background
docker compose up -d --build

# Verify health status across all ports
./scripts/health-check.sh
```

### 4. Dual-Network Production Deployment
The production deployment on the Linux VM operates across:
- **Campus LAN**: `http://10.100.0.23:3003`
- **Public WAN**: `http://150.129.156.37:3003`
All frontend API calls use same-origin relative URLs (`/api/...`) reverse-proxied by Nginx directly to `api-gateway` on port `9000`.
