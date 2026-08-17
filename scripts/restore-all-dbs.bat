@echo off
rem =============================================================================
rem Microservices Database Restore Script (Windows)
rem =============================================================================

set DB_HOST=localhost
set DB_PORT=5432
set DB_USER=postgres
set BACKUP_DIR=.\database-backups

echo =================================================================
echo  Restoring Microservices Databases from: %BACKUP_DIR%
echo  Host: %DB_HOST%:%DB_PORT% ^| User: %DB_USER%
echo =================================================================

echo 1. Restoring appraisal_auth_user_db...
psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d appraisal_auth_user_db -f "%BACKUP_DIR%\appraisal_auth_user_db.sql"

echo 2. Restoring appraisal_forms_db...
psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d appraisal_forms_db -f "%BACKUP_DIR%\appraisal_forms_db.sql"

echo 3. Restoring appraisal_submission_db...
psql -h %DB_HOST% -p %DB_PORT% -U %DB_USER% -d appraisal_submission_db -f "%BACKUP_DIR%\appraisal_submission_db.sql"

echo =================================================================
echo  All 3 Microservices Databases Restored Successfully!
echo =================================================================
pause
