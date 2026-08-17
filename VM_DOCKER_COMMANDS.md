# 🚀 VM Deployment Commands (9000-Series Ports)

This guide provides the exact commands to deploy the **DYPIU Faculty Appraisal Microservices** on your Linux VM (`dypiu@10.100.0.23`).

---

## 📌 9000-Series Port Allocation

| Service Name | Port | Description |
| :--- | :---: | :--- |
| **`api-gateway`** | **`9000`** | **Main Entrypoint** for React Frontend & API requests |
| **`auth-user-service`** | `9001` | Authentication, Users, MFA & OTP |
| **`form-data-service`** | `9002` | 64 Academic & Administrative Form Section Tables |
| **`submission-service`** | `9003` | Appraisal Submission Lifecycle & Workflow |
| **`storage-service`** | `9004` | Uploads & File Streaming |
| **`admin-service`** | `9005` | OS Backups & Database Dump/Restore |

---

## 🗄️ 0. Database Setup & Restore (Run Once)

```bash
# 1. Create the 3 microservice databases
sudo -u postgres psql -c "CREATE DATABASE appraisal_auth_user_db;"
sudo -u postgres psql -c "CREATE DATABASE appraisal_forms_db;"
sudo -u postgres psql -c "CREATE DATABASE appraisal_submission_db;"

# 2. Grant permissions to app_user across all 3 databases
sudo -u postgres psql -d appraisal_auth_user_db -c "
    GRANT ALL ON SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO app_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO app_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO app_user;
"

sudo -u postgres psql -d appraisal_forms_db -c "
    GRANT ALL ON SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO app_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO app_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO app_user;
"

sudo -u postgres psql -d appraisal_submission_db -c "
    GRANT ALL ON SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_user;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO app_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO app_user;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO app_user;
"

# 3. Restore the 3 split database files from ~/Backup
sudo -u postgres psql -d appraisal_auth_user_db -f ~/Backup/appraisal_auth_user_db.sql
sudo -u postgres psql -d appraisal_forms_db -f ~/Backup/appraisal_forms_db.sql
sudo -u postgres psql -d appraisal_submission_db -f ~/Backup/appraisal_submission_db.sql
```

---

## ⚡ Option A: Docker Compose Deployment (Recommended - 1 Command)

```bash
cd ~/DYPIU-SchoolAppraisalBackend-Microservices
git pull origin main

# Build and start all 6 microservices in the background
sudo docker compose up -d --build

# Verify service health
./scripts/health-check.sh
```

---

## 🛠️ Option B: Individual Docker Commands (Production - Port 9000)

### 1. Rebuild All 6 Microservice Images:
```bash
cd ~/DYPIU-SchoolAppraisalBackend-Microservices
git pull origin main

sudo docker build -f auth-user-service/Dockerfile -t appraisal-auth-user-service .
sudo docker build -f form-data-service/Dockerfile -t appraisal-form-data-service .
sudo docker build -f submission-service/Dockerfile -t appraisal-submission-service .
sudo docker build -f storage-service/Dockerfile -t appraisal-storage-service .
sudo docker build -f admin-service/Dockerfile -t appraisal-admin-service .
sudo docker build -f api-gateway/Dockerfile -t appraisal-api-gateway .
```

