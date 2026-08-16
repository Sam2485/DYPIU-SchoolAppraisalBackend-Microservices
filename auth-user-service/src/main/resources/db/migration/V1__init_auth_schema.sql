CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    designation VARCHAR(255),
    school VARCHAR(100),
    role VARCHAR(50),
    account_type VARCHAR(50),
    category VARCHAR(50),
    auditor_type VARCHAR(50),
    auditor_role VARCHAR(100),
    post VARCHAR(255),
    schools VARCHAR(500),
    avatar_url VARCHAR(500),
    status VARCHAR(50) DEFAULT 'active',
    deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP,
    deleted_by VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_administrative_posts (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    post VARCHAR(255)
);