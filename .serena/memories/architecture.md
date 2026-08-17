# Architecture & Communication Memory

## System Topology
- **Entry Point**: `api-gateway` (Spring Cloud Gateway, Netty-based reactive server on port 9000).
- **Service Mesh / Inter-Service Communication**:
  - Spring Cloud OpenFeign HTTP clients (`@EnableFeignClients`).
  - `submission-service` queries `auth-user-service` via `AuthUserClient` (`${AUTH_SERVICE_URL:http://localhost:9001}`).
  - `submission-service` queries `form-data-service` via `FormDataClient` (`${FORMS_SERVICE_URL:http://localhost:9002}`).
- **Network Boundaries**:
  - In Docker Compose, containers communicate over internal Docker bridge network (`postgres`, `auth-user-service`, etc.).
  - In standalone VM execution, services communicate via localhost or private loopback bindings.

---

## Request Lifecycle
1. **Client Request**: Frontend sends HTTP request to `http://localhost:9000/api/...` with Bearer JWT token.

2. **Gateway Filter**: `JwtAuthenticationFilter` intercepts request:
   - Skips public auth endpoints (`/api/auth/**`).
   - Validates JWT signature and expiration.
   - Extracts email and mutates request headers to add `X-User-Email: <email>`.
   - Routes request to matching downstream microservice.
3. **Downstream Execution**:
   - Downstream service processes request using `X-User-Email` for user scoping.
   - Cross-domain data fetching uses OpenFeign clients with standard DTOs.