### 2. Restart Containers:
```bash
# 1. Stop and remove existing containers
sudo docker rm -f appraisal-api-gateway appraisal-auth-user-service appraisal-form-data-service appraisal-submission-service appraisal-storage-service appraisal-admin-service

# 2. Auth & User Service (Port 9001)
sudo docker run -d \
      --name appraisal-auth-user-service \
      --net=host \
      -e SERVER_PORT=9001 \
      -e DATABASE_URL=jdbc:postgresql://localhost:5432/appraisal_auth_user_db \
      -e DB_USERNAME=app_user \
      -e DB_PASSWORD='dypiu#2020$' \
      appraisal-auth-user-service

# 3. Form Data Service (Port 9002)
sudo docker run -d \
      --name appraisal-form-data-service \
      --net=host \
      -e SERVER_PORT=9002 \
      -e DATABASE_URL=jdbc:postgresql://localhost:5432/appraisal_forms_db \
      -e DB_USERNAME=app_user \
      -e DB_PASSWORD='dypiu#2020$' \
      appraisal-form-data-service

# 4. Submission Service (Port 9003)
sudo docker run -d \
      --name appraisal-submission-service \
      --net=host \
      -e SERVER_PORT=9003 \
      -e DATABASE_URL=jdbc:postgresql://localhost:5432/appraisal_submission_db \
      -e DB_USERNAME=app_user \
      -e DB_PASSWORD='dypiu#2020$' \
      -e AUTH_SERVICE_URL=http://localhost:9001 \
      -e FORMS_SERVICE_URL=http://localhost:9002 \
      appraisal-submission-service

# 5. Storage Service (Port 9004)
sudo docker run -d \
      --name appraisal-storage-service \
      --net=host \
      -e SERVER_PORT=9004 \
      -v /home/dypiu/DYPIU-SchoolAppraisalBackend/uploads:/app/uploads \
      -e UPLOAD_LOCAL_PATH=/app/uploads \
      appraisal-storage-service

# 6. Admin Service (Port 9005)
sudo docker run -d \
      --name appraisal-admin-service \
      --net=host \
      -e SERVER_PORT=9005 \
      -v /home/dypiu/DYPIU-SchoolAppraisalBackend/uploads:/app/uploads \
      -v /home/dypiu/Backup:/app/backups \
      -e UPLOAD_DIR=/app/uploads \
      -e BACKUP_DIR=/app/backups \
      -e DB_HOST=localhost \
      -e DB_PORT=5432 \
      -e DB_USERNAME=app_user \
      -e DB_PASSWORD='dypiu#2020$' \
      appraisal-admin-service

# 7. API Gateway (Port 9000 - Entrypoint for Frontend)
sudo docker run -d \
      --name appraisal-api-gateway \
      --net=host \
      -e SERVER_PORT=9000 \
      -e AUTH_SERVICE_URL=http://localhost:9001 \
      -e FORMS_SERVICE_URL=http://localhost:9002 \
      -e SUBMISSION_SERVICE_URL=http://localhost:9003 \
      -e STORAGE_SERVICE_URL=http://localhost:9004 \
      -e ADMIN_SERVICE_URL=http://localhost:9005 \
      appraisal-api-gateway
```

---

## 💻 3. Frontend Deployment (Port 3001)

### Rebuild & Restart Container:
```bash
cd ~/DYPIU-SchoolAppraisal-frontend
git pull origin main
sudo docker build -t school-appraisal-frontend .

sudo docker rm -f school-appraisal-frontend

# Run container pointing to Microservices Gateway at Port 9000
sudo docker run -d \
      --name school-appraisal-frontend \
      -p 3001:8080 \
      -e VITE_API_BASE_URL="http://10.100.0.23:9000" \
      school-appraisal-frontend
```

---

## 📦 4. Microservices Database Backup Commands

```bash
# Backup all 3 partitioned databases
PGPASSWORD='dypiu#2020$' pg_dump -h localhost -p 5432 -U app_user -d appraisal_auth_user_db -F p -b -v -f /home/dypiu/Backup/appraisal_auth_user_db_$(date +%Y-%m-%d).sql
PGPASSWORD='dypiu#2020$' pg_dump -h localhost -p 5432 -U app_user -d appraisal_forms_db -F p -b -v -f /home/dypiu/Backup/appraisal_forms_db_$(date +%Y-%m-%d).sql
PGPASSWORD='dypiu#2020$' pg_dump -h localhost -p 5432 -U app_user -d appraisal_submission_db -F p -b -v -f /home/dypiu/Backup/appraisal_submission_db_$(date +%Y-%m-%d).sql

# Backup attachments
zip -r /home/dypiu/Backup/uploads_backup_$(date +%Y-%m-%d).zip /home/dypiu/DYPIU-SchoolAppraisalBackend/uploads/
```
