# Multi-University Faculty & School Appraisal Microservices Documentation

Welcome to the comprehensive technical documentation for the **Multi-University Dynamic Faculty & School Appraisal System**. This project is an enterprise-grade, Spring Boot 3 & Spring Cloud microservices platform designed to orchestrate the end-to-end appraisal lifecycle for Academic Directors, Administrative Officers (Registrar, HR, DSW, Placement), Vice-Chancellors (VC), Quality Assurance Cells (IQAC), and External/Internal Auditors across multiple university tenants.

---

## 📖 Table of Contents

1. [API Endpoints Catalog](API_ENDPOINTS.md) - Catalog of all 82 REST API endpoints across microservices and API Gateway routing rules.
2. [Database Schema & Architecture](DATABASE_SCHEMA.md) - Database-per-service isolation, Flyway migrations (`V1` to `V22`), and dynamic AST data models.
3. [Security, Auth & Multi-Tenancy](SECURITY.md) - Centralized reactive JWT verification, sliding-window rate limiting, tenant scoping, and RBAC.
4. [Service Layer & Microservices Topology](SERVICE_LAYER.md) - Business domain breakdown, OpenFeign inter-service clients, and dynamic compiler engine.
5. [Latency & Performance Optimization](LATENCY_OPTIMIZATION.md) - Async WebFlux proxying, AST caching, composite database indexing, and container JVM tuning.
6. [Main Frontend Application](FRONTEND_MAIN.md) - React 18 contributor application, Dynamic Form AST Renderer, and role dashboards.
7. [Admin Form Studio Frontend](FRONTEND_ADMIN.md) - React 18 Visual Schema Builder, multi-university tenant management, versioning, and publishing.

---


## 🛠️ System Architecture & Tech Stack

```text
                                +-------------------------------------------------------+
                                |                CLIENT WEB APPLICATIONS                |
                                |                                                       |
                                |  [Main Frontend]                [Admin Form Studio]   |
                                |  DYPIU-SchoolAppraisal          DYPIU-SchoolAppraisal-admin
                                |  Port: 5173 (Dev Proxy)         Port: 3005 (Dev Proxy)|
                                +---------------------------+---------------------------+
                                                            |
                                                            v
                                +-------------------------------------------------------+
                                |                   API GATEWAY (9000)                  |
                                |  - CORS & Path Routing (13 route patterns)            |
                                |  - Ingress JWT Claim Extraction & Header Forwarding   |
                                |  - X-Correlation-Id Trace Propagation                 |
                                +---------------------------+---------------------------+
                                                            |
                     +--------------------------------------+--------------------------------------+
                     |                      |                       |                      |       |
                     v                      v                       v                      v       v
         +-----------------------+ +------------------+ +-----------------------+ +------------------+ +---------------+
         |   auth-user-service   | |form-data-service | |  submission-service   | | storage-service  | | admin-service |
         |        (9001)         | |      (9002)      | |        (9003)         | |      (9004)      | |    (9005)     |
         | - Auth & MFA          | | - University DB  | | - JSONB Submissions   | | - File Uploads   | | - SQL Backup  |
         | - User Profiles       | | - Schema AST     | | - Reviews & Approvals | | - File Streaming | | - DB Restore  |
         | - Password Hash       | | - Dynamic Config | | - Excel/PDF Exports   | | - Type Filter    | | - Zip Storage |
         +-----------------------+ +------------------+ +-----------+-----------+ +------------------+ +---------------+
```

- **Java Development Kit (JDK)**: OpenJDK / Java 17 & 21 compatible
- **Build Tool**: Apache Maven 3.9+ (7-Module Multi-Module Reactor Project)
- **Framework**: Spring Boot 3.3.4 & Spring Cloud 2023.0.3
- **Frontend Applications**:
  - **Main Appraisal Frontend (`DYPIU-SchoolAppraisal`)**: React 18, Vite, Dynamic Form Renderer Engine.
  - **Admin Form Studio (`DYPIU-SchoolAppraisal-admin`)**: React 18, Vite, Visual Schema & Version Builder Canvas.
- **API Gateway**: Spring Cloud Gateway (Reactive WebFlux with JJWT 0.12.x validation & sliding window rate limiter)
- **Inter-Service Communication**: Spring Cloud OpenFeign HTTP REST clients (`AuthUserClient`, `FormDataClient`)
- **Database**: PostgreSQL 16/18 (Isolated logical databases: `appraisal_auth_user_db`, `appraisal_forms_db`, `appraisal_submission_db`)
- **Database Migrations**: Flyway Core (`V1` to `V22`) with backward compatibility preservation
- **Observability**: SLF4J + Logback MDC correlation tracing (`X-Correlation-Id`) across Gateway, Microservices, and Frontends

