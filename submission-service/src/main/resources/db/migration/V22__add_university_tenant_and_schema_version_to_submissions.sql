-- V22: Add university tenant and schema version columns to submissions table

ALTER TABLE submissions ADD COLUMN IF NOT EXISTS university_id BIGINT DEFAULT 1;
ALTER TABLE submissions ADD COLUMN IF NOT EXISTS university_code VARCHAR(50) DEFAULT 'dypiu';
ALTER TABLE submissions ADD COLUMN IF NOT EXISTS schema_version_id BIGINT;

CREATE INDEX IF NOT EXISTS idx_submissions_university_id ON submissions(university_id);
CREATE INDEX IF NOT EXISTS idx_submissions_university_code ON submissions(university_code);
CREATE INDEX IF NOT EXISTS idx_submissions_schema_version_id ON submissions(schema_version_id);
