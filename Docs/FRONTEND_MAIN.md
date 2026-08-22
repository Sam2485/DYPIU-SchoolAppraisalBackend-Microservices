# Main Frontend Application Documentation (`DYPIU-SchoolAppraisal`)

This document provides a comprehensive architectural and operational guide to the **Main Faculty & School Appraisal Frontend Application** (`DYPIU-SchoolAppraisal`).

---

## 🌟 Overview & Architecture

The Main Frontend is a React 18 single-page application (SPA) powered by Vite. It serves as the primary web portal for School Directors, Administrative Officers, Vice-Chancellors (VC), IQAC Reviewers, and Auditors to fill, save drafts, upload documentary proofs, submit, review, and export appraisals.

```text
                                  +---------------------------------------+
                                  |         REACT 18 CLIENT APP           |
                                  |       (DYPIU-SchoolAppraisal)         |
                                  +-------------------+-------------------+
                                                      |
                    +---------------------------------+---------------------------------+
                    |                                 |                                 |
                    v                                 v                                 v
        +-----------------------+         +-----------------------+         +-----------------------+
        |   API Service Layer   |         | Dynamic Form Engine   |         | Role-Based Dashboards |
        |  - client.js (Axios)  |         |  - DynamicForm.jsx    |         |  - Director Dashboard |
        |  - auth.js            |         |  - DynamicSection.jsx |         |  - Admin Dashboard    |
        |  - config.js          |         |  - DynamicTable.jsx   |         |  - VC Dashboard       |
        |  - submissions.js     |         |  - DynamicCell.jsx    |         |  - IQAC Dashboard     |
        |  - users.js           |         |  - DynamicField.jsx   |         |  - Auditor Review     |
        +-----------------------+         +-----------------------+         +-----------------------+
                    |
                    v (Vite Dev Proxy: /api, /uploads -> http://localhost:9000)
        +-------------------------------------------------------------------------------------------+
        |                                    SPRING CLOUD GATEWAY                                   |
        +-------------------------------------------------------------------------------------------+
```

---

## 🛠️ Tech Stack & Directory Structure

- **Framework**: React 18 with Vite
- **Routing**: Client-side role-based routing (`appRoutes.jsx`)
- **HTTP Client**: Axios with centralized request/response interceptors, JWT refresh token queue, and correlation tracking
- **Styling**: Bootstrap 5 with responsive custom CSS themes (`index.css`)
- **Exports**: Client-side & server-streamed XLSX and PDF report integrations

### Project Structure:
```text
DYPIU-SchoolAppraisal/
├── package.json                   # Project dependencies & scripts
├── vite.config.js                 # Vite build & dev proxy configuration
├── src/
│   ├── main.jsx                   # React root mount point
│   ├── App.jsx                    # Root routing & authentication context provider
│   ├── index.css                  # Global styles & UI component themes
│   ├── api/                       # API Integration Layer
│   │   ├── client.js              # Centralized Axios client, JWT session & token refresh
│   │   ├── auth.js                # Login, OTP verification, password reset endpoints
│   │   ├── config.js              # Active dynamic schema AST & branding endpoints
│   │   ├── submissions.js         # Draft save/load, submit, review, export endpoints
│   │   └── users.js               # User profile & avatar endpoints
│   ├── features/                  # Domain Features
│   │   └── schoolAppraisal/
│   │       ├── dynamicForm/       # Dynamic Form AST Renderer Engine
│   │       │   ├── DynamicForm.jsx    # Master form container & submit logic
│   │       │   ├── DynamicSection.jsx # Section accordion & tab renderer
│   │       │   ├── DynamicTable.jsx   # Repeatable & fixed table grid renderer
│   │       │   ├── DynamicCell.jsx    # Table cell input & attachment component
│   │       │   └── DynamicField.jsx   # Form field input component
│   │       ├── administrativeAudit/   # Administrative post appraisal components
│   │       ├── reviewDashboard/       # Reviewer scoring, approvals & remarks
│   │       └── userManagement/        # IQAC user management modal & tables
│   ├── pages/                     # Page-Level Views
│   │   ├── auth/                  # Login, OTP challenge, password reset pages
│   │   ├── director/              # Director academic appraisal dashboard
│   │   ├── administrative/        # Administrative office appraisal dashboard
│   │   ├── review/                # Auditor review & scoring page
│   │   └── auditor/               # Auditor assignment view
│   └── routes/
│       └── appRoutes.jsx          # Route definitions & navigation mapping
```

---

## 🧩 Dynamic Form Rendering Engine

The core innovation of the frontend is the **Dynamic Form AST Renderer Engine** (`src/features/schoolAppraisal/dynamicForm/`). It decouples UI presentation from hardcoded forms:

1. **`DynamicForm.jsx`**:
   - Fetches active schema AST from `GET /api/config/active?auditType=...&universityCode=...`.
   - Initializes local form state (`valuesData`, `tablesData`, `attachments`).
   - Automatically populates saved draft data returned from `GET /api/submissions/my-draft`.
   - Handles client-side validation and executes `POST /api/submissions/save-draft` and `POST /api/submissions/submit`.

2. **`DynamicSection.jsx`**:
   - Renders sections dynamically with section numbers, titles, and descriptions.
   - Evaluates section owner role permissions (`director`, `administrative`, `registrar`, etc.).

3. **`DynamicTable.jsx`**:
   - Renders dynamic data grids supporting both fixed rows and dynamic row addition/deletion.
   - Dynamically resolves column types (`TEXT`, `NUMBER`, `DATE`, `SELECT`, `TEXTAREA`, `ATTACHMENT`).

4. **`DynamicCell.jsx` & `DynamicField.jsx`**:
   - Renders appropriate HTML5 input widgets based on backend field metadata.
   - Handles inline document uploads via `POST /api/attachments/upload`.

---

## 🔐 State & Session Management (`client.js`)

- **Dual-Token Handling**: Access tokens are attached as `Authorization: Bearer <token>`. When receiving an HTTP `401 Unauthorized`, an Axios interceptor silently pauses requests, calls `POST /api/auth/refresh`, updates the token, and replays the queue.
- **Tenant Context Preservation**: On login, `universityId` and `universityCode` are stored in `sessionStorage` and `localStorage`, ensuring all dynamic configuration calls are tenant-scoped.
- **Observability**: Automatically generates and attaches `X-Correlation-Id` to all outgoing requests and logs sanitized telemetry in developer console groups.

---

## 🚀 Running the Main Frontend

### Development Mode (with API Gateway Proxy)
```bash
cd DYPIU-SchoolAppraisal-frontend/DYPIU-SchoolAppraisal
npm install
npm run dev
# Starts on http://localhost:5173 with automatic proxying to API Gateway (http://localhost:9000)
```

### Production Build
```bash
npm run build
# Generates optimized production bundle in dist/
```
