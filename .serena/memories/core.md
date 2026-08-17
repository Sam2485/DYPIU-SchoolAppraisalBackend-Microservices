# Core Project Memory: School & Faculty Appraisal System Microservices

## System Overview
- **Project**: DYPIU School / Faculty Appraisal System Backend (Microservices Architecture).
- **Target Repository**: `director-appraisal` (`https://github.com/Sam2485/DYPIU-SchoolAppraisalBackend-Microservices.git`).
- **Baseline Monolith**: `director-appraisal-monolith-backup`.
- **Framework & Runtime**: Java 17, Spring Boot 3.3.4, Spring Cloud 2023.0.3, Maven Multi-Module (`director-appraisal-parent`).
- **Database Engine**: PostgreSQL 16 (partitioned across 3 logical DBs) with 21 Flyway migrations (`V1` to `V21`).

---

## Memory Graph & Topic References
For deeper domain knowledge, read the corresponding memories:
- Architecture & Inter-service Communication: `mem:architecture`
- Microservices Breakdown & Controller Mapping: `mem:services`
- Partitioned Databases & Flyway Migrations: `mem:databases`
- Deployment, Docker Compose & Linux VM Setup: `mem:deployment`
- Security, JWT Gateway Filter & Access Control: `mem:security`

---

## Microservices Topology Quick Reference
| Service | Internal Port | External Route | Database / Storage | Key Role |
| :--- | :--- | :--- | :--- | :--- |
| `api-gateway` | 9000 | `/api/**` | None | Reactive Gateway, JWT Validation, Header Propagation |
| `auth-user-service` | 9001 | `/api/auth/**`, `/api/users/**` | `appraisal_auth_user_db` | Authentication, MFA, Roles, User Profiles |
| `form-data-service` | 9002 | `/api/academic/**`, `/api/administrative/**` | `appraisal_forms_db` | 64 Academic & Administrative Form Section Tables |
| `submission-service` | 9003 | `/api/submissions/**`, `/api/audit-cycles/**` | `appraisal_submission_db` | Submission Lifecycle, Auditor Matching, Snapshots |
| `storage-service` | 9004 | `/api/attachments/**`, `/uploads/**` | Disk (`./uploads`) | Document & Evidence Uploads / Downloads |
| `admin-service` | 9005 | `/api/backup/**` | Disk (`./backups`) | OS Process Database Dump (`pg_dump`) & Restore (`psql`) |


---

## Invariants & Development Rules
- **No Direct Cross-DB Access**: Services must not query another service's database directly. Use OpenFeign REST clients (`AuthUserClient`, `FormDataClient`).
- **Stateless Gateway**: Gateway validates JWT and injects `X-User-Email` header downstream.
- **Frontend Backward Compatibility**: 100% endpoint compatibility with React frontend running on port 5173/3000.
