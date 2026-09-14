-- V3: Alter logo_url and iqac_logo_url columns to TEXT in universities table
ALTER TABLE universities ALTER COLUMN logo_url TYPE TEXT;
ALTER TABLE universities ALTER COLUMN iqac_logo_url TYPE TEXT;
