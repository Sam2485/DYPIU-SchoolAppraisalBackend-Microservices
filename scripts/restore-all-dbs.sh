#!/usr/bin/env bash
# =============================================================================
# Microservices Database Restore Script (Linux / Docker)
# =============================================================================
set -e

DB_HOST="${POSTGRES_HOST:-localhost}"
DB_PORT="${POSTGRES_PORT:-5432}"
DB_USER="${POSTGRES_USER:-postgres}"
BACKUP_DIR="${1:-./database-backups}"

echo "================================================================="
echo " Restoring Microservices Databases from: $BACKUP_DIR"
echo " Host: $DB_HOST:$DB_PORT | User: $DB_USER"
echo "================================================================="

# Check files
if [ ! -f "$BACKUP_DIR/appraisal_auth_user_db.sql" ] || \
   [ ! -f "$BACKUP_DIR/appraisal_forms_db.sql" ] || \
   [ ! -f "$BACKUP_DIR/appraisal_submission_db.sql" ]; then
    echo " Error: Missing one or more .sql files in $BACKUP_DIR"
    exit 1
fi

echo "1. Restoring appraisal_auth_user_db..."
PGPASSWORD="${POSTGRES_PASSWORD:-postgres}" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d appraisal_auth_user_db -f "$BACKUP_DIR/appraisal_auth_user_db.sql"

echo "2. Restoring appraisal_forms_db..."
PGPASSWORD="${POSTGRES_PASSWORD:-postgres}" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d appraisal_forms_db -f "$BACKUP_DIR/appraisal_forms_db.sql"

echo "3. Restoring appraisal_submission_db..."
PGPASSWORD="${POSTGRES_PASSWORD:-postgres}" psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d appraisal_submission_db -f "$BACKUP_DIR/appraisal_submission_db.sql"

echo "================================================================="
echo " All 3 Microservices Databases Restored Successfully!"
echo "================================================================="
