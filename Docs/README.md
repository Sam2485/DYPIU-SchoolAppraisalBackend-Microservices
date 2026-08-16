# School Appraisal Microservices Backend Documentation

Welcome to the documentation for the **School Appraisal Microservices Backend**. This project is a production-grade, Spring Boot 3 & Spring Cloud microservices system designed to manage the appraisal lifecycle for Directors (Academic branch) and Administrative Users (Registrar, HR, DSW, Placement), with review capabilities for the Vice-Chancellor (VC) and the Internal Quality Assurance Cell (IQAC).

---

## 📖 Table of Contents

1. [API Endpoints](API_ENDPOINTS.md) - Catalog of REST API routes across all microservice modules and Gateway routing rules.
2. [Database Schema & Partitioning](DATABASE_SCHEMA.md) - Database per service isolation, Flyway migrations, and table ownership.
3. [Security & Gateway Authentication](SECURITY.md) - Centralized reactive JWT verification in API Gateway and security context propagation.
4. [Service Layer & Microservice Topology](SERVICE_LAYER.md) - Business domain breakdown, OpenFeign inter-service communication, and storage architecture.
5. [Latency & Performance Optimization](LATENCY_OPTIMIZATION.md) - Async execution, non-blocking I/O, database indexing, and network optimization.

---

## 🛠️ Tech Stack & Requirements

- **Java Development Kit (JDK)**: OpenJDK / Java 21
- **Build Tool**: Apache Maven 3.x (Multi-Module Parent Project)
- **Framework**: Spring Boot 3.3.4 & Spring Cloud 2023.0.3
- **API Gateway**: Spring Cloud Gateway (Reactive WebFlux with JJWT 0.12.5 validation)
- **Inter-Service Communication**: OpenFeign REST Clients (`AuthUserClient`, `FormDataClient`)
- **Database**: PostgreSQL 16 (Logical DB separation: `appraisal_auth_user_db`, `appraisal_forms_db`, `appraisal_submission_db`)
- **Database Migrations**: Flyway Core & Flyway Database PostgreSQL (`V1` to `V21`)
- **Containerization & Deployment**: Docker, Multi-Stage Dockerfiles, Docker Compose, Nginx, Linux VM Systemd Automation

---

## ⚙️ Microservice Port Allocation & Environment Variables

The microservices application suite consists of 6 dedicated modules:

| Microservice Module | Default Port | Environment Variable Config | Database / Storage |
| :--- | :---: | :--- | :--- |
| **`api-gateway`** | `8080` | `GATEWAY_PORT` | N/A (Reactive Gateway Proxy) |
| **`auth-user-service`** | `8081` | `AUTH_SERVICE_PORT` | PostgreSQL `appraisal_auth_user_db` |
| **`form-data-service`** | `8082` | `FORMS_SERVICE_PORT` | PostgreSQL `appraisal_forms_db` |
| **`submission-service`** | `8083` | `SUBMISSION_SERVICE_PORT` | PostgreSQL `appraisal_submission_db` |
| **`storage-service`** | `8084` | `STORAGE_SERVICE_PORT` | File System Storage (`./uploads`) |
| **`admin-service`** | `8085` | `ADMIN_SERVICE_PORT` | File System Storage (`./backups`) |

---

## 🚀 Local Development Setup

### 1. Database Setup
Ensure **PostgreSQL 16** is running locally on port 5432. Execute the initialization script or SQL commands to create the 3 isolated databases:
```sql
CREATE DATABASE appraisal_auth_user_db;
CREATE DATABASE appraisal_forms_db;
CREATE DATABASE appraisal_submission_db;
```

### 2. Build the Multi-Module Project
From the project root directory, build all microservices using Maven:
```bash
mvn clean package -DskipTests
```

### 3. Run Microservices
Run the microservices in order or use the provided Docker Compose file:
```bash
docker compose up -d --build
```

---

## 📂 Project Structure

```text
director-appraisal/
├── pom.xml                         # Master Parent POM
├── docker-compose.yml              # Container Orchestrator
├── .env.example                    # Parameterized Environment Template
├── MICROSERVICES_VERIFICATION_REPORT.md # Migration Audit Report
├── Docs/                           # Documentation Directory
│   ├── README.md                   # Master Documentation Index
│   ├── API_ENDPOINTS.md            # API Catalog & Routing Rules
│   ├── DATABASE_SCHEMA.md          # Database Design & Partitioning
│   ├── SECURITY.md                 # Security & JWT Architecture
│   ├── SERVICE_LAYER.md            # Business Domain & OpenFeign Architecture
│   └── LATENCY_OPTIMIZATION.md     # Performance Optimization Guide
├── api-gateway/                    # Service 1 (Port 8080)
├── auth-user-service/              # Service 2 (Port 8081)
├── form-data-service/              # Service 3 (Port 8082)
├── submission-service/             # Service 4 (Port 8083)
├── storage-service/                # Service 5 (Port 8084)
├── admin-service/                  # Service 6 (Port 8085)
├── nginx/                          # Production Nginx Reverse Proxy Config
└── scripts/                        # Deployment Automation Scripts
    ├── init-databases.sql
    ├── deploy.sh
    ├── health-check.sh
    ├── start-all.sh
    └── stop-all.sh
```
