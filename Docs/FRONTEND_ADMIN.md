# Admin Form Studio Frontend Documentation (`DYPIU-SchoolAppraisal-admin`)

This document provides a comprehensive architectural and operational guide to the **Admin Form Studio Application** (`DYPIU-SchoolAppraisal-admin`).

---

## 🎨 Overview & Architecture

The Admin Form Studio is a React 18 single-page application (SPA) powered by Vite that serves as the administrative control center for university appraisal forms. It empowers administrators to manage university tenants, create form schemas, design visual section/table/field layouts, test forms in real-time, publish version freezes, and execute instant rollbacks without touching source code or redeploying microservices.

```text
                                  +---------------------------------------+
                                  |         REACT 18 ADMIN STUDIO         |
                                  |      (DYPIU-SchoolAppraisal-admin)    |
                                  +-------------------+-------------------+
                                                      |
                    +---------------------------------+---------------------------------+
                    |                                 |                                 |
                    v                                 v                                 v
        +-----------------------+         +-----------------------+         +-----------------------+
        |   University Manager  |         |     Schema Manager    |         |  Form Builder Canvas  |
        | - Create / Edit Unis  |         | - Schemas by Tenant   |         | - Section CRUD/Order  |
        | - Domain & Branding   |         | - Version Histories   |         | - Table CRUD/Order    |
        | - Colors & Logos      |         | - Draft & Rollbacks   |         | - Field CRUD/Order    |
        +-----------------------+         +-----------------------+         +-----------------------+
                                                      |
                                                      v
                                          +-----------------------+
                                          |   Live Form Preview   |
                                          | - Interactive Preview |
                                          | - Instant Verification|
                                          +-----------------------+
                                                      |
                                                      v (Proxy: /api -> http://localhost:9000)
                                          +-----------------------+
                                          |   SPRING CLOUD GATEWAY|
                                          +-----------------------+
```

---

## 🛠️ Tech Stack & Directory Structure

- **Framework**: React 18 with Vite
- **HTTP Client**: Axios with centralized correlation tracking (`X-Correlation-Id`) and error interceptors
- **Styling**: Bootstrap 5 with custom studio styling (`index.css`)
- **Port**: Configured on Port `3005` (with dev proxy forwarding `/api` to Gateway at `http://localhost:9000`)

### Project Structure:
```text
DYPIU-SchoolAppraisal-admin/
├── package.json                   # Project dependencies & scripts
├── vite.config.js                 # Vite dev proxy configuration (port 3005)
├── src/
│   ├── main.jsx                   # React application root
│   ├── App.jsx                    # Master state, university selector & tab navigation
│   ├── index.css                  # Studio styles & builder theme
│   ├── api/
│   │   └── adminApi.js            # Admin CRUD, versioning, reordering & publish APIs
│   └── components/
│       ├── Navbar.jsx             # Top studio navigation & university dropdown
│       ├── UniversityManager.jsx  # Multi-university tenant CRUD & branding editor
│       ├── SchemaManager.jsx      # Form schemas list, version timeline & rollback
│       ├── FormBuilderCanvas.jsx  # Visual section, table & column builder canvas
│       └── LiveFormPreview.jsx    # Real-time interactive dynamic form tester
```

---

## 🏗️ Core Admin Studio Capabilities

### 1. Multi-University Tenant Management (`UniversityManager.jsx`)
- Create new university tenants with code, name, domain, establishment act, and campus address.
- Customize university branding (primary colors, main logo URL, IQAC logo URL).
- Isolate form definitions so each tenant has independently configurable appraisals.

### 2. Schema & Version Lifecycle Management (`SchemaManager.jsx`)
- Organizes schemas by University and Audit Type (`academic`, `administrative`).
- **Draft Creation**: Creates a cloned, isolated draft version without mutating the currently active production schema.
- **Version Rollback**: Instantly points the active version pointer to any historical published version with zero downtime.

### 3. Visual Form Builder Canvas (`FormBuilderCanvas.jsx`)
- **Section Management**: Add, edit, delete, and reorder form sections with custom display orders, Roman numeral prefixes, and owner roles.
- **Table Management**: Create repeatable or single-row tables with customizable headers and layout options.
- **Field & Column Management**: Configure fields with 8 dynamic data types:
  - `TEXT` (Single line text inputs)
  - `NUMBER` (Numeric inputs with min/max validation)
  - `DATE` (Date picker inputs)
  - `SELECT` (Dropdown selects with customizable option lists)
  - `TEXTAREA` (Multi-line text areas with max length bounds)
  - `ATTACHMENT` (Document upload dropzones with MIME validation)
  - `EMAIL` & `URL` (Validated contact and link inputs)
- **Reordering API Integration**: Drag-and-drop or order updates are persisted directly to backend endpoints:
  - `PUT /api/admin/config/versions/{versionId}/reorder-sections`
  - `PUT /api/admin/config/sections/{sectionId}/reorder-tables`
  - `PUT /api/admin/config/tables/{tableId}/reorder-fields`

### 4. One-Click Version Publishing
- Clicking **Publish Version** invokes `POST /api/admin/config/versions/{versionId}/publish`.
- The backend compiles the complete relational hierarchy into an optimized AST JSON string, saves it to `schema_versions.compiled_schema`, and sets `form_schemas.active_version_id`.
- The Main Frontend (`DYPIU-SchoolAppraisal`) immediately renders the new schema on its next fetch without code redeployment.

### 5. Live Form Preview (`LiveFormPreview.jsx`)
- Administrators can test the complete form workflow in real-time inside the studio before publishing to ensure columns, validations, and tables display correctly.

---

## 🚀 Running the Admin Form Studio

### Development Mode
```bash
cd DYPIU-SchoolAppraisal-admin
npm install
npm run dev
# Starts on http://localhost:3005 with automatic proxying to API Gateway (http://localhost:9000)
```

### Production Build
```bash
npm run build
# Generates production bundle in dist/
```
