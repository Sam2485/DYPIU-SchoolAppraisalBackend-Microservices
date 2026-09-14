-- V2: Add table_buttons column to form_sections for dynamic repeater groups
ALTER TABLE form_sections ADD COLUMN IF NOT EXISTS table_buttons TEXT;
