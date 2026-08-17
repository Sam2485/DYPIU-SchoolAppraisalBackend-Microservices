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
    lines = f.readlines()

# Extract all COPY blocks accurately line-by-line
copy_blocks = {}
current_tbl = None
current_lines = []

for line in lines:
    if line.startswith('COPY public.'):
        m = re.match(r'COPY\s+public\.([a-zA-Z0-9_]+)\s*\(', line)
        if m:
            current_tbl = m.group(1).lower()
            current_lines = [line]
            continue
    if current_tbl:
        current_lines.append(line)
        if line.strip() == r'\.':
            copy_blocks[current_tbl] = "".join(current_lines)
            current_tbl = None
            current_lines = []

print(f"Extracted COPY blocks for {len(copy_blocks)} tables:")
for tbl, block in copy_blocks.items():
    row_count = len(block.strip().split('\n')) - 2
    if row_count > 0:
        print(f"  - {tbl}: {row_count} data rows")

content = "".join(lines)

# Sequence to table map
seq_owned = re.findall(r'ALTER\s+SEQUENCE\s+public\.([a-zA-Z0-9_]+)\s+OWNED\s+BY\s+public\.([a-zA-Z0-9_]+)\.([a-zA-Z0-9_]+);', content, re.IGNORECASE)
seq_to_table = {seq.lower(): tbl.lower() for seq, tbl, col in seq_owned}

all_tables_in_dump = set(re.findall(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?public\.([a-zA-Z0-9_]+)', content, re.IGNORECASE))
form_tables = all_tables_in_dump - auth_tables - submission_tables - {'flyway_schema_history'}
form_tables_all = form_tables | {'academic_years'}

def generate_header(db_name, service_name, port):
    return f"""-- =============================================================================
-- PostgreSQL Database Dump: {db_name}
-- Target Microservice: {service_name} (Port {port})
-- Source: school_appraisal_backup_2026-08-13.sql
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

toc_blocks = re.split(r'\n(?=--\n-- TOC entry )', content)

def get_block_info(b):
    # 1. CREATE TABLE
    m = re.search(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'TABLE'
    
    # 2. FOREIGN KEY
    m = re.search(r'ALTER\s+TABLE\s+ONLY\s+public\.([a-zA-Z0-9_]+)\s+ADD\s+CONSTRAINT\s+[a-zA-Z0-9_]+\s+FOREIGN\s+KEY\s+\([^\)]+\)\s+REFERENCES\s+public\.([a-zA-Z0-9_]+)', b, re.IGNORECASE)
    if m:
        return (m.group(1).lower(), m.group(2).lower()), 'FK_CONSTRAINT'
        
    # 3. CONSTRAINT
    m = re.search(r'ALTER\s+TABLE\s+ONLY\s+public\.([a-zA-Z0-9_]+)\s+ADD\s+CONSTRAINT', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'CONSTRAINT'
    
    # 4. DEFAULT
    m = re.search(r'ALTER\s+TABLE\s+ONLY\s+public\.([a-zA-Z0-9_]+)\s+ALTER\s+COLUMN', b, re.IGNORECASE)
    if m: return m.group(1).lower(), 'DEFAULT'
    
    # 5. INDEX
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

    return None, 'OTHER'

auth_blocks = {'ddl': [], 'constraints': [], 'indexes': [], 'fks': [], 'seq_set': []}
submission_blocks = {'ddl': [], 'constraints': [], 'indexes': [], 'fks': [], 'seq_set': []}
forms_blocks = {'ddl': [], 'constraints': [], 'indexes': [], 'fks': [], 'seq_set': []}

for b in toc_blocks[1:]:
    # Skip any TABLE DATA blocks from TOC (we handle COPY blocks explicitly)
    if 'Type: TABLE DATA' in b:
        continue
        
    tbl_info, b_type = get_block_info(b)
    if not tbl_info:
        continue
    
    if b_type == 'FK_CONSTRAINT':
        src_tbl, target_tbl = tbl_info
        if src_tbl in auth_tables and target_tbl in auth_tables:
            auth_blocks['fks'].append(b)
        elif src_tbl in submission_tables and target_tbl in submission_tables:
            submission_blocks['fks'].append(b)
        elif src_tbl in form_tables_all and target_tbl in form_tables_all:
            forms_blocks['fks'].append(b)
        continue
        
    tbl = tbl_info
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

def assemble_sql(db_name, service_name, port, blocks_dict, target_tables):
    parts = [generate_header(db_name, service_name, port)]
    
    # 1. DDL
    parts.append("-- -----------------------------------------------------------------------------\n-- 1. TABLE & SEQUENCE SCHEMAS\n-- -----------------------------------------------------------------------------\n")
    for b in blocks_dict['ddl']:
        parts.append(b.strip() + "\n\n")
        
    # 2. DATA
    parts.append("-- -----------------------------------------------------------------------------\n-- 2. TABLE DATA INSERTS\n-- -----------------------------------------------------------------------------\n")
    for tbl in sorted(target_tables):
        if tbl in copy_blocks:
            parts.append(copy_blocks[tbl].strip() + "\n\n")
            
    # 3. CONSTRAINTS
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

auth_sql = assemble_sql('appraisal_auth_user_db', 'auth-user-service', 9001, auth_blocks, auth_tables)
sub_sql = assemble_sql('appraisal_submission_db', 'submission-service', 9003, submission_blocks, submission_tables)
forms_sql = assemble_sql('appraisal_forms_db', 'form-data-service', 9002, forms_blocks, form_tables_all)

for path in [os.path.join(out_dir, 'appraisal_auth_user_db.sql'), os.path.join(project_db_dir, 'appraisal_auth_user_db.sql')]:
    with open(path, 'w', encoding='utf-8') as f: f.write(auth_sql)

for path in [os.path.join(out_dir, 'appraisal_submission_db.sql'), os.path.join(project_db_dir, 'appraisal_submission_db.sql')]:
    with open(path, 'w', encoding='utf-8') as f: f.write(sub_sql)

for path in [os.path.join(out_dir, 'appraisal_forms_db.sql'), os.path.join(project_db_dir, 'appraisal_forms_db.sql')]:
    with open(path, 'w', encoding='utf-8') as f: f.write(forms_sql)

print("\n[SUCCESS] Split completed accurately!")
