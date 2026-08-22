# Database Schema & Partitioning Documentation

This document describes the partitioned database architecture, relational entity models, JSONB dynamic data structures, and Flyway database migration history across the **Multi-University Dynamic Faculty & School Appraisal Backend**.

---

## 🏛️ Database Architecture: Database-Per-Service

To ensure strict domain boundaries, high scalability, and clean multi-tenant isolation, the microservices suite operates across **3 Dedicated Logical PostgreSQL Databases**:

```text
PostgreSQL Cluster (Port 5432)
├── Database: appraisal_auth_user_db   (Owned by auth-user-service  :9001)
├── Database: appraisal_forms_db       (Owned by form-data-service  :9002)
└── Database: appraisal_submission_db (Owned by submission-service :9003)
```

---

## 1. Auth & User Database (`appraisal_auth_user_db`)

Owned by `auth-user-service` on Port `9001`. Manages identity, credentials, tenant scoping, MFA sessions, and refresh tokens.

### Tables Catalog:
1. **`users`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Unique user identifier.
   - `email` (`VARCHAR(255) UNIQUE NOT NULL`): Login email identifier.
   - `password` (`VARCHAR(255) NOT NULL`): BCrypt hashed password string.
   - `name`, `designation`, `school`, `role`, `account_type`, `category`, `auditor_type`, `auditor_role`, `post`: Contributor & reviewer metadata.
   - `schools` (`VARCHAR(500)`): Comma-separated list of assigned schools for academic auditors.
   - `university_id` (`BIGINT DEFAULT 1`): Tenant identifier for multi-university isolation.
   - `university_code` (`VARCHAR(50) DEFAULT 'dypiu'`): Human-readable university slug.
   - `status`, `deleted`, `avatar_url`, `created_at`, `updated_at`.
2. **`user_administrative_posts`**: Junction table mapping administrative contributors to their authorized posts (`user_id`, `post`).
3. **`refresh_tokens`**: Stores 7-day persisted refresh tokens (`token`, `expiry_date`, `revoked`).
4. **`mfa_login_sessions`**: Stores short-lived OTP tokens and verification status for MFA login challenges.
5. **`password_reset_tokens`**: Stores SHA-256 tokens for self-service password recovery.

---

## 2. Dynamic Form Configuration & University DB (`appraisal_forms_db`)

Owned by `form-data-service` on Port `9002`. Implements the **Dynamic Form AST Model** enabling visual Admin Form Studio configuration and runtime schema generation.

### Core Configuration Tables:
1. **`universities`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Unique university ID.
   - `code` (`VARCHAR(50) UNIQUE NOT NULL`): Tenant code (e.g. `'dypiu'`, `'mit_wpu'`).
   - `name` (`VARCHAR(255) NOT NULL`), `domain`, `status`, `establishment_act`, `logo_url`, `iqac_logo_url`, `primary_color`, `theme_branding`.
2. **`form_schemas`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Schema master entity.
   - `university_id` (`BIGINT NOT NULL`): Foreign key to tenant.
   - `audit_type` (`VARCHAR(50) NOT NULL`): `'academic'` or `'administrative'`.
   - `name` (`VARCHAR(255) NOT NULL`), `description`, `active_version_id`, `active_version_number`, `status`.
3. **`schema_versions`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Version record.
   - `schema_id` (`BIGINT NOT NULL`): Parent schema reference.
   - `version_number` (`INTEGER NOT NULL`), `status` (`'DRAFT'`, `'PUBLISHED'`, `'ARCHIVED'`).
   - `compiled_schema` (`TEXT`): Pre-compiled AST JSON snapshot for high-speed client rendering.
   - `published_by`, `published_at`, `created_at`, `updated_at`.
4. **`form_sections`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Section container.
   - `version_id` (`BIGINT NOT NULL`), `section_key`, `title`, `section_number`, `owner_role`, `description`, `display_order`.
5. **`form_tables`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Form table entity.
   - `section_id` (`BIGINT NOT NULL`), `table_key`, `title`, `show_title`, `is_repeatable`, `display_order`.
   - `initial_rows`, `select_options`, `date_columns`, `number_columns`, `textarea_columns`, `textarea_max_lengths` (`TEXT`/JSON).
6. **`form_fields`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Column / Input field entity.
   - `section_id` (`BIGINT NOT NULL`), `table_id` (`BIGINT NULL`), `field_key`, `label`, `field_type` (`'TEXT'`, `'NUMBER'`, `'DATE'`, `'SELECT'`, `'TEXTAREA'`, `'ATTACHMENT'`, `'EMAIL'`, `'URL'`).
   - `kind`, `is_required`, `placeholder`, `default_value`, `validation_rules`, `options`, `attachment_rules`, `display_order`.

---

## 3. Appraisal Submissions Database (`appraisal_submission_db`)

Owned by `submission-service` on Port `9003`. Manages the master state of appraisal submissions, auditor assignments, snapshots, and approval lifecycles.

### Tables Catalog:
1. **`submissions`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Submission master record.
   - `email` (`VARCHAR(255) NOT NULL`), `audit_type` (`VARCHAR(50) NOT NULL`).
   - `university_id` (`BIGINT DEFAULT 1`), `university_code` (`VARCHAR(50) DEFAULT 'dypiu'`), `schema_version_id` (`BIGINT`).
   - `school`, `status` (`'DRAFT'`, `'SUBMITTED'`, `'UNDER_REVIEW'`, `'AUDITOR_COMPLETED'`, `'APPROVED'`).
   - `values_data` (`TEXT`): JSON object containing top-level scalar values.
   - `tables_data` (`TEXT`): JSON object containing dynamic rows for repeatable tables.
   - `attachments` (`TEXT`): JSON array of uploaded document URLs.
   - `remarks`, `reviewed_by`, `reviewed_at`, `academic_year`, `audit_cycle`, `created_at`, `updated_at`.
2. **`auditor_assignments`**: Links submissions to assigned internal/external auditors with per-post review tracking.
3. **`academic_years`**: Active and historical academic year audit cycles (`year_label`, `status`, `is_current`).
4. **`snapshots`**: Historical audit trail capturing immutable state snapshots per save/submit action.

---

## 4. Flyway Migrations & Performance Indexes

Flyway migrations automatically execute on microservice startup to guarantee schema synchronization:

### Migration Versions Summary:
* **`auth-user-service`**: `V1__init_auth_schema.sql` $\rightarrow$ `V5__add_university_tenant_columns.sql`
* **`form-data-service`**: `V1__init_schema.sql` $\rightarrow$ `V22__create_dynamic_config_and_university_tables.sql`
* **`submission-service`**: `V1__init_schema.sql` $\rightarrow$ `V22__add_university_tenant_and_schema_version_to_submissions.sql`

### Key Performance & Isolation Indexes:
* `idx_users_university_id` & `idx_users_university_code`: Optimizes tenant lookup and user queries.
* `idx_form_schemas_uni_id` & `idx_form_schemas_audit_type`: Accelerates dynamic schema AST resolution.
* `idx_submissions_university_id` & `idx_submissions_schema_version_id`: Scopes submission queries by tenant and version.
* `idx_submissions_email_audit_type_year`: Composite B-tree index on `(email, audit_type, academic_year)` for instant draft retrieval.
* `idx_submissions_status`: B-tree index for reviewer dashboard filtering.
