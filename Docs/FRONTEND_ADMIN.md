# Admin Form Studio & Schema Management (`formStudio`)

This document provides a comprehensive architectural and operational guide to the **Integrated Admin Form Studio Engine** located in `src/features/schoolAppraisal/formStudio/` within the unified frontend application.

---

## 🎨 Overview & Architecture

The Admin Form Studio is an advanced visual metadata builder integrated directly into the unified React 19 application. It serves as the institutional quality control center, empowering IQAC administrators and super-administrators to manage university schools and posts, design form schemas, configure visual section/table/field layouts, preview dynamic AST rendering in real-time, import schemas from Excel workbooks, publish version freezes, and execute instant rollbacks without touching source code or redeploying microservices.

```text
                                  +---------------------------------------+
                                  |         INTEGRATED FORM STUDIO        |
                                  |     (features/schoolAppraisal/formStudio)
                                  +-------------------+-------------------+
                                                      |
                    +---------------------------------+---------------------------------+
                    |                                 |                                 |
                    v                                 v                                 v
        +-----------------------+         +-----------------------+         +-----------------------+
        |   School & Post Mgmt  |         |     Schema Manager    |         |  Form Builder Canvas  |
        | - SchoolManager.jsx   |         | - SchemaManager.jsx   |         | - FormBuilderCanvas   |
        | - PostManager.jsx     |         | - Version Histories   |         | - Section/Table/Field |
        | - University Tenancy  |         | - Clone, Draft, Roll  |         | - Drag Reorder API    |
        +-----------------------+         +-----------------------+         +-----------------------+
                                                      |
                                                      v
                                          +-----------------------+
                                          |   Live Form Preview   |
                                          | - LiveFormPreview.jsx |
                                          | - Side-by-Side Tester |
                                          +-----------------------+
                                                      |
                                                      v (API Client: /api/admin/config/...)
                                          +-----------------------+
                                          |   SPRING CLOUD GATEWAY|
                                          |   (Port 9000 -> 9002) |
                                          +-----------------------+
```

---

## 🛠️ Tech Stack & Module Components

- **Framework**: React 19.2.6 & React DOM 19.2.6 (Integrated feature module)
- **API Client**: `formStudioApi.js` communicating with `form-data-service` via API Gateway
- **Spreadsheet Processing**: SheetJS (XLSX) 0.18.5 for visual client-side parsing of Excel templates
- **Iconography**: Lucide React 1.47.0 + `StudioIcons.jsx`

### Component Inventory (`src/features/schoolAppraisal/formStudio/`):
* `AppraisalFormStudio.jsx`: Master workspace container with tabbed views for Schemas, Schools, Posts, and Form Builder.
* `FormBuilderCanvas.jsx`: Interactive visual tree editor for Sections, Tables, and Fields with ordering controls.
* `LiveFormPreview.jsx`: Real-time split-screen rendering testing the compiled AST JSON output.
* `SchemaManager.jsx`: Schema listing, version history timeline, draft creation, and rollback buttons.
* `SchoolManager.jsx`: CRUD interface for university schools/departments (`/api/admin/config/universities/{id}/schools`).
* `PostManager.jsx`: CRUD interface for recognized administrative posts (`/api/admin/config/universities/{id}/posts`).
* `ExcelFullSchemaImportModal.jsx`: Modal for importing an entire multi-section audit schema from an Excel workbook (.xlsx).
* `ExcelTableImportModal.jsx`: Modal for batch-importing repeatable tables from an Excel sheet.
* `formStudioApi.js`: Centralized REST client covering all 25+ schema and configuration endpoints.

---

## 🏗️ Core Admin Studio Capabilities

### 1. Schema & Version Lifecycle Management (`SchemaManager.jsx`)
* **Schemas Organization**: Schemas categorized by University and Audit Type (`academic` or `administrative`).
* **Draft Creation**: Invokes `POST /api/admin/config/schemas/{schemaId}/versions/draft`, cloning the active schema into an isolated working DRAFT.
* **Version Rollback**: Invokes `POST /api/admin/config/schemas/{schemaId}/rollback/{targetVersionId}`, instantly reactivating a historical version with zero downtime.

### 2. Visual Form Builder Canvas (`FormBuilderCanvas.jsx`)
* **Section Management**: Create, update, delete, and reorder sections with display numbers, Roman numeral prefixes, and owner roles.
* **Table Management**: Configure repeatable or fixed data grids with custom titles and layout flags.
* **Field & Column Configuration**: Configure fields with 8 dynamic data types:
  - `TEXT` (Single line text inputs)
  - `NUMBER` (Numeric inputs with min/max bounds)
  - `DATE` (Date picker inputs)
  - `SELECT` (Dropdown selects with custom options)
  - `TEXTAREA` (Multi-line text areas with max length limits)
  - `ATTACHMENT` (Document upload dropzones with MIME validation)
  - `EMAIL` & `URL` (Validated contact and link inputs)
* **Reordering API Integration**:
  - `PUT /api/admin/config/versions/{versionId}/reorder-sections`
  - `PUT /api/admin/config/sections/{sectionId}/reorder-tables`
  - `PUT /api/admin/config/tables/{tableId}/reorder-fields`

### 3. Excel Bulk Schema Importer
* Administrators can upload an Excel workbook containing multiple sheets.
* The client-side XLSX parser extracts sheet names as sections and tabular headers as fields, converting raw spreadsheets into structured AST JSON sent to:
  - `POST /api/admin/config/versions/{versionId}/import-full-schema`
  - `POST /api/admin/config/sections/{sectionId}/batch-tables`

### 4. One-Click Version Publishing
* Clicking **Publish Version** calls `POST /api/admin/config/versions/{versionId}/publish`.
* The backend `SchemaCompilerService` validates the relational hierarchy, compiles it into an optimized AST JSON string, saves it to `schema_versions.compiled_schema`, and sets `form_schemas.active_version_id`.
* All subsequent contributor requests (`GET /api/config/active`) immediately receive the updated form structure in $O(1)$ time (<8ms).
