# Database Partitioning & Flyway Memory

## Database Topology
The original 72-table monolithic PostgreSQL schema is partitioned into 3 isolated logical databases:

1. **`appraisal_auth_user_db`**:
   - **Tables**: `users`, `user_administrative_posts`, `mfa_login_sessions`, `refresh_tokens`, `password_reset_tokens`.
   - **Owned By**: `auth-user-service`.
   - **Flyway Migrations**: Core auth & security tables.

2. **`appraisal_forms_db`**:
   - **Tables**: 64 audit section tables (e.g. `nep_status`, `research_publications`, `sponsored_research`, `courses_taught`, `administrative_roles`, etc.).
   - **Owned By**: `form-data-service`.
   - **Flyway Migrations**: Form structures and column schemas.

3. **`appraisal_submission_db`**:
   - **Tables**: `submissions`, `submission_auditor_assignments`, `submission_report_versions`, `snapshots`, `academic_years`.
   - **Owned By**: `submission-service`.
   - **Flyway Migrations**: Migration scripts `V1` to `V21` for submission lifecycle and workflow tracking.

## Initialization & Migrations
- SQL Initialization script: `scripts/init-databases.sql` (Creates `appraisal_auth_user_db`, `appraisal_forms_db`, `appraisal_submission_db` if not existing).
- Flyway automatically runs on service startup.
