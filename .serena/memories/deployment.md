# Deployment & Operations Memory

## Deployment Strategies

### 1. Docker Compose (Recommended for Production VM)
- Orchestration file: `docker-compose.yml`
- Multi-stage Dockerfiles present in each service submodule directory.
- Shared Volumes: `pgdata` (PostgreSQL data), `uploads_data` (`/app/uploads`), `backups_data` (`/app/backups`).
- Reverse Proxy: `nginx/nginx.conf` proxies incoming HTTP requests on port 80/443 to `api-gateway:9000`.

### 2. Operational Scripts (`scripts/`)
- `deploy.sh`: One-click bash deployment (loads `.env`, executes Maven packaging, triggers Docker Compose build/up, verifies health).
- `health-check.sh`: Probes Actuator and root health endpoints for all 6 microservices.
- `start-all.sh`: Script to launch all microservices in standalone local mode.
- `stop-all.sh`: Script to terminate microservices in standalone mode.
- `appraisal-microservices.service`: Systemd service unit definition for Linux system auto-start.

### 3. Configurable Port Defaults (9000 Series)
- Gateway: `GATEWAY_PORT` (Default: 9000)
- Auth User Service: `AUTH_SERVICE_PORT` (Default: 9001)
- Form Data Service: `FORMS_SERVICE_PORT` (Default: 9002)
- Submission Service: `SUBMISSION_SERVICE_PORT` (Default: 9003)
- Storage Service: `STORAGE_SERVICE_PORT` (Default: 9004)
- Admin Service: `ADMIN_SERVICE_PORT` (Default: 9005)
- PostgreSQL: `POSTGRES_PORT` (Default: 5432)

