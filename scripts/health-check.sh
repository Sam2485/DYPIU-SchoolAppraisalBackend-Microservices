#!/usr/bin/env bash

GATEWAY_PORT=${GATEWAY_PORT:-8080}
AUTH_PORT=${AUTH_SERVICE_PORT:-8081}
FORMS_PORT=${FORMS_SERVICE_PORT:-8082}
SUBMISSION_PORT=${SUBMISSION_SERVICE_PORT:-8083}
STORAGE_PORT=${STORAGE_SERVICE_PORT:-8084}
ADMIN_PORT=${ADMIN_SERVICE_PORT:-8085}

echo "🏥 Running Microservices Health Audit..."

check_service() {
    local name=$1
    local port=$2
    local code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${port}/actuator/health || curl -s -o /dev/null -w "%{http_code}" http://localhost:${port}/)
    if [ "$code" -eq 200 ] || [ "$code" -eq 401 ] || [ "$code" -eq 404 ]; then
        echo "  🟢 [ONLINE] ${name} (Port ${port}) - Status ${code}"
    else
        echo "  🔴 [OFFLINE] ${name} (Port ${port}) - Status ${code}"
    fi
}

check_service "API Gateway" ${GATEWAY_PORT}
check_service "Auth & User Service" ${AUTH_PORT}
check_service "Form Data Service" ${FORMS_PORT}
check_service "Submission Service" ${SUBMISSION_PORT}
check_service "Storage Service" ${STORAGE_PORT}
check_service "Admin Service" ${ADMIN_PORT}

echo "🏥 Health check execution complete."
