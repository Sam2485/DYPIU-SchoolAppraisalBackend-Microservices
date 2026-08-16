# Database Schema & Partitioning Documentation

This document explains the partitioned database structure, entity models, and Flyway migration scripts across the **School Appraisal Microservices Backend**.

## Database Architecture: Database-Per-Service
To adhere strictly to microservices design patterns while maintaining computational efficiency, the system utilizes **3 Isolated Logical PostgreSQL Databases**:

```text
PostgreSQL 16 Cluster (Port 5432)
├── Database: appraisal_auth_user_db   (Owned by auth-user-service :8081)
├── Database: appraisal_forms_db       (Owned by form-data-service :8082)
└── Database: appraisal_submission_db (Owned by submission-service :8083)
```

---

## 1. Auth & User Database (`appraisal_auth_user_db`)

Owned by `auth-user-service` on Port `8081`. Manages identity, authentication, user roles, MFA sessions, and refresh tokens.

### Tables Catalog:
1. **`users`**:
   - `id` (BIGINT, PRIMARY KEY, SERIAL): Unique identity.
   - `email` (VARCHAR(255), UNIQUE, NOT NULL): User email & login ID.
   - `password` (VARCHAR(255), NOT NULL): BCrypt hashed password.
   - `name`, `designation`, `school`, `role`, `category`, `account_type`, `auditor_type`, `auditor_role`, `post`: Role & post metadata.
   - `schools` (VARCHAR(1000)): Comma-separated assigned school list for academic auditors.
2. **`user_administrative_posts`**: Junction table for administrative user posts.
3. **`refresh_tokens`**: Stores 7-day long-lived session renewal tokens (`token`, `expiry_date`, `revoked`).
4. **`mfa_login_sessions`**: Stores OTP verification sessions for Multi-Factor Authentication.
5. **`password_reset_tokens`**: Stores SHA-256 hashed password reset tokens.

---

## 2. Appraisal Submissions Database (`appraisal_submission_db`)

Owned by `submission-service` on Port `8083`. Manages the master state of appraisal form submissions, snapshots, auditor routing, and academic year cycles.

### Tables Catalog:
1. **`submissions`**: Master table tracking submission status (`DRAFT`, `SUBMITTED`, `UNDER_REVIEW`, `APPROVED`, `SENT_BACK`), version lineage, and audit JSON payloads.
2. **`submission_auditor_assignments`**: Links submissions to assigned internal/external auditors (`submission_id`, `auditor_id`, `status`).
3. **`submission_report_versions`**: Stores version history snapshots for frozen reports.
4. **`snapshots`**: Captured form state snapshots per save/submit action.
5. **`academic_years`**: Active and historical academic year audit cycles (`year_label`, `status`).

---

## 3. Form Section Data Database (`appraisal_forms_db`)

Owned by `form-data-service` on Port `8082`. Contains 64 relational section tables corresponding to Part A, Part B, and Administrative Office appraisal forms.

### Relational Tables (64 Total):
- **39 Academic Audit Tables**: `student_strength`, `faculty_strength`, `board_of_studies`, `syllabus_revision`, `obe_implementation`, `nep_status`, `best_practices`, `student_mentoring`, `graduating_students`, `success_rate`, `qualifying_exams`, `student_awards`, `student_placements`, `higher_studies`, `student_startups`, `student_courses`, `alumni_interactions`, `guest_lectures`, `professional_bodies`, `value_added_courses`, `career_guidance`, `extension_activities`, `faculty_specialization`, `research_publications`, `books_chapters`, `corporate_training`, `consultancy`, `research_funds`, `e_contents`, `teacher_awards`, `patents_copyrights`, `fdp_organized`, `fdp_attended`, `functional_mous`, `swoc_strength`, `swoc_weaknesses`, `swoc_opportunities`, `swoc_challenges`, `swoc_other_information`.
- **25 Administrative Audit Tables**: `courses_offered`, `student_statistics`, `statutory_bodies`, `audit_records`, `scholarship_summary`, `scholarship_students`, `faculty_information`, `faculty_tenure`, `faculty_experience`, `supporting_staff`, `staff_training`, `building_infrastructure`, `library_infrastructure`, `e_resources`, `it_infrastructure`, `sports_facilities`, `divyangajan_facilities`, `research_resources`, `hackathons`, `cultural_activities`, `sports_activities`, `community_activities`, `admin_student_awards`, `training_activities`, `industry_collaborations`.

---

## 4. Flyway Migrations & Performance Indexes

Flyway migration scripts `V1` to `V21` inside `src/main/resources/db/migration/` automatically construct and validate schemas upon microservice startup.

### Key Query Optimization Indexes:
- `idx_submissions_email_audit_type_year`: Composite B-tree index on `submissions(email, audit_type, academic_year)` to optimize user draft/history fetches.
- `idx_submissions_status`: Index on `submissions(status)` for IQAC/VC reviewer dashboards.
- `idx_submissions_root_parent_id`: Lineage index on `submissions(root_submission_id, parent_submission_id)`.
- `idx_users_role` & `idx_users_email`: B-tree indexes on `users(role)` and `users(email)` for fast authority checks.
