# Main Frontend Application Documentation (`DYPIU-SchoolAppraisal`)

This document provides a comprehensive architectural and operational guide to the **Main Faculty & School Appraisal Frontend Application** (`DYPIU-SchoolAppraisal`).

---

## 🌟 Overview & Architecture

The Main Frontend is a modern single-page application (SPA) built with **React 19.2.6** and powered by **Vite 8.0.12**. It serves as the unified institutional portal for School Directors, Administrative Officers, Vice-Chancellors (VC), IQAC Reviewers, and Auditors to fill, save drafts, upload documentary proofs, submit, review, and export appraisals.

```text
                                  +---------------------------------------+
                                  |         REACT 19 CLIENT APP           |
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
                    v (Nginx Reverse Proxy: /api, /uploads -> Gateway http://10.100.0.23:9000)
        +-------------------------------------------------------------------------------------------+
        |                                    SPRING CLOUD GATEWAY                                   |
        +-------------------------------------------------------------------------------------------+
```

---

## 🛠️ Tech Stack & Directory Structure

- **Framework**: React 19.2.6 & React DOM 19.2.6
- **Build Tool**: Vite 8.0.12 with `@vitejs/plugin-react` 6.0.1
- **Routing**: React Router DOM 7.18.0 with `ProtectedRoute` guards and history boundary controls
- **Form Management**: React Hook Form 7.79.0 for high-performance uncontrolled tabular inputs
- **HTTP Client**: Axios 1.18.0 with request/response interceptors, correlation ID generation, and silent JWT refresh queue
- **Spreadsheet Processing**: SheetJS (XLSX) 0.18.5 for client-side Excel schema imports and table data export
- **Iconography**: Lucide React 1.47.0
- **Typography & Styling**: `@fontsource/inter` 5.3.0 and CSS custom properties design tokens (`index.css`)
- **Port Allocation**: Development: Port `5173`; Production Docker: Port `3003` (mapped to container port 8080)

### Project Structure:
```text
DYPIU-SchoolAppraisal/
├── package.json                   # Verified dependencies (React 19.2, Vite 8.0, Axios, Router 7)
├── vite.config.js                 # Vite build & proxy configuration
├── deploy/                        # Production Docker & Nginx templates
│   ├── default.conf.template      # Nginx reverse proxy configuration
│   ├── env-config.template.js     # Runtime environment variable injection
│   └── 40-env-config.sh           # Container startup environment script
├── src/
│   ├── main.jsx                   # React root mount point
│   ├── App.jsx                    # Root routing, session restore & ProtectedRoute guards
│   ├── index.css                  # Global styles, design tokens & UI themes
│   ├── api/                       # API Integration Layer
│   │   ├── client.js              # Centralized Axios client, JWT session & silent refresh queue
│   │   ├── auth.js                # Login, OTP verification, password reset endpoints
│   │   ├── config.js              # Active dynamic schema AST & branding endpoints
│   │   ├── submissions.js         # Draft save/load, submit, review, export endpoints
│   │   └── users.js               # User directory, profile & avatar endpoints
│   ├── features/                  # Domain Features
│   │   └── schoolAppraisal/
│   │       ├── dynamicForm/       # Dynamic Form AST Renderer Engine
│   │       │   ├── DynamicForm.jsx    # Master form container & submit logic
│   │       │   ├── DynamicSection.jsx # Section accordion & tab renderer
│   │       │   ├── DynamicTable.jsx   # Repeatable & fixed table grid renderer
│   │       │   ├── DynamicCell.jsx    # Context-aware table cell input & file uploader
│   │       │   └── DynamicField.jsx   # Top-level scalar input component
│   │       ├── formStudio/        # Integrated Admin Form Studio & Builder Canvas
│   │       ├── administrativeAudit/ # Administrative post composite appraisal views
│   │       ├── reviewDashboard/   # Reviewer scoring, approvals, backup/restore panel
│   │       └── userManagement/    # University user directory management
│   ├── pages/                     # Page-Level Views
│   │   ├── auth/                  # Login and password reset pages
│   │   ├── director/              # Director academic appraisal dashboard
│   │   ├── administrative/        # Administrative office appraisal dashboard
│   │   ├── review/                # Executive IQAC / VC review & Form Studio page
│   │   └── auditor/               # Auditor assignment & scoring dashboard
│   └── routes/
│       └── appRoutes.jsx          # Route definitions & navigation mapping
```

---

## 🧩 Dynamic Form Rendering Engine

The core innovation of the frontend is the **Dynamic Form AST Renderer Engine** (`src/features/schoolAppraisal/dynamicForm/`), which renders forms entirely from the backend compiled AST without hardcoded form components:

1. **`DynamicForm.jsx`**:
   - Fetches active schema AST from `GET /api/config/active?auditType=academic`.
   - Initializes local form state (`valuesData`, `tablesData`, `attachments`).
   - Automatically populates saved draft data returned from `GET /api/submissions/my-draft`.
   - Handles client-side validation and executes `POST /api/submissions/save-draft` and `POST /api/submissions/submit`.

2. **`DynamicSection.jsx`**:
   - Renders sections dynamically with section numbers, titles, and descriptions.
   - Evaluates section owner role permissions (`director`, `administrative`, `registrar`, etc.).

3. **`DynamicTable.jsx`**:
   - Renders dynamic data grids supporting both fixed rows and dynamic row addition/deletion.
   - Dynamically resolves column types (`TEXT`, `NUMBER`, `DATE`, `SELECT`, `TEXTAREA`, `ATTACHMENT`).

4. **`DynamicCell.jsx`**:
   - Context-aware table cell renderer supporting text input, numeric masks, date selectors, select dropdowns, and file upload dropzones with progress indicators.
