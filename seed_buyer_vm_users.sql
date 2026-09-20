-- ==============================================================================
-- SQL Seed Script for Buyer's VM PostgreSQL Database (auth_db)
-- ==============================================================================
-- Run this script on the buyer's PostgreSQL database to provision the initial
-- IQAC Admin and Vice-Chancellor (VC) accounts.
--
-- Note: Passwords below are BCrypt hashes with 10 rounds:
-- Default Password: Password@123
-- Hash: $2a$10$7EqJtq98hPqEX7fNZaFWoO.8/bB8cE04K3g8g8Qk8o0j1l9u3K8y6
-- (You can change passwords anytime or supply your own BCrypt hash)
-- ==============================================================================

-- 1. Provision IQAC Administrator Account
INSERT INTO users (
    email,
    password,
    name,
    designation,
    school,
    role,
    account_type,
    category,
    status,
    deleted,
    created_at,
    updated_at
)
VALUES (
    'iqac@buyer-university.edu.in',
    '$2a$10$7EqJtq98hPqEX7fNZaFWoO.8/bB8cE04K3g8g8Qk8o0j1l9u3K8y6',
    'IQAC Coordinator',
    'Head of Quality Assurance',
    'IQAC Office',
    'iqac',
    'iqac',
    'iqac',
    'active',
    FALSE,
    NOW(),
    NOW()
)
ON CONFLICT (email) DO UPDATE SET
    role = EXCLUDED.role,
    status = 'active',
    deleted = FALSE,
    updated_at = NOW();

-- 2. Provision Vice-Chancellor Account
INSERT INTO users (
    email,
    password,
    name,
    designation,
    school,
    role,
    account_type,
    category,
    status,
    deleted,
    created_at,
    updated_at
)
VALUES (
    'vc@buyer-university.edu.in',
    '$2a$10$7EqJtq98hPqEX7fNZaFWoO.8/bB8cE04K3g8g8Qk8o0j1l9u3K8y6',
    'Vice Chancellor',
    'Vice Chancellor',
    'Chancellor Secretariat',
    'vice-chancellor',
    'vice-chancellor',
    'vice-chancellor',
    'active',
    FALSE,
    NOW(),
    NOW()
)
ON CONFLICT (email) DO UPDATE SET
    role = EXCLUDED.role,
    status = 'active',
    deleted = FALSE,
    updated_at = NOW();

-- ==============================================================================
-- Verification Query
-- ==============================================================================
SELECT id, email, name, role, designation, status, deleted FROM users WHERE role IN ('iqac', 'vice-chancellor');