---

## ⚙️ Microservices Port Allocation & Environment Configuration

| Service Module | Default Port | Primary Function | Database / Storage Target |
| :--- | :---: | :--- | :--- |
| **`api-gateway`** | `9000` | Ingress Reverse Proxy, CORS, JWT Filter, Rate Limiting | N/A (Stateless Netty WebFlux) |
| **`auth-user-service`** | `9001` | Authentication, MFA, User Management, Tenant Context | PostgreSQL `appraisal_auth_user_db` |
| **`form-data-service`** | `9002` | University Directory, Dynamic Form AST, Schema Versioning | PostgreSQL `appraisal_forms_db` |
| **`submission-service`** | `9003` | Drafts, Submissions, Auditor Reviews, Binary Exports | PostgreSQL `appraisal_submission_db` |
| **`storage-service`** | `9004` | Multipart Attachment Upload, Validation, File Streaming | Local File Storage / Cloud Bucket |
| **`admin-service`** | `9005` | Database SQL Dumps & Upload Archive Backup/Restore | Local Storage (`./backups`) |
| **`DYPIU-SchoolAppraisal`** | `5173` | Main Contributor & Reviewer Web Application | Connected via Gateway (`http://localhost:9000`) |
| **`DYPIU-SchoolAppraisal-admin`**| `3005` | Admin Form Studio & University Management Application | Connected via Gateway (`http://localhost:9000`) |

---

## 🚀 Quickstart & Local Setup

### 1. Database Initialization
Ensure PostgreSQL is running locally on port `5432`. Create the isolated microservice databases:
```sql
CREATE DATABASE appraisal_auth_user_db;
CREATE DATABASE appraisal_forms_db;
CREATE DATABASE appraisal_submission_db;
```

### 2. Build the Backend Microservices
From the backend repository root (`director-appraisal`), compile and execute the test suite:
```bash
mvn clean test
```

### 3. Start Backend Services
Launch the microservices either via Docker Compose or individually in their respective directories:
```bash
# Using Docker Compose
docker compose up -d --build

# Or running services individually
mvn --projects api-gateway spring-boot:run
mvn --projects auth-user-service spring-boot:run
mvn --projects form-data-service spring-boot:run
mvn --projects submission-service spring-boot:run
mvn --projects storage-service spring-boot:run
mvn --projects admin-service spring-boot:run
```

### 4. Start Frontend Applications
```bash
# Main Frontend
cd ../DYPIU-SchoolAppraisal-frontend/DYPIU-SchoolAppraisal
npm install
npm run dev

# Admin Form Studio
cd ../DYPIU-SchoolAppraisal-admin
npm install
npm run dev
```

---

## 📂 Repository Directory Structure

```text
director-appraisal/
├── pom.xml                                   # Master 7-Module Parent POM
├── docker-compose.yml                        # Docker Microservices Orchestrator
├── BACKEND_API_REFERENCE.md                  # Complete 82-Endpoint Reference Contract
├── BACKEND_API_REFERENCE.json                # Machine-Readable Route Inventory
├── DATABASE_SCHEMA_AUDIT_REPORT.md           # Database & Flyway Audit Report
├── INTEGRATION_PROOF_REPORT.md               # End-to-End Proof & Evidence Report
├── Docs/                                     # Comprehensive Technical Documentation
│   ├── README.md                             # Master System Documentation Index
│   ├── API_ENDPOINTS.md                      # Detailed API Catalog & Gateway Routing
│   ├── DATABASE_SCHEMA.md                    # DB Design, Entities & Flyway Migrations
│   ├── SECURITY.md                           # JWT, MFA, RBAC & Tenant Security
│   ├── SERVICE_LAYER.md                      # Business Domains & OpenFeign Clients
│   └── LATENCY_OPTIMIZATION.md               # Performance Optimization & Benchmarks
├── api-gateway/                              # Service 1: Ingress Gateway (Port 9000)
├── auth-user-service/                        # Service 2: Auth & Users (Port 9001)
├── form-data-service/                        # Service 3: Dynamic Schema & Universities (Port 9002)
├── submission-service/                       # Service 4: Submissions & Reviews (Port 9003)
├── storage-service/                          # Service 5: File Storage & Attachments (Port 9004)
├── admin-service/                            # Service 6: System Backup & Restore (Port 9005)
└── scripts/                                  # Deployment & Health Check Scripts
```
