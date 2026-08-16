-- already included in V1, kept for compatibility
ALTER TABLE users ADD COLUMN IF NOT EXISTS avatar_url VARCHAR(500);