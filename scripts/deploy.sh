#!/usr/bin/env bash
set -e

echo "================================================================="
echo "🚀 Starting Production Deployment of Microservices Architecture"
echo "================================================================="

# 1. Load environment variables
if [ -f .env ]; then
    echo "📄 Loading configuration from .env file..."
    export $(cat .env | grep -v '#' | xargs)
else
    echo "⚠️ .env file not found! Copying from .env.example..."
    cp .env.example .env
    export $(cat .env | grep -v '#' | xargs)
fi

# 2. Make scripts executable
chmod +x scripts/*.sh

# 3. Build parent and microservice modules
echo "📦 Building Java Spring Boot microservice modules with Maven..."
./mvnw clean package -DskipTests || mvn clean package -DskipTests

# 4. Build and start containers
echo "🐳 Building Docker images and launching containers with Docker Compose..."
docker compose up -d --build

# 5. Run health checks
echo "⏳ Waiting 15 seconds for microservices startup..."
sleep 15
./scripts/health-check.sh

echo "================================================================="
echo "✅ Microservices Deployment Complete!"
echo "================================================================="
