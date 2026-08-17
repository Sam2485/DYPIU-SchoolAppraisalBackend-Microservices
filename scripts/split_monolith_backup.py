import os
import re

input_sql = r'C:\Users\samar\Downloads\school_appraisal_backup_2026-08-13.sql'
out_dir = r'C:\Users\samar\Downloads'
project_db_dir = r'C:\Users\samar\OneDrive\Desktop\Faculty Appraisal Project\DirectorAppraisal\director-appraisal\database-backups'

os.makedirs(project_db_dir, exist_ok=True)

auth_tables = {
    'users', 'user_administrative_posts', 'mfa_login_sessions', 
    'refresh_tokens', 'password_reset_tokens'
}

submission_tables = {
    'academic_years', 'submissions', 'submission_auditor_assignments', 'snapshots'
}

with open(input_sql, 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

# Step 1: Extract all sequence mappings
seq_owned = re.findall(r'ALTER\s+SEQUENCE\s+public\.([a-zA-Z0-9_]+)\s+OWNED\s+BY\s+public\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+);', content, re.IGNORECASE)
seq_to_table = {seq.lower(): tbl.lower() for seq, tbl, col in seq_owned}

# Step 2: Extract all COPY data blocks
copy_blocks = {}
for match in re.finditer(r'(COPY\s+public\.([a-zA-Z0-9_]+)\s*\([^\)]*\)\s*FROM\s+stdin;\n.*?\n\\\.)', content, re.DOTALL):
    tbl = match.group(2).lower()
    copy_blocks[tbl] = match.group(1)

all_tables_in_dump = set(re.findall(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?public\.([a-zA-Z0-9_]+)', content, re.IGNORECASE))
form_tables = all_tables_in_dump - auth_tables - submission_tables - {'flyway_schema_history'}
# academic_years is needed in forms DB as well as submission DB
form_tables_all = form_tables | {'academic_years'}

print(f"Total tables found in dump: {len(all_tables_in_dump)}")
print(f"Auth tables ({len(auth_tables)}): {sorted(auth_tables)}")
print(f"Submission tables ({len(submission_tables)}): {sorted(submission_tables)}")
print(f"Form tables ({len(form_tables_all)}): {sorted(form_tables_all)}")

# Standard PostgreSQL Header
def generate_header(db_name, service_name, port):
    return f"""-- =============================================================================
-- PostgreSQL Database Dump: {db_name}
-- Target Microservice: {service_name} (Port {port})
-- Extracted from: school_appraisal_backup_2026-08-13.sql
-- System: DYPIU Director & Faculty Appraisal System
-- Date: {os.path.basename(input_sql)}
-- =============================================================================

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

SET search_path = public, pg_catalog;

"""

# Parse TOC blocks
toc_blocks = re.split(r'\n(?=--\n-- TOC entry )', content)
header_raw = toc_blocks[0]

def get_block_info(b):
    # Get table name associated with block
    # 1. CREATE TABLE
    m = re.search(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'TABLE'
    
    # 2. ALTER TABLE ONLY ... ADD CONSTRAINT ... FOREIGN KEY ... REFERENCES ...
    m = re.search(r'ALTER\s+TABLE\s+ONLY\s+public\.([a-zA-Z0-9_]+)\s+ADD\s+CONSTRAINT\s+[a-zA-Z0-9_]+\s+FOREIGN\s+KEY\s+\([^\)]+\)\s+REFERENCES\s+public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m:
        src_tbl = m.group(1).lower()
        target_tbl = m.group(2).lower()
        return (src_tbl, target_tbl), 'FK_CONSTRAINT'
        
    # 3. ALTER TABLE ONLY ... ADD CONSTRAINT
    m = re.search(r'ALTER\s+TABLE\s+ONLY\s+public\.([a-zA-Z0-9_]+)\s+ADD\s+CONSTRAINT', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'CONSTRAINT'
    
    # 4. ALTER TABLE ONLY ... SET DEFAULT
    m = re.search(r'ALTER\s+TABLE\s+ONLY\s+public\.([a-zA-Z0-9_]+)\s+ALTER\s+COLUMN', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'DEFAULT'
    
    # 5. CREATE INDEX
    m = re.search(r'CREATE\s+(?:UNIQUE\s+)?INDEX\s+.*?\s+ON\s+public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'INDEX'
    
    # 6. SEQUENCE OWNED BY
    m = re.search(r'ALTER\s+SEQUENCE\s+public\.([a-zA-Z0-9_]+)\s+OWNED\s+BY\s+public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m: return m.group(2).lower(), 'SEQ_OWNED'
    
    # 7. CREATE SEQUENCE
    m = re.search(r'CREATE\s+SEQUENCE\s+public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m:
        seq = m.group(1).lower()
        tbl = seq_to_table.get(seq, seq.replace('_id_seq', '').replace('_seq', ''))
        return tbl, 'SEQUENCE'
        
    # 8. SEQUENCE SET
    m = re.search(r"SELECT\s+pg_catalog\.setval\('public\.([a-zA-Z0-9_]+)'", b, re.IGNORECASE)
    if m:
        seq = m.group(1).lower()
        tbl = seq_to_table.get(seq, seq.replace('_id_seq', '').replace('_seq', ''))
        return tbl, 'SEQ_SET'
        
    # 9. ACL
    m = re.search(r'-- Name: TABLE ([a-zA-Z0-9_]+); Type: ACL', b)
    if m: return m.group(1).lower(), 'ACL'
    
    m = re.search(r'-- Name: SEQUENCE ([a-zA-Z0-9_]+); Type: ACL', b)
    if m:
        seq = m.group(1).lower()
        tbl = seq_to_table.get(seq, seq.replace('_id_seq', '').replace('_seq', ''))
        return tbl, 'ACL'

    return None, 'OTHER'

# Categorize all blocks
auth_blocks = {'ddl': [], 'constraints': [], 'indexes': [], 'fks': [], 'seq_set': []}
submission_blocks = {'ddl': [], 'constraints': [], 'indexes': [], 'fks': [], 'seq_set': []}
forms_blocks = {'ddl': [], 'constraints': [], 'indexes': [], 'fks': [], 'seq_set': []}

for b in toc_blocks[1:]:
    tbl_info, b_type = get_block_info(b)
    if not tbl_info:
        continue
    
    if b_type == 'FK_CONSTRAINT':
        src_tbl, target_tbl = tbl_info
        # Only include FK if both source and target belong to the same database!
        if src_tbl in auth_tables and target_tbl in auth_tables:
            auth_blocks['fks'].append(b)
        elif src_tbl in submission_tables and target_tbl in submission_tables:
            submission_blocks['fks'].append(b)
        elif src_tbl in form_tables_all and target_tbl in form_tables_all:
            forms_blocks['fks'].append(b)
        else:
            print(f"Skipping cross-db FK constraint: {src_tbl} -> {target_tbl}")
        continue
        
    tbl = tbl_info
    
    # Destination check
    target_dbs = []
    if tbl in auth_tables:
        target_dbs.append(('auth', auth_blocks))
    if tbl in submission_tables:
        target_dbs.append(('submission', submission_blocks))
    if tbl in form_tables_all:
        target_dbs.append(('forms', forms_blocks))
        
    for db_name, db_dict in target_dbs:
        if b_type in ('TABLE', 'SEQUENCE', 'SEQ_OWNED', 'DEFAULT'):
            db_dict['ddl'].append(b)
        elif b_type == 'CONSTRAINT':
            db_dict['constraints'].append(b)
        elif b_type == 'INDEX':
            db_dict['indexes'].append(b)
        elif b_type == 'SEQ_SET':
            db_dict['seq_set'].append(b)

# Function to assemble complete SQL file
def assemble_sql(db_name, service_name, port, blocks_dict, target_tables):
    parts = [generate_header(db_name, service_name, port)]
    
    # 1. DDL: Sequences, Tables, Defaults
    parts.append("-- -----------------------------------------------------------------------------\n-- 1. TABLE & SEQUENCE SCHEMAS\n-- -----------------------------------------------------------------------------\n")
    for b in blocks_dict['ddl']:
        parts.append(b.strip() + "\n\n")
        
    # 2. DATA: COPY blocks
    parts.append("-- -----------------------------------------------------------------------------\n-- 2. TABLE DATA INSERTS\n-- -----------------------------------------------------------------------------\n")
    for tbl in sorted(target_tables):
        if tbl in copy_blocks:
            parts.append(copy_blocks[tbl].strip() + "\n\n")
            
    # 3. CONSTRAINTS (PKs & UNIQUE)
    parts.append("-- -----------------------------------------------------------------------------\n-- 3. PRIMARY KEYS & UNIQUE CONSTRAINTS\n-- -----------------------------------------------------------------------------\n")
    for b in blocks_dict['constraints']:
        parts.append(b.strip() + "\n\n")
        
    # 4. INDEXES
    parts.append("-- -----------------------------------------------------------------------------\n-- 4. INDEXES\n-- -----------------------------------------------------------------------------\n")
    for b in blocks_dict['indexes']:
        parts.append(b.strip() + "\n\n")
        
    # 5. INTRA-SERVICE FOREIGN KEYS
    if blocks_dict['fks']:
        parts.append("-- -----------------------------------------------------------------------------\n-- 5. INTRA-DATABASE FOREIGN KEY CONSTRAINTS\n-- -----------------------------------------------------------------------------\n")
        for b in blocks_dict['fks']:
            parts.append(b.strip() + "\n\n")
            
    # 6. SEQUENCE SETVALS
    parts.append("-- -----------------------------------------------------------------------------\n-- 6. SEQUENCE VALUE SYNCHRONIZATION\n-- -----------------------------------------------------------------------------\n")
    for b in blocks_dict['seq_set']:
        parts.append(b.strip() + "\n\n")
        
    return "".join(parts)

# Generate 3 files
auth_sql = assemble_sql('appraisal_auth_user_db', 'auth-user-service', 8081, auth_blocks, auth_tables)
sub_sql = assemble_sql('appraisal_submission_db', 'submission-service', 8083, submission_blocks, submission_tables)
forms_sql = assemble_sql('appraisal_forms_db', 'form-data-service', 8082, forms_blocks, form_tables_all)

# Save to C:\Users\samar\Downloads\
downloads_auth = os.path.join(out_dir, 'appraisal_auth_user_db.sql')
downloads_sub = os.path.join(out_dir, 'appraisal_submission_db.sql')
downloads_forms = os.path.join(out_dir, 'appraisal_forms_db.sql')

with open(downloads_auth, 'w', encoding='utf-8') as f: f.write(auth_sql)
with open(downloads_sub, 'w', encoding='utf-8') as f: f.write(sub_sql)
with open(downloads_forms, 'w', encoding='utf-8') as f: f.write(forms_sql)

# Also save to project directory
proj_auth = os.path.join(project_db_dir, 'appraisal_auth_user_db.sql')
proj_sub = os.path.join(project_db_dir, 'appraisal_submission_db.sql')
proj_forms = os.path.join(project_db_dir, 'appraisal_forms_db.sql')

with open(proj_auth, 'w', encoding='utf-8') as f: f.write(auth_sql)
with open(proj_sub, 'w', encoding='utf-8') as f: f.write(sub_sql)
with open(proj_forms, 'w', encoding='utf-8') as f: f.write(forms_sql)

print("\n[SUCCESS] GENERATION COMPLETE!")
print(f"1. {downloads_auth} (Size: {os.path.getsize(downloads_auth)} bytes)")
print(f"2. {downloads_forms} (Size: {os.path.getsize(downloads_forms)} bytes)")
print(f"3. {downloads_sub} (Size: {os.path.getsize(downloads_sub)} bytes)")

