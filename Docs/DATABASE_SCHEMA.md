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
   - `password` (`VARCHAR(255) NOT NULL`): BCrypt hashed password string (cost factor 12).
   - `name`, `designation`, `school`, `role`, `account_type`, `category`, `auditor_type`, `auditor_role`, `post`: Contributor & reviewer profile fields.
   - `schools` (`VARCHAR(500)`): Comma-separated list of assigned schools for academic auditors.
   - `university_id` (`BIGINT DEFAULT 1`): Tenant identifier for multi-university isolation.
   - `university_code` (`VARCHAR(50) DEFAULT 'dypiu'`): Human-readable university slug.
   - `status`, `deleted`, `avatar_url`, `created_at`, `updated_at`.
2. **`user_administrative_posts`**: Junction table mapping administrative contributors to their authorized posts (`id`, `user_id`, `post`).
3. **`refresh_tokens`**: Stores 7-day persisted refresh tokens (`id`, `user_id`, `token`, `expiry_date`, `revoked`).
4. **`mfa_login_sessions`**: Stores short-lived OTP tokens and verification status for MFA login challenges (`id`, `email`, `otp_hash`, `expiry_time`, `verified`).
5. **`password_reset_tokens`**: Stores SHA-256 tokens for self-service password recovery (`id`, `email`, `token`, `expiry_time`, `used`).

### Flyway Migrations (`auth-user-service`):
* `V1__init_auth_schema.sql`: Initial `users` and `user_administrative_posts` tables.
* `V2__create_mfa_sessions.sql`: MFA session storage with hash and expiration.
* `V3__add_avatar_url.sql`: Avatar storage column.
* `V4__create_refresh_tokens_table.sql`: Refresh token rotation table.
* `V5__add_university_tenant_columns.sql`: Adds `university_id`, `university_code`, and composite B-tree indexes.

---

## 2. Dynamic Form Configuration & University DB (`appraisal_forms_db`)

Owned by `form-data-service` on Port `9002`. Implements the **Dynamic Form AST Model** enabling visual Admin Form Studio configuration and runtime schema generation.

### Core Configuration Tables:
1. **`universities`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Unique university ID.
   - `code` (`VARCHAR(50) UNIQUE NOT NULL`): Tenant code (e.g. `'dypiu'`).
   - `name` (`VARCHAR(255) NOT NULL`), `domain`, `status`, `establishment_act`, `logo_url`, `iqac_logo_url`, `primary_color`, `theme_branding`.
2. **`university_schools`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Unique school identifier.
   - `university_id` (`BIGINT NOT NULL`), `code` (`VARCHAR(100)`), `name` (`VARCHAR(255)`), `display_order`, `status`.
3. **`university_posts`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Unique administrative post identifier.
   - `university_id` (`BIGINT NOT NULL`), `code` (`VARCHAR(100)`), `title` (`VARCHAR(255)`), `display_order`, `status`.
4. **`form_schemas`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Schema master entity.
   - `university_id` (`BIGINT NOT NULL`): Foreign key to tenant.
   - `audit_type` (`VARCHAR(50) NOT NULL`): `'academic'` or `'administrative'`.
   - `name` (`VARCHAR(255) NOT NULL`), `description`, `active_version_id`, `active_version_number`, `status`.
5. **`schema_versions`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Version record.
   - `schema_id` (`BIGINT NOT NULL`): Parent schema reference.
   - `version_number` (`INTEGER NOT NULL`), `status` (`'DRAFT'`, `'PUBLISHED'`, `'ARCHIVED'`).
   - `compiled_schema` (`TEXT`): Pre-compiled AST JSON snapshot for high-speed client rendering ($O(1)$ lookup).
   - `published_by`, `published_at`, `created_at`, `updated_at`.
6. **`form_sections`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Section container.
   - `version_id` (`BIGINT NOT NULL`), `section_key`, `title`, `section_number`, `owner_role`, `description`, `display_order`.
7. **`form_tables`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Form table entity.
   - `section_id` (`BIGINT NOT NULL`), `table_key`, `title`, `show_title`, `is_repeatable`, `display_order`.
   - `initial_rows`, `select_options`, `date_columns`, `number_columns`, `textarea_columns`, `textarea_max_lengths` (`TEXT`/JSON).
8. **`form_fields`**:
   - `id` (`BIGSERIAL PRIMARY KEY`): Column / Input field entity.
   - `section_id` (`BIGINT NOT NULL`), `table_id` (`BIGINT NULL`), `field_key`, `label`, `field_type` (`'TEXT'`, `'NUMBER'`, `'DATE'`, `'SELECT'`, `'TEXTAREA'`, `'ATTACHMENT'`, `'EMAIL'`, `'URL'`).
   - `kind`, `is_required`, `placeholder`, `default_value`, `validation_rules`, `options`, `attachment_rules`, `display_order`.

### Flyway Migrations (`form-data-service`):
* `V1__init_dynamic_form_schema.sql`: Core relational metadata schema (`universities`, `form_schemas`, `schema_versions`, `form_sections`, `form_tables`, `form_fields`).
* `V2__add_table_buttons_to_form_sections.sql`: Extended table layout capabilities.
* `V3__alter_university_logo_urls_to_text.sql`: Expanded branding logo URL storage.
* `V22__create_dynamic_config_and_university_tables.sql`: Tenant index synchronization.

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
2. **`submission_auditor_assignments`**: Links submissions to assigned internal/external auditors with per-post review tracking (`id`, `submission_id`, `auditor_id`, `auditor_email`, `post_key`, `status`).
3. **`academic_years`**: Active and historical academic year audit cycles (`id`, `year_code`, `year_label`, `status`, `is_current`).
4. **`snapshots`**: Historical audit trail capturing immutable state snapshots per save/submit action (`id`, `submission_id`, `status`, `snapshot_data`, `created_at`).

### Flyway Migrations (`submission-service`):
* `V1__init_submission_schema.sql`: Initial submissions, snapshots, and academic years tables.
* `V2__align_submission_schema_with_entities.sql`: Schema alignment for hybrid JSONB and auditor assignments.
* `V22__add_university_tenant_and_schema_version_to_submissions.sql`: Multi-tenant and schema version indexes.

---

## 4. Performance Indexes

Selective B-Tree composite indexes target high-traffic production query patterns:
1. **`idx_submissions_email_audit_type_year`**: On `submissions(email, audit_type, academic_year)` for sub-10ms draft retrieval.
2. **`idx_submissions_university_id`**: On `submissions(university_id)` for tenant isolation.
3. **`idx_schema_versions_schema_id`**: On `schema_versions(schema_id)` for version tree retrieval.
4. **`idx_users_email` & `idx_users_university_id`**: On `users(email, university_id)` for rapid login authentication.
