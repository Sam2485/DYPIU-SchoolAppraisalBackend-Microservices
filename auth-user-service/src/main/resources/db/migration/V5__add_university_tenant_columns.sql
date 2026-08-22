-- V5: Add multi-tenant university columns to users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS university_id BIGINT DEFAULT 1;
ALTER TABLE users ADD COLUMN IF NOT EXISTS university_code VARCHAR(50) DEFAULT 'dypiu';

CREATE INDEX IF NOT EXISTS idx_users_university_id ON users(university_id);
CREATE INDEX IF NOT EXISTS idx_users_university_code ON users(university_code);
