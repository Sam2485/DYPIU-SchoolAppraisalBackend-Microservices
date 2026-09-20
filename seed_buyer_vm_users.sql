-- ==============================================================================
-- SQL Seed Script for Buyer's VM PostgreSQL Database (auth_db)
-- ==============================================================================
-- Run this script on the buyer's PostgreSQL database to provision the initial
-- IQAC Admin and Vice-Chancellor (VC) accounts.
--
-- Note: Passwords below are BCrypt hashes with 10 rounds:
-- Default Password: Password@123
-- Hash: $2a$10$Epkl0E2K4og54.Ag2axCbe3O0YpMRrCuLTeAEaKuGpa3UGm/HeS4m
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
    deleted
)
VALUES (
    'iqac@buyer-university.edu.in',
    '$2a$10$Epkl0E2K4og54.Ag2axCbe3O0YpMRrCuLTeAEaKuGpa3UGm/HeS4m',
    'IQAC Coordinator',
    'Head of Quality Assurance',
    'IQAC Office',
    'iqac',
    'iqac',
    'iqac',
    'active',
    FALSE
)
ON CONFLICT (email) DO UPDATE SET
    password = EXCLUDED.password,
    role = EXCLUDED.role,
    status = 'active',
    deleted = FALSE;

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
    deleted
)
VALUES (
    'vc@buyer-university.edu.in',
    '$2a$10$Epkl0E2K4og54.Ag2axCbe3O0YpMRrCuLTeAEaKuGpa3UGm/HeS4m',
    'Vice Chancellor',
    'Vice Chancellor',
    'Chancellor Secretariat',
    'vice-chancellor',
    'vice-chancellor',
    'vice-chancellor',
    'active',
    FALSE
)
ON CONFLICT (email) DO UPDATE SET
    password = EXCLUDED.password,
    role = EXCLUDED.role,
    status = 'active',
    deleted = FALSE;

-- ==============================================================================
-- Verification Query
-- ==============================================================================
SELECT id, email, name, role, designation, status, deleted FROM users WHERE role IN ('iqac', 'vice-chancellor');
