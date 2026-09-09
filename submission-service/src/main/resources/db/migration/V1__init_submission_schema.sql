-- V1: Initialize Clean Multi-Tenant Submissions Schema

CREATE TABLE IF NOT EXISTS submissions (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    audit_type VARCHAR(50) NOT NULL,
    schema_version_id BIGINT,
    university_id BIGINT DEFAULT 1,
    university_code VARCHAR(50) DEFAULT 'dypiu',
    school VARCHAR(255),
    submitted_by VARCHAR(255),
    submitted_by_details TEXT,
    submitted_at TIMESTAMP WITHOUT TIME ZONE,
    status VARCHAR(50) NOT NULL DEFAULT 'DRAFT',
    remarks TEXT,
    reviewed_by VARCHAR(255),
    reviewed_at TIMESTAMP WITHOUT TIME ZONE,
    forwarded_to_auditor_id BIGINT,
    forwarded_to_auditor_name VARCHAR(255),
    forwarded_to_auditor_email VARCHAR(255),
    forwarded_to_auditor_ids TEXT,
    forwarded_to_auditor_names TEXT,
    forwarded_to_auditor_emails TEXT,
    forwarded_auditor_type VARCHAR(50),
    forwarded_audit_category VARCHAR(50),
    forwarded_at TIMESTAMP WITHOUT TIME ZONE,
    auditor_reviewed_by VARCHAR(255),
    auditor_reviewed_by_designation VARCHAR(255),
    auditor_reviewed_by_role VARCHAR(255),
    auditor_reviewed_by_email VARCHAR(255),
    auditor_reviewed_on TIMESTAMP WITHOUT TIME ZONE,
    root_submission_id BIGINT,
    parent_submission_id BIGINT,
    previous_approved_submission_id BIGINT,
    academic_year VARCHAR(50),
    audit_cycle VARCHAR(50),
    report_category VARCHAR(50),
    school_group VARCHAR(50),
    administrative_post VARCHAR(100),
    approved_at TIMESTAMP WITHOUT TIME ZONE,
    approved_by_user_id BIGINT,
    approved_by_name VARCHAR(255),
    approved_by_role VARCHAR(100),
    approved_by_designation VARCHAR(255),
    created_from_version INTEGER,
    values_data TEXT,
    tables_data TEXT,
    attachments TEXT,
    version INTEGER DEFAULT 1,
    has_next_cycle BOOLEAN DEFAULT FALSE,
    next_version_id BIGINT,
    auditor_correction_requested BOOLEAN DEFAULT FALSE,
    correction_requested_for_auditor BOOLEAN DEFAULT FALSE,
    requires_auditor_resubmission BOOLEAN DEFAULT FALSE,
    auditor_correction_message TEXT,
    auditor_correction_requested_by VARCHAR(255),
    auditor_correction_requested_by_role VARCHAR(100),
    auditor_correction_requested_on TIMESTAMP WITHOUT TIME ZONE,
    auditor_resubmitted_at TIMESTAMP WITHOUT TIME ZONE,
    forwarded_administrative_posts TEXT,
    forwarded_to_auditor_posts TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS snapshots (
    id BIGSERIAL PRIMARY KEY,
    submission_id BIGINT NOT NULL,
    saved_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    status VARCHAR(50) NOT NULL,
    values_data TEXT,
    tables_data TEXT,
    attachments TEXT,
    version INTEGER,
    academic_year VARCHAR(50),
    audit_cycle VARCHAR(50),
    school_group VARCHAR(50),
    forwarded_administrative_posts TEXT,
    forwarded_to_auditor_posts TEXT,
    auditor_correction_requested BOOLEAN,
    correction_requested_for_auditor BOOLEAN,
    requires_auditor_resubmission BOOLEAN,
    auditor_correction_message TEXT,
    auditor_correction_requested_by VARCHAR(255),
    auditor_correction_requested_by_role VARCHAR(100),
    auditor_correction_requested_on TIMESTAMP WITHOUT TIME ZONE,
    auditor_resubmitted_at TIMESTAMP WITHOUT TIME ZONE,
    auditor_reviewed_by_email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS submission_auditor_assignments (
    id BIGSERIAL PRIMARY KEY,
    submission_id BIGINT NOT NULL,
    auditor_id BIGINT,
    auditor_name VARCHAR(255),
    auditor_email VARCHAR(255),
    auditor_type VARCHAR(50),
    category VARCHAR(50),
    assigned_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    post VARCHAR(255),
    status VARCHAR(50) DEFAULT 'PENDING',
    submitted_at TIMESTAMP WITHOUT TIME ZONE,
    values_data TEXT,
    tables_data TEXT,
    attachments TEXT,
    review_status VARCHAR(50),
    requires_auditor_resubmission BOOLEAN DEFAULT FALSE,
    correction_requested_for_auditor BOOLEAN DEFAULT FALSE,
    auditor_correction_requested BOOLEAN DEFAULT FALSE,
    auditor_correction_message TEXT,
    auditor_correction_requested_by VARCHAR(255),
    auditor_correction_requested_on TIMESTAMP WITHOUT TIME ZONE
);

CREATE TABLE IF NOT EXISTS academic_years (
    id BIGSERIAL PRIMARY KEY,
    year_label VARCHAR(255) NOT NULL,
    active BOOLEAN DEFAULT FALSE,
    started_at TIMESTAMP WITHOUT TIME ZONE,
    closed_at TIMESTAMP WITHOUT TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_submissions_email ON submissions(email);
CREATE INDEX IF NOT EXISTS idx_submissions_audit_type ON submissions(audit_type);
CREATE INDEX IF NOT EXISTS idx_submissions_academic_year ON submissions(academic_year);
CREATE INDEX IF NOT EXISTS idx_submissions_school ON submissions(school);
CREATE INDEX IF NOT EXISTS idx_submissions_university_id ON submissions(university_id);
CREATE INDEX IF NOT EXISTS idx_submissions_university_code ON submissions(university_code);
CREATE INDEX IF NOT EXISTS idx_submissions_schema_version_id ON submissions(schema_version_id);
CREATE INDEX IF NOT EXISTS idx_snapshots_submission_id ON snapshots(submission_id);
CREATE INDEX IF NOT EXISTS idx_auditor_assignments_sub_id ON submission_auditor_assignments(submission_id);
CREATE INDEX IF NOT EXISTS idx_auditor_assignments_auditor_id ON submission_auditor_assignments(auditor_id);
