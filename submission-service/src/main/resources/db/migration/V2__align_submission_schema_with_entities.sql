-- V2: Align snapshots, academic_years, submissions, and submission_auditor_assignments with JPA Entities

-- 1. Fix snapshots table: drop non-existent columns with not-null constraints
ALTER TABLE snapshots DROP COLUMN IF EXISTS snapshot_type;
ALTER TABLE snapshots DROP COLUMN IF EXISTS snapshot_data;
ALTER TABLE snapshots DROP COLUMN IF EXISTS created_by;
ALTER TABLE snapshots DROP COLUMN IF EXISTS created_at;

-- Ensure all Snapshot entity columns exist
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS saved_at TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS status VARCHAR(100);
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS values_data TEXT;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS tables_data TEXT;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS attachments TEXT;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS version INTEGER;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS academic_year VARCHAR(50);
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS audit_cycle VARCHAR(50);
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS school_group VARCHAR(50);
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS forwarded_administrative_posts TEXT;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS forwarded_to_auditor_posts TEXT;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_correction_requested BOOLEAN DEFAULT FALSE;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS correction_requested_for_auditor BOOLEAN DEFAULT FALSE;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS requires_auditor_resubmission BOOLEAN DEFAULT FALSE;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_correction_message TEXT;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_correction_requested_by VARCHAR(255);
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_correction_requested_by_role VARCHAR(100);
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_correction_requested_on TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_resubmitted_at TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE snapshots ADD COLUMN IF NOT EXISTS auditor_reviewed_by_email VARCHAR(255);

-- 2. Fix academic_years table: drop non-existent columns and unique constraint
ALTER TABLE academic_years DROP CONSTRAINT IF EXISTS academic_years_academic_year_key;
ALTER TABLE academic_years DROP COLUMN IF EXISTS academic_year;
ALTER TABLE academic_years DROP COLUMN IF EXISTS is_current;
ALTER TABLE academic_years DROP COLUMN IF EXISTS status;
ALTER TABLE academic_years DROP COLUMN IF EXISTS created_at;
ALTER TABLE academic_years DROP COLUMN IF EXISTS updated_at;

-- Ensure AcademicYear entity columns exist
ALTER TABLE academic_years ADD COLUMN IF NOT EXISTS year_label VARCHAR(50);
ALTER TABLE academic_years ADD COLUMN IF NOT EXISTS active BOOLEAN DEFAULT FALSE;
ALTER TABLE academic_years ADD COLUMN IF NOT EXISTS started_at TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE academic_years ADD COLUMN IF NOT EXISTS closed_at TIMESTAMP WITHOUT TIME ZONE;

-- 3. Fix submission_auditor_assignments table
ALTER TABLE submission_auditor_assignments DROP COLUMN IF EXISTS school_id;
ALTER TABLE submission_auditor_assignments DROP COLUMN IF EXISTS post_id;
ALTER TABLE submission_auditor_assignments DROP COLUMN IF EXISTS completed_at;
ALTER TABLE submission_auditor_assignments DROP COLUMN IF EXISTS created_at;
ALTER TABLE submission_auditor_assignments DROP COLUMN IF EXISTS updated_at;
ALTER TABLE submission_auditor_assignments DROP COLUMN IF EXISTS remarks;

-- 4. Fix submissions table: drop obsolete columns and index
DROP INDEX IF EXISTS idx_submissions_lookup;
ALTER TABLE submissions DROP COLUMN IF EXISTS school_id;
ALTER TABLE submissions DROP COLUMN IF EXISTS post_id;
ALTER TABLE submissions DROP COLUMN IF EXISTS user_id;
ALTER TABLE submissions DROP COLUMN IF EXISTS auditor_remarks;
ALTER TABLE submissions DROP COLUMN IF EXISTS auditor_status;
ALTER TABLE submissions DROP COLUMN IF EXISTS auditor_completed_at;
ALTER TABLE submissions DROP COLUMN IF EXISTS auditor_id;
ALTER TABLE submissions DROP COLUMN IF EXISTS auditor_name;
ALTER TABLE submissions DROP COLUMN IF EXISTS director_sign_off;
ALTER TABLE submissions DROP COLUMN IF EXISTS auditor_sign_off;
ALTER TABLE submissions DROP COLUMN IF EXISTS iqac_sign_off;
ALTER TABLE submissions DROP COLUMN IF EXISTS vc_sign_off;

CREATE INDEX IF NOT EXISTS idx_submissions_lookup ON submissions(email, audit_type, academic_year);
