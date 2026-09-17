package com.director_appraisal.submission_service.service;

import com.director_appraisal.submission_service.client.AuthUserClient;
import com.director_appraisal.submission_service.client.FormDataClient;
import com.director_appraisal.submission_service.dto.UserDto;
import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.model.SubmissionAuditorAssignment;
import com.director_appraisal.submission_service.repository.SubmissionAuditorAssignmentRepository;
import com.director_appraisal.submission_service.util.SchoolUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.*;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReportExportService {

    private final FormDataClient formDataClient;
    private final AuthUserClient authUserClient;
    private final SubmissionAuditorAssignmentRepository auditorAssignmentRepository;
    private final ObjectMapper objectMapper = new ObjectMapper();

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    private static final DateTimeFormatter DATE_ONLY_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    // Colors matching the frontend report theme
    private static final Color COLOR_PRIMARY = new Color(0x1E, 0x29, 0x3B);     // #1e293b Slate 800
    private static final Color COLOR_SECONDARY = new Color(0x33, 0x41, 0x55);   // #334155 Slate 700
    private static final Color COLOR_SECTION_BG = new Color(0x1E, 0x3A, 0x8A);  // #1e3a8a Dark Blue
    private static final Color COLOR_HEADER_BG = new Color(0xF1, 0xF5, 0xF9);   // #f1f5f9 Light Slate
    private static final Color COLOR_ROW_ALT = new Color(0xF8, 0xFA, 0xFC);     // #f8fafc Very Light Gray
    private static final Color COLOR_BORDER = new Color(0xCB, 0xD5, 0xE1);      // #cbd5e1 Border
    private static final Color COLOR_TEXT = new Color(0x0F, 0x17, 0x2A);        // #0f172a Text
    private static final Color COLOR_MUTED = new Color(0x64, 0x74, 0x8B);       // #64748b Muted
    private static final Color COLOR_INTERNAL_AUDITOR = new Color(0x0D, 0x94, 0x88); // #0d9488 Teal
    private static final Color COLOR_EXTERNAL_AUDITOR = new Color(0x7C, 0x3A, 0xED); // #7c3aed Purple
    private static final Color COLOR_NOTE_BG = new Color(0xFE, 0xF9, 0xC3);     // #fef9c3 Yellow note

    // =========================================================================
    // 1. PDF GENERATION
    // =========================================================================

    public void generatePdfReport(Submission submission, HttpServletResponse response) throws Exception {
        Map<String, Object> schema = loadSchema(submission);
        Map<String, Object> values = parseJsonMap(submission.getValuesData());
        Map<String, Object> tables = parseJsonMap(submission.getTablesData());
        List<SubmissionAuditorAssignment> auditorAssignments = auditorAssignmentRepository != null
                ? auditorAssignmentRepository.findBySubmissionId(submission.getId())
                : List.of();

        Document document = new Document(PageSize.A4, 28, 28, 42, 42);
        OutputStream out = response.getOutputStream();
        PdfWriter writer = PdfWriter.getInstance(document, out);

        String universityName = resolveUniversityName(submission, schema);
        String reportTitle = resolveReportTitle(submission, schema);
        writer.setPageEvent(new PdfPageHeaderFooter(universityName, reportTitle));

        document.open();

        // 1. Cover Header Block
        addCoverHeader(document, submission, schema, universityName, reportTitle);

        // 2. Sections / Modules Loop
        List<Map<String, Object>> sections = extractSections(schema, tables, values);
        int sectionIndex = 1;
        for (Map<String, Object> section : sections) {
            addSection(document, section, sectionIndex, values, tables, submission);
            sectionIndex++;
        }

        // 3. Auditor Observations & Evaluations
        if (auditorAssignments != null && !auditorAssignments.isEmpty()) {
            addAuditorReviews(document, auditorAssignments, schema);
        }

        // 4. Official Sign-Off Block
        addSignOffBlock(document, submission, values);

        document.close();
        out.flush();
    }

    private void addCoverHeader(Document doc, Submission submission, Map<String, Object> schema,
                                String universityName, String reportTitle) throws DocumentException {
        PdfPTable cover = new PdfPTable(1);
        cover.setWidthPercentage(100);
        cover.setSpacingAfter(14);

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(new Color(0xFA, 0xFA, 0xFA));
        cell.setBorderColor(COLOR_BORDER);
        cell.setBorderWidth(1.2f);
        cell.setPadding(12);

        // University Name
        com.lowagie.text.Font uniFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, COLOR_PRIMARY);
        Paragraph pUni = new Paragraph(universityName.toUpperCase(), uniFont);
        pUni.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(pUni);

        // Report Title
        com.lowagie.text.Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, COLOR_SECTION_BG);
        Paragraph pTitle = new Paragraph(reportTitle, titleFont);
        pTitle.setAlignment(Element.ALIGN_CENTER);
        pTitle.setSpacingBefore(4);
        cell.addElement(pTitle);

        // Address & Act
        Map<String, Object> headerMap = safeMap(schema != null ? schema.get("header") : null);
        String address = headerMap.get("address") != null ? headerMap.get("address").toString() : "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044";
        String act = headerMap.get("act") != null ? headerMap.get("act").toString() : "(Established under Maharashtra Private Universities Act No. VI of 2019)";

        com.lowagie.text.Font metaFont = FontFactory.getFont(FontFactory.HELVETICA, 8, COLOR_MUTED);
        Paragraph pMeta = new Paragraph(address + " | " + act, metaFont);
        pMeta.setAlignment(Element.ALIGN_CENTER);
        pMeta.setSpacingBefore(2);
        cell.addElement(pMeta);

        // Academic Year & Metadata Line
        String cycle = submission.getAuditCycle() != null ? submission.getAuditCycle() : submission.getAcademicYear();
        com.lowagie.text.Font yearFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9.5f, COLOR_PRIMARY);
        Paragraph pYear = new Paragraph("Academic Year " + (cycle != null ? cycle : "2026-2027"), yearFont);
        pYear.setAlignment(Element.ALIGN_CENTER);
        pYear.setSpacingBefore(4);
        cell.addElement(pYear);

        cover.addCell(cell);
        doc.add(cover);

        // Key Metadata Table (Entity, Submitter, Status, Date)
        PdfPTable metaTable = new PdfPTable(4);
        metaTable.setWidthPercentage(100);
        metaTable.setSpacingAfter(14);
        try {
            metaTable.setWidths(new float[]{18f, 32f, 18f, 32f});
        } catch (Exception ignored) {}

        String entityLabel = "academic".equalsIgnoreCase(submission.getAuditType()) ? "School:" : "Administrative Office:";
        String entityVal = "academic".equalsIgnoreCase(submission.getAuditType())
                ? (submission.getSchool() != null ? SchoolUtils.canonicalizeSchool(submission.getSchool()) : "School")
                : (submission.getAdministrativePost() != null ? submission.getAdministrativePost() : "Administrative Office");

        String submitterName = submission.getSubmittedBy() != null ? submission.getSubmittedBy() : submission.getEmail();
        String statusVal = submission.getStatus() != null ? submission.getStatus().replace('_', ' ') : "SUBMITTED";
        String dateVal = submission.getSubmittedAt() != null
                ? submission.getSubmittedAt().format(DATE_FORMATTER)
                : LocalDateTime.now().format(DATE_FORMATTER);

        addMetaCell(metaTable, entityLabel, true);
        addMetaCell(metaTable, entityVal, false);
        addMetaCell(metaTable, "Audit Cycle:", true);
        addMetaCell(metaTable, (cycle != null ? cycle : "-"), false);

        addMetaCell(metaTable, "Submitted By:", true);
        addMetaCell(metaTable, submitterName, false);
        addMetaCell(metaTable, "Status:", true);
        addMetaCell(metaTable, statusVal, false);

        addMetaCell(metaTable, "Audit Type:", true);
        addMetaCell(metaTable, capitalize(submission.getAuditType()), false);
        addMetaCell(metaTable, "Report Date:", true);
        addMetaCell(metaTable, dateVal, false);

        doc.add(metaTable);
    }

    private void addSection(Document doc, Map<String, Object> section, int sectionIndex,
                            Map<String, Object> values, Map<String, Object> tables,
                            Submission submission) throws DocumentException {
        String secNumber = section.get("number") != null ? section.get("number").toString() : String.valueOf(sectionIndex);
        String secTitle = section.get("title") != null ? section.get("title").toString() : "Section " + sectionIndex;

        // Section Heading Banner
        PdfPTable headingTable = new PdfPTable(1);
        headingTable.setWidthPercentage(100);
        headingTable.setSpacingBefore(10);
        headingTable.setSpacingAfter(6);

        PdfPCell hCell = new PdfPCell();
        hCell.setBackgroundColor(COLOR_SECTION_BG);
        hCell.setPadding(6);
        hCell.setBorder(com.lowagie.text.Rectangle.NO_BORDER);

        com.lowagie.text.Font hFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10.5f, Color.WHITE);
        Paragraph pHeading = new Paragraph("PART " + secNumber.toUpperCase() + ": " + secTitle.toUpperCase(), hFont);
        hCell.addElement(pHeading);
        headingTable.addCell(hCell);
        doc.add(headingTable);

        // Section Note / Description if present
        String desc = section.get("description") != null ? section.get("description").toString() : (section.get("note") != null ? section.get("note").toString() : null);
        if (desc != null && !desc.isBlank()) {
            Paragraph pDesc = new Paragraph(desc, FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 8.5f, COLOR_MUTED));
            pDesc.setSpacingAfter(6);
            doc.add(pDesc);
        }

        // Section Scalar Fields
        List<Map<String, Object>> fields = safeListOfMaps(section.get("fields"));
        if (fields != null && !fields.isEmpty()) {
            List<Map<String, Object>> displayFields = new ArrayList<>();
            for (Map<String, Object> f : fields) {
                String kind = f.get("kind") != null ? f.get("kind").toString() : "";
                if (!"review".equalsIgnoreCase(kind)) {
                    displayFields.add(f);
                }
            }
            if (!displayFields.isEmpty()) {
                addFieldsTable(doc, displayFields, values);
            }
        }

        // Section Tables
        List<Map<String, Object>> secTables = safeListOfMaps(section.get("tables"));
        if (secTables != null) {
            for (Map<String, Object> tbl : secTables) {
                addTableBlock(doc, tbl, section, tables, submission);
            }
        }
    }

    private void addFieldsTable(Document doc, List<Map<String, Object>> fields, Map<String, Object> values) throws DocumentException {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingAfter(8);
        try {
            table.setWidths(new float[]{38f, 62f});
        } catch (Exception ignored) {}

        com.lowagie.text.Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 8.5f, COLOR_PRIMARY);
        com.lowagie.text.Font valFont = FontFactory.getFont(FontFactory.HELVETICA, 8.5f, COLOR_TEXT);

        for (Map<String, Object> field : fields) {
            String label = field.get("label") != null ? field.get("label").toString() : "Field";
            String key = field.get("fieldKey") != null ? field.get("fieldKey").toString() : (field.get("id") != null ? field.get("id").toString() : label);
            Object rawVal = resolveFieldValue(key, label, values);
            String valStr = formatValue(rawVal);

            PdfPCell lCell = new PdfPCell(new Phrase(label, labelFont));
            lCell.setBackgroundColor(COLOR_HEADER_BG);
            lCell.setBorderColor(COLOR_BORDER);
            lCell.setPadding(4.5f);
            table.addCell(lCell);

            PdfPCell vCell = new PdfPCell(new Phrase(valStr, valFont));
            vCell.setBackgroundColor(Color.WHITE);
            vCell.setBorderColor(COLOR_BORDER);
            vCell.setPadding(4.5f);
            table.addCell(vCell);
        }
        doc.add(table);
    }

    private void addTableBlock(Document doc, Map<String, Object> tbl, Map<String, Object> section,
                               Map<String, Object> tablesData, Submission submission) throws DocumentException {
        String tableTitle = tbl.get("title") != null ? tbl.get("title").toString() : (tbl.get("name") != null ? tbl.get("name").toString() : "Table");
        String tableKey = tbl.get("tableKey") != null ? tbl.get("tableKey").toString() : (tbl.get("id") != null ? tbl.get("id").toString() : tableTitle);

        // Check if this table has dynamic button groups / instances (e.g. SOEMR, SOCE)
        Map<String, List<Map<String, Object>>> instancesMap = findTableRowsAcrossInstances(tableKey, tbl, section, tablesData);

        if (instancesMap.isEmpty()) {
            // Render standard single instance table
            List<Map<String, Object>> rows = resolveTableRows(tableKey, tbl, tablesData);
            renderDataTable(doc, tableTitle, tbl, rows);
        } else {
            // Render table for each instance
            for (Map.Entry<String, List<Map<String, Object>>> entry : instancesMap.entrySet()) {
                String instanceName = entry.getKey();
                List<Map<String, Object>> rows = entry.getValue();
                String titleWithInstance = tableTitle + (instanceName.isBlank() ? "" : " (" + instanceName + ")");
                renderDataTable(doc, titleWithInstance, tbl, rows);
            }
        }
    }

    private void renderDataTable(Document doc, String title, Map<String, Object> tblDef, List<Map<String, Object>> rows) throws DocumentException {
        // Table Sub-Heading
        com.lowagie.text.Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9.5f, COLOR_PRIMARY);
        Paragraph pTitle = new Paragraph(title, titleFont);
        pTitle.setSpacingBefore(6);
        pTitle.setSpacingAfter(4);
        doc.add(pTitle);

        List<String> columnLabels = extractColumnLabels(tblDef, rows);
        if (columnLabels.isEmpty()) {
            columnLabels = List.of("Details");
        }

        int colCount = columnLabels.size() + 1; // +1 for S.No
        PdfPTable pdfTable = new PdfPTable(colCount);
        pdfTable.setWidthPercentage(100);
        pdfTable.setSpacingAfter(10);
        pdfTable.setHeaderRows(1);

        // Set column widths (narrow S.No, remaining evenly distributed)
        float[] widths = new float[colCount];
        widths[0] = 7f; // S.No
        float rem = 93f / (colCount - 1);
        for (int i = 1; i < colCount; i++) {
            widths[i] = rem;
        }
        try {
            pdfTable.setWidths(widths);
        } catch (Exception ignored) {}

        // 1. Header Row
        com.lowagie.text.Font thFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 8f, COLOR_PRIMARY);
        PdfPCell snoHeader = new PdfPCell(new Phrase("S.No", thFont));
        snoHeader.setBackgroundColor(COLOR_HEADER_BG);
        snoHeader.setBorderColor(COLOR_BORDER);
        snoHeader.setHorizontalAlignment(Element.ALIGN_CENTER);
        snoHeader.setPadding(4.5f);
        pdfTable.addCell(snoHeader);

        for (String col : columnLabels) {
            PdfPCell thCell = new PdfPCell(new Phrase(col, thFont));
            thCell.setBackgroundColor(COLOR_HEADER_BG);
            thCell.setBorderColor(COLOR_BORDER);
            thCell.setHorizontalAlignment(Element.ALIGN_LEFT);
            thCell.setPadding(4.5f);
            pdfTable.addCell(thCell);
        }

        // 2. Data Rows
        com.lowagie.text.Font tdFont = FontFactory.getFont(FontFactory.HELVETICA, 7.5f, COLOR_TEXT);
        if (rows == null || rows.isEmpty()) {
            PdfPCell emptyCell = new PdfPCell(new Phrase("No data recorded for this table.", FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 7.5f, COLOR_MUTED)));
            emptyCell.setColspan(colCount);
            emptyCell.setPadding(6);
            emptyCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            emptyCell.setBorderColor(COLOR_BORDER);
            pdfTable.addCell(emptyCell);
        } else {
            int rowIndex = 1;
            for (Map<String, Object> row : rows) {
                Color rowBg = (rowIndex % 2 == 0) ? COLOR_ROW_ALT : Color.WHITE;

                // S.No Cell
                PdfPCell snoCell = new PdfPCell(new Phrase(String.valueOf(rowIndex), tdFont));
                snoCell.setBackgroundColor(rowBg);
                snoCell.setBorderColor(COLOR_BORDER);
                snoCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                snoCell.setPadding(4);
                pdfTable.addCell(snoCell);

                // Data Cells
                for (String col : columnLabels) {
                    Object cellVal = resolveCellFromRow(row, col, tblDef);
                    String displayVal = formatValue(cellVal);

                    PdfPCell tdCell = new PdfPCell(new Phrase(displayVal, tdFont));
                    tdCell.setBackgroundColor(rowBg);
                    tdCell.setBorderColor(COLOR_BORDER);
                    tdCell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    tdCell.setPadding(4);
                    pdfTable.addCell(tdCell);
                }
                rowIndex++;
            }
        }
        doc.add(pdfTable);
    }

    private void addAuditorReviews(Document doc, List<SubmissionAuditorAssignment> assignments, Map<String, Object> schema) throws DocumentException {
        // Section Heading
        PdfPTable headingTable = new PdfPTable(1);
        headingTable.setWidthPercentage(100);
        headingTable.setSpacingBefore(12);
        headingTable.setSpacingAfter(8);

        PdfPCell hCell = new PdfPCell();
        hCell.setBackgroundColor(COLOR_PRIMARY);
        hCell.setPadding(6);
        hCell.setBorder(com.lowagie.text.Rectangle.NO_BORDER);

        com.lowagie.text.Font hFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10.5f, Color.WHITE);
        Paragraph pHeading = new Paragraph("AUDITOR REVIEWS & EVALUATION", hFont);
        hCell.addElement(pHeading);
        headingTable.addCell(hCell);
        doc.add(headingTable);

        for (SubmissionAuditorAssignment a : assignments) {
            boolean isExternal = "external".equalsIgnoreCase(a.getAuditorType());
            Color badgeBg = isExternal ? COLOR_EXTERNAL_AUDITOR : COLOR_INTERNAL_AUDITOR;
            String auditorTypeLabel = isExternal ? "EXTERNAL AUDITOR EVALUATION" : "INTERNAL AUDITOR EVALUATION";

            PdfPTable card = new PdfPTable(1);
            card.setWidthPercentage(100);
            card.setSpacingAfter(10);

            PdfPCell cCell = new PdfPCell();
            cCell.setBorderColor(COLOR_BORDER);
            cCell.setPadding(8);
            cCell.setBackgroundColor(new Color(0xFB, 0xFB, 0xFC));

            // Auditor Header
            com.lowagie.text.Font bFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9.5f, badgeBg);
            cCell.addElement(new Paragraph(auditorTypeLabel + " — " + (a.getAuditorName() != null ? a.getAuditorName() : "Auditor"), bFont));

            // Auditor Metadata
            String metaInfo = "Email: " + (a.getAuditorEmail() != null ? a.getAuditorEmail() : "-")
                    + " | Status: " + (a.getStatus() != null ? a.getStatus() : "SUBMITTED")
                    + " | Date: " + (a.getSubmittedAt() != null ? a.getSubmittedAt().format(DATE_FORMATTER) : "-");
            if (a.getPost() != null && !a.getPost().isBlank()) {
                metaInfo += " | Assigned Post/School: " + a.getPost();
            }
            cCell.addElement(new Paragraph(metaInfo, FontFactory.getFont(FontFactory.HELVETICA, 8, COLOR_MUTED)));

            // Remarks / Observations
            Map<String, Object> aValues = parseJsonMap(a.getValuesData());
            String remarks = extractAuditorRemarks(a, aValues);
            if (remarks != null && !remarks.isBlank()) {
                Paragraph pRem = new Paragraph("Observations / Remarks:\n" + remarks, FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 8.5f, COLOR_TEXT));
                pRem.setSpacingBefore(4);
                cCell.addElement(pRem);
            }

            card.addCell(cCell);
            doc.add(card);

            // Auditor Tables if filled
            Map<String, Object> aTables = parseJsonMap(a.getTablesData());
            if (aTables != null && !aTables.isEmpty()) {
                for (Map.Entry<String, Object> entry : aTables.entrySet()) {
                    List<Map<String, Object>> rows = safeListOfMaps(entry.getValue());
                    if (rows != null && !rows.isEmpty()) {
                        String tTitle = "Auditor Table: " + entry.getKey().replaceAll("[^a-zA-Z0-9_-]", " ");
                        renderDataTable(doc, tTitle, Collections.emptyMap(), rows);
                    }
                }
            }
        }
    }

    private void addSignOffBlock(Document doc, Submission submission, Map<String, Object> values) throws DocumentException {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(14);
        table.setSpacingAfter(10);
        try {
            table.setWidths(new float[]{50f, 50f});
        } catch (Exception ignored) {}

        // Submitter Box
        PdfPCell submitterCell = new PdfPCell();
        submitterCell.setBorderColor(COLOR_BORDER);
        submitterCell.setPadding(8);
        submitterCell.setBackgroundColor(new Color(0xF8, 0xFA, 0xFC));

        com.lowagie.text.Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9.5f, COLOR_PRIMARY);
        com.lowagie.text.Font infoFont = FontFactory.getFont(FontFactory.HELVETICA, 8.5f, COLOR_TEXT);

        submitterCell.addElement(new Paragraph("SUBMITTER SIGN-OFF", titleFont));
        Map<String, Object> signOffMap = safeMap(values.get("__auditSignOff"));
        Map<String, Object> subMap = safeMap(signOffMap.get("submittedBy"));

        String subName = subMap.get("name") != null ? subMap.get("name").toString() : (submission.getSubmittedBy() != null ? submission.getSubmittedBy() : submission.getEmail());
        String subDesig = subMap.get("designation") != null ? subMap.get("designation").toString() : "Director / Office Head";
        String subDate = subMap.get("date") != null ? subMap.get("date").toString() : (submission.getSubmittedAt() != null ? submission.getSubmittedAt().format(DATE_FORMATTER) : "-");

        submitterCell.addElement(new Paragraph("Name: " + subName, infoFont));
        submitterCell.addElement(new Paragraph("Designation: " + subDesig, infoFont));
        submitterCell.addElement(new Paragraph("Date: " + subDate, infoFont));
        table.addCell(submitterCell);

        // Approver / Reviewer Box
        PdfPCell approverCell = new PdfPCell();
        approverCell.setBorderColor(COLOR_BORDER);
        approverCell.setPadding(8);
        approverCell.setBackgroundColor(new Color(0xF8, 0xFA, 0xFC));

        approverCell.addElement(new Paragraph("REVIEW & APPROVAL SIGN-OFF", titleFont));
        Map<String, Object> appMap = safeMap(signOffMap.get("approvedBy"));

        String appName = appMap.get("name") != null ? appMap.get("name").toString() : (submission.getApprovedByName() != null ? submission.getApprovedByName() : (submission.getReviewedBy() != null ? submission.getReviewedBy() : "Vice-Chancellor / IQAC Coordinator"));
        String appDesig = appMap.get("designation") != null ? appMap.get("designation").toString() : (submission.getApprovedByDesignation() != null ? submission.getApprovedByDesignation() : "IQAC / Vice-Chancellor");
        String appDate = appMap.get("date") != null ? appMap.get("date").toString() : (submission.getApprovedAt() != null ? submission.getApprovedAt().format(DATE_FORMATTER) : "-");

        approverCell.addElement(new Paragraph("Name: " + appName, infoFont));
        approverCell.addElement(new Paragraph("Designation: " + appDesig, infoFont));
        approverCell.addElement(new Paragraph("Approval Date: " + appDate, infoFont));
        if (submission.getRemarks() != null && !submission.getRemarks().isBlank()) {
            approverCell.addElement(new Paragraph("Remarks: " + submission.getRemarks(), FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 8, COLOR_MUTED)));
        }
        table.addCell(approverCell);

        doc.add(table);
    }

    // =========================================================================
    // 2. EXCEL GENERATION (.xlsx)
    // =========================================================================

    public void generateExcelReport(Submission submission, HttpServletResponse response) throws Exception {
        Map<String, Object> schema = loadSchema(submission);
        Map<String, Object> values = parseJsonMap(submission.getValuesData());
        Map<String, Object> tables = parseJsonMap(submission.getTablesData());
        List<SubmissionAuditorAssignment> auditorAssignments = auditorAssignmentRepository != null
                ? auditorAssignmentRepository.findBySubmissionId(submission.getId())
                : List.of();

        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            // Style setup
            XSSFCellStyle headerStyle = createHeaderStyle(workbook);
            XSSFCellStyle subHeaderStyle = createSubHeaderStyle(workbook);
            XSSFCellStyle titleStyle = createTitleStyle(workbook);
            XSSFCellStyle dataStyle = createDataStyle(workbook);
            XSSFCellStyle altDataStyle = createAltDataStyle(workbook);

            // Sheet 1: Overview & Sign-Offs
            XSSFSheet overviewSheet = workbook.createSheet("Summary");
            createOverviewSheet(overviewSheet, submission, schema, values, titleStyle, headerStyle, dataStyle);

            // Sheets 2..N: Dynamic Sections & Parts
            List<Map<String, Object>> sections = extractSections(schema, tables, values);
            int secIdx = 1;
            for (Map<String, Object> sec : sections) {
                String secTitle = sec.get("title") != null ? sec.get("title").toString() : "Part " + secIdx;
                String sheetName = sanitizeSheetName("Part " + secIdx + " - " + secTitle);
                XSSFSheet secSheet = workbook.createSheet(sheetName);
                populateSectionSheet(secSheet, sec, values, tables, submission, headerStyle, subHeaderStyle, dataStyle, altDataStyle);
                secIdx++;
            }

            // Sheet: Auditor Reviews
            if (auditorAssignments != null && !auditorAssignments.isEmpty()) {
                XSSFSheet audSheet = workbook.createSheet("Auditor Reviews");
                populateAuditorSheet(audSheet, auditorAssignments, headerStyle, subHeaderStyle, dataStyle, altDataStyle);
            }

            OutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
        }
    }

    private void createOverviewSheet(XSSFSheet sheet, Submission submission, Map<String, Object> schema,
                                     Map<String, Object> values, XSSFCellStyle titleStyle,
                                     XSSFCellStyle headerStyle, XSSFCellStyle dataStyle) {
        int r = 0;
        Row rowTitle = sheet.createRow(r++);
        Cell cTitle = rowTitle.createCell(0);
        cTitle.setCellValue(resolveUniversityName(submission, schema));
        cTitle.setCellStyle(titleStyle);

        Row rowSub = sheet.createRow(r++);
        Cell cSub = rowSub.createCell(0);
        cSub.setCellValue(resolveReportTitle(submission, schema));
        cSub.setCellStyle(headerStyle);

        r++; // blank line

        Row hRow = sheet.createRow(r++);
        hRow.createCell(0).setCellValue("Property");
        hRow.createCell(1).setCellValue("Details");
        hRow.getCell(0).setCellStyle(headerStyle);
        hRow.getCell(1).setCellStyle(headerStyle);

        String cycle = submission.getAuditCycle() != null ? submission.getAuditCycle() : submission.getAcademicYear();
        addExcelMetaRow(sheet, r++, "Audit Cycle", cycle != null ? cycle : "-", dataStyle);
        addExcelMetaRow(sheet, r++, "Audit Type", capitalize(submission.getAuditType()), dataStyle);
        addExcelMetaRow(sheet, r++, "School / Post", submission.getSchool() != null ? submission.getSchool() : submission.getAdministrativePost(), dataStyle);
        addExcelMetaRow(sheet, r++, "Submission ID", String.valueOf(submission.getId()), dataStyle);
        addExcelMetaRow(sheet, r++, "Status", submission.getStatus(), dataStyle);
        addExcelMetaRow(sheet, r++, "Submitted By", submission.getSubmittedBy() != null ? submission.getSubmittedBy() : submission.getEmail(), dataStyle);
        addExcelMetaRow(sheet, r++, "Submitted At", submission.getSubmittedAt() != null ? submission.getSubmittedAt().format(DATE_FORMATTER) : "-", dataStyle);
        addExcelMetaRow(sheet, r++, "Approved By", submission.getApprovedByName() != null ? submission.getApprovedByName() : "-", dataStyle);
        addExcelMetaRow(sheet, r++, "Approved At", submission.getApprovedAt() != null ? submission.getApprovedAt().format(DATE_FORMATTER) : "-", dataStyle);
        addExcelMetaRow(sheet, r++, "Remarks", submission.getRemarks() != null ? submission.getRemarks() : "-", dataStyle);

        sheet.setColumnWidth(0, 25 * 256);
        sheet.setColumnWidth(1, 50 * 256);
    }

    private void populateSectionSheet(XSSFSheet sheet, Map<String, Object> sec, Map<String, Object> values,
                                      Map<String, Object> tablesData, Submission submission,
                                      XSSFCellStyle headerStyle, XSSFCellStyle subHeaderStyle,
                                      XSSFCellStyle dataStyle, XSSFCellStyle altDataStyle) {
        int r = 0;
        String title = sec.get("title") != null ? sec.get("title").toString() : "Section";
        Row titleRow = sheet.createRow(r++);
        Cell tCell = titleRow.createCell(0);
        tCell.setCellValue(title.toUpperCase());
        tCell.setCellStyle(headerStyle);

        r++; // blank line

        // Fields
        List<Map<String, Object>> fields = safeListOfMaps(sec.get("fields"));
        if (fields != null && !fields.isEmpty()) {
            Row fHeader = sheet.createRow(r++);
            fHeader.createCell(0).setCellValue("Form Field");
            fHeader.createCell(1).setCellValue("Response / Value");
            fHeader.getCell(0).setCellStyle(subHeaderStyle);
            fHeader.getCell(1).setCellStyle(subHeaderStyle);

            for (Map<String, Object> f : fields) {
                String label = f.get("label") != null ? f.get("label").toString() : "Field";
                String key = f.get("fieldKey") != null ? f.get("fieldKey").toString() : (f.get("id") != null ? f.get("id").toString() : label);
                String val = formatValue(resolveFieldValue(key, label, values));

                Row fRow = sheet.createRow(r++);
                Cell c0 = fRow.createCell(0);
                c0.setCellValue(label);
                c0.setCellStyle(dataStyle);

                Cell c1 = fRow.createCell(1);
                c1.setCellValue(val);
                c1.setCellStyle(dataStyle);
            }
            r++; // blank row after fields
        }

        // Tables
        List<Map<String, Object>> secTables = safeListOfMaps(sec.get("tables"));
        if (secTables != null) {
            for (Map<String, Object> tbl : secTables) {
                String tTitle = tbl.get("title") != null ? tbl.get("title").toString() : "Table";
                String tKey = tbl.get("tableKey") != null ? tbl.get("tableKey").toString() : tTitle;

                Map<String, List<Map<String, Object>>> instancesMap = findTableRowsAcrossInstances(tKey, tbl, sec, tablesData);
                if (instancesMap.isEmpty()) {
                    List<Map<String, Object>> rows = resolveTableRows(tKey, tbl, tablesData);
                    r = renderExcelTable(sheet, r, tTitle, tbl, rows, subHeaderStyle, dataStyle, altDataStyle);
                } else {
                    for (Map.Entry<String, List<Map<String, Object>>> entry : instancesMap.entrySet()) {
                        String tName = tTitle + (entry.getKey().isBlank() ? "" : " (" + entry.getKey() + ")");
                        r = renderExcelTable(sheet, r, tName, tbl, entry.getValue(), subHeaderStyle, dataStyle, altDataStyle);
                    }
                }
                r++; // blank line between tables
            }
        }

        sheet.autoSizeColumn(0);
        sheet.autoSizeColumn(1);
    }

    private int renderExcelTable(XSSFSheet sheet, int startRow, String title, Map<String, Object> tblDef,
                                 List<Map<String, Object>> rows, XSSFCellStyle subHeaderStyle,
                                 XSSFCellStyle dataStyle, XSSFCellStyle altDataStyle) {
        int r = startRow;
        Row titleRow = sheet.createRow(r++);
        Cell tc = titleRow.createCell(0);
        tc.setCellValue(title);
        tc.setCellStyle(subHeaderStyle);

        List<String> columnLabels = extractColumnLabels(tblDef, rows);
        if (columnLabels.isEmpty()) columnLabels = List.of("Details");

        Row hRow = sheet.createRow(r++);
        Cell cSno = hRow.createCell(0);
        cSno.setCellValue("S.No");
        cSno.setCellStyle(subHeaderStyle);

        for (int c = 0; c < columnLabels.size(); c++) {
            Cell hc = hRow.createCell(c + 1);
            hc.setCellValue(columnLabels.get(c));
            hc.setCellStyle(subHeaderStyle);
        }

        if (rows != null) {
            int sno = 1;
            for (Map<String, Object> row : rows) {
                Row dRow = sheet.createRow(r++);
                XSSFCellStyle style = (sno % 2 == 0) ? altDataStyle : dataStyle;

                Cell cS = dRow.createCell(0);
                cS.setCellValue(sno);
                cS.setCellStyle(style);

                for (int c = 0; c < columnLabels.size(); c++) {
                    Object val = resolveCellFromRow(row, columnLabels.get(c), tblDef);
                    Cell dc = dRow.createCell(c + 1);
                    dc.setCellValue(formatValue(val));
                    dc.setCellStyle(style);
                }
                sno++;
            }
        }
        return r;
    }

    private void populateAuditorSheet(XSSFSheet sheet, List<SubmissionAuditorAssignment> assignments,
                                      XSSFCellStyle headerStyle, XSSFCellStyle subHeaderStyle,
                                      XSSFCellStyle dataStyle, XSSFCellStyle altDataStyle) {
        int r = 0;
        Row titleRow = sheet.createRow(r++);
        Cell tCell = titleRow.createCell(0);
        tCell.setCellValue("AUDITOR REVIEWS & EVALUATIONS");
        tCell.setCellStyle(headerStyle);
        r++;

        for (SubmissionAuditorAssignment a : assignments) {
            String type = "external".equalsIgnoreCase(a.getAuditorType()) ? "External Auditor" : "Internal Auditor";
            Row hRow = sheet.createRow(r++);
            Cell hc = hRow.createCell(0);
            hc.setCellValue(type + ": " + (a.getAuditorName() != null ? a.getAuditorName() : "Auditor"));
            hc.setCellStyle(subHeaderStyle);

            addExcelMetaRow(sheet, r++, "Auditor Email", a.getAuditorEmail() != null ? a.getAuditorEmail() : "-", dataStyle);
            addExcelMetaRow(sheet, r++, "Status", a.getStatus() != null ? a.getStatus() : "SUBMITTED", dataStyle);
            addExcelMetaRow(sheet, r++, "Submitted At", a.getSubmittedAt() != null ? a.getSubmittedAt().format(DATE_FORMATTER) : "-", dataStyle);
            if (a.getPost() != null && !a.getPost().isBlank()) {
                addExcelMetaRow(sheet, r++, "Assigned Post/School", a.getPost(), dataStyle);
            }

            Map<String, Object> aValues = parseJsonMap(a.getValuesData());
            String remarks = extractAuditorRemarks(a, aValues);
            if (remarks != null && !remarks.isBlank()) {
                addExcelMetaRow(sheet, r++, "Observations / Remarks", remarks, dataStyle);
            }

            Map<String, Object> aTables = parseJsonMap(a.getTablesData());
            if (aTables != null && !aTables.isEmpty()) {
                for (Map.Entry<String, Object> entry : aTables.entrySet()) {
                    List<Map<String, Object>> rows = safeListOfMaps(entry.getValue());
                    if (rows != null && !rows.isEmpty()) {
                        r = renderExcelTable(sheet, r + 1, "Auditor Table: " + entry.getKey(), Collections.emptyMap(), rows, subHeaderStyle, dataStyle, altDataStyle);
                    }
                }
            }
            r += 2;
        }

        sheet.setColumnWidth(0, 25 * 256);
        sheet.setColumnWidth(1, 55 * 256);
    }

    private void addExcelMetaRow(XSSFSheet sheet, int r, String key, String val, XSSFCellStyle dataStyle) {
        Row row = sheet.createRow(r);
        Cell c0 = row.createCell(0);
        c0.setCellValue(key);
        c0.setCellStyle(dataStyle);

        Cell c1 = row.createCell(1);
        c1.setCellValue(val);
        c1.setCellStyle(dataStyle);
    }

    // =========================================================================
    // 3. EXCEL STYLING HELPERS
    // =========================================================================

    private XSSFCellStyle createTitleStyle(XSSFWorkbook wb) {
        XSSFCellStyle s = wb.createCellStyle();
        XSSFFont f = wb.createFont();
        f.setBold(true);
        f.setFontHeightInPoints((short) 14);
        f.setColor(IndexedColors.DARK_BLUE.getIndex());
        s.setFont(f);
        return s;
    }

    private XSSFCellStyle createHeaderStyle(XSSFWorkbook wb) {
        XSSFCellStyle s = wb.createCellStyle();
        XSSFFont f = wb.createFont();
        f.setBold(true);
        f.setFontHeightInPoints((short) 11);
        f.setColor(IndexedColors.WHITE.getIndex());
        s.setFont(f);
        s.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        s.setAlignment(HorizontalAlignment.LEFT);
        return s;
    }

    private XSSFCellStyle createSubHeaderStyle(XSSFWorkbook wb) {
        XSSFCellStyle s = wb.createCellStyle();
        XSSFFont f = wb.createFont();
        f.setBold(true);
        f.setFontHeightInPoints((short) 10);
        s.setFont(f);
        s.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        s.setBorderBottom(BorderStyle.THIN);
        s.setBorderTop(BorderStyle.THIN);
        s.setBorderLeft(BorderStyle.THIN);
        s.setBorderRight(BorderStyle.THIN);
        return s;
    }

    private XSSFCellStyle createDataStyle(XSSFWorkbook wb) {
        XSSFCellStyle s = wb.createCellStyle();
        XSSFFont f = wb.createFont();
        f.setFontHeightInPoints((short) 10);
        s.setFont(f);
        s.setBorderBottom(BorderStyle.THIN);
        s.setBorderTop(BorderStyle.THIN);
        s.setBorderLeft(BorderStyle.THIN);
        s.setBorderRight(BorderStyle.THIN);
        s.setWrapText(true);
        return s;
    }

    private XSSFCellStyle createAltDataStyle(XSSFWorkbook wb) {
        XSSFCellStyle s = createDataStyle(wb);
        s.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        return s;
    }

    // =========================================================================
    // 4. SHARED DATA EXTRACTION & MAPPING HELPERS
    // =========================================================================

    private Map<String, Object> loadSchema(Submission submission) {
        if (formDataClient == null) return Collections.emptyMap();
        try {
            if (submission.getSchemaVersionId() != null) {
                Map<String, Object> cfg = formDataClient.getConfigByVersion(submission.getSchemaVersionId());
                if (cfg != null && cfg.get("sections") != null) return cfg;
            }
        } catch (Exception e) {
            log.warn("Failed to load schema version {}: {}", submission.getSchemaVersionId(), e.getMessage());
        }

        try {
            Map<String, Object> active = formDataClient.getActiveConfig(submission.getAuditType(), submission.getUniversityCode());
            if (active != null && active.get("sections") != null) return active;
        } catch (Exception e) {
            log.warn("Failed to load active schema for auditType {}: {}", submission.getAuditType(), e.getMessage());
        }

        return Collections.emptyMap();
    }

    private List<Map<String, Object>> extractSections(Map<String, Object> schema, Map<String, Object> tablesData, Map<String, Object> valuesData) {
        List<Map<String, Object>> list = safeListOfMaps(schema.get("sections"));
        if (list != null && !list.isEmpty()) {
            return list;
        }

        // Fallback: create dynamic sections from tablesData keys
        Map<String, Map<String, Object>> dynamicSections = new LinkedHashMap<>();
        if (tablesData != null) {
            for (String key : tablesData.keySet()) {
                String secKey = extractSectionKeyFromTableKey(key);
                dynamicSections.computeIfAbsent(secKey, k -> {
                    Map<String, Object> sec = new LinkedHashMap<>();
                    sec.put("number", k.replace("part_", ""));
                    sec.put("title", "Part " + k.replace("part_", "").toUpperCase());
                    sec.put("tables", new ArrayList<Map<String, Object>>());
                    return sec;
                });
                List<Map<String, Object>> tList = (List<Map<String, Object>>) dynamicSections.get(secKey).get("tables");
                Map<String, Object> tbl = new LinkedHashMap<>();
                tbl.put("tableKey", key);
                tbl.put("title", formatCleanTitle(key));
                tList.add(tbl);
            }
        }

        if (dynamicSections.isEmpty()) {
            Map<String, Object> defSec = new LinkedHashMap<>();
            defSec.put("number", "1");
            defSec.put("title", "Appraisal Information");
            dynamicSections.put("part_1", defSec);
        }

        return new ArrayList<>(dynamicSections.values());
    }

    private Map<String, List<Map<String, Object>>> findTableRowsAcrossInstances(String tableKey, Map<String, Object> tblDef,
                                                                               Map<String, Object> section, Map<String, Object> tablesData) {
        Map<String, List<Map<String, Object>>> result = new LinkedHashMap<>();
        if (tablesData == null) return result;

        String cleanBaseKey = tableKey.toLowerCase().replace(" ", "_");
        String secKey = section.get("sectionKey") != null ? section.get("sectionKey").toString() : ("part_" + section.get("number"));

        for (Map.Entry<String, Object> entry : tablesData.entrySet()) {
            String k = entry.getKey();
            if (k.contains("__")) {
                String[] parts = k.split("__");
                // Format: role__instance__sectionKey__baseKey
                if (parts.length >= 4) {
                    String instance = parts[1];
                    String sKey = parts[2];
                    String base = parts[3];
                    if (base.equalsIgnoreCase(cleanBaseKey) || base.equalsIgnoreCase(tableKey)) {
                        List<Map<String, Object>> r = safeListOfMaps(entry.getValue());
                        if (r != null && !r.isEmpty()) {
                            result.put(instance, r);
                        }
                    }
                } else if (parts.length == 3) {
                    // instance__sectionKey__baseKey
                    String instance = parts[0];
                    String base = parts[2];
                    if (base.equalsIgnoreCase(cleanBaseKey) || base.equalsIgnoreCase(tableKey)) {
                        List<Map<String, Object>> r = safeListOfMaps(entry.getValue());
                        if (r != null && !r.isEmpty()) {
                            result.put(instance, r);
                        }
                    }
                }
            }
        }
        return result;
    }

    private List<Map<String, Object>> resolveTableRows(String tableKey, Map<String, Object> tblDef, Map<String, Object> tablesData) {
        if (tablesData == null) return Collections.emptyList();
        if (tablesData.containsKey(tableKey)) {
            return safeListOfMaps(tablesData.get(tableKey));
        }
        for (Map.Entry<String, Object> e : tablesData.entrySet()) {
            if (e.getKey().equalsIgnoreCase(tableKey) || e.getKey().endsWith("__" + tableKey)) {
                return safeListOfMaps(e.getValue());
            }
        }
        return Collections.emptyList();
    }

    private List<String> extractColumnLabels(Map<String, Object> tblDef, List<Map<String, Object>> rows) {
        List<String> cols = new ArrayList<>();
        List<Map<String, Object>> defCols = safeListOfMaps(tblDef.get("columns"));
        if (defCols == null) defCols = safeListOfMaps(tblDef.get("fields"));

        if (defCols != null && !defCols.isEmpty()) {
            for (Map<String, Object> c : defCols) {
                String label = c.get("label") != null ? c.get("label").toString() : (c.get("key") != null ? c.get("key").toString() : "");
                if (!label.isBlank() && !cols.contains(label)) cols.add(label);
            }
        }

        if (cols.isEmpty() && rows != null && !rows.isEmpty()) {
            Map<String, Object> firstRow = rows.get(0);
            for (String k : firstRow.keySet()) {
                if (!k.equalsIgnoreCase("id") && !k.equalsIgnoreCase("_id")) {
                    cols.add(formatCleanTitle(k));
                }
            }
        }
        return cols;
    }

    private Object resolveCellFromRow(Map<String, Object> row, String colLabel, Map<String, Object> tblDef) {
        if (row == null) return "";
        if (row.containsKey(colLabel)) return row.get(colLabel);

        String colSlug = colLabel.toLowerCase().replaceAll("[^a-z0-9]", "");
        for (Map.Entry<String, Object> e : row.entrySet()) {
            String kSlug = e.getKey().toLowerCase().replaceAll("[^a-z0-9]", "");
            if (kSlug.equals(colSlug)) {
                return e.getValue();
            }
        }
        return "";
    }

    private Object resolveFieldValue(String key, String label, Map<String, Object> values) {
        if (values == null) return "";
        if (values.containsKey(key)) return values.get(key);
        if (values.containsKey(label)) return values.get(label);

        String slug = key.toLowerCase().replaceAll("[^a-z0-9]", "");
        for (Map.Entry<String, Object> e : values.entrySet()) {
            if (e.getKey().toLowerCase().replaceAll("[^a-z0-9]", "").equals(slug)) {
                return e.getValue();
            }
        }
        return "";
    }

    private String formatValue(Object val) {
        if (val == null) return "-";
        if (val instanceof String s) {
            if (s.isBlank()) return "-";
            if (s.startsWith("{") && s.contains("fileName")) {
                try {
                    JsonNode node = objectMapper.readTree(s);
                    if (node.has("fileName")) return node.get("fileName").asText();
                    if (node.has("name")) return node.get("name").asText();
                } catch (Exception ignored) {}
            }
            return s;
        }
        if (val instanceof Map<?, ?> m) {
            if (m.containsKey("fileName")) return String.valueOf(m.get("fileName"));
            if (m.containsKey("name")) return String.valueOf(m.get("name"));
        }
        if (val instanceof List<?> l) {
            List<String> strList = new ArrayList<>();
            for (Object o : l) {
                strList.add(formatValue(o));
            }
            return String.join(", ", strList);
        }
        if (val instanceof Boolean b) {
            return b ? "Yes" : "No";
        }
        return String.valueOf(val);
    }

    private String extractAuditorRemarks(SubmissionAuditorAssignment a, Map<String, Object> aValues) {
        if (aValues != null) {
            for (String k : aValues.keySet()) {
                if (k.toLowerCase().contains("remark") || k.toLowerCase().contains("observation") || k.toLowerCase().contains("recommendation")) {
                    Object v = aValues.get(k);
                    if (v != null && !v.toString().isBlank()) return v.toString();
                }
            }
        }
        if (a.getAuditorCorrectionMessage() != null) {
            return a.getAuditorCorrectionMessage();
        }
        return null;
    }

    private String resolveUniversityName(Submission submission, Map<String, Object> schema) {
        Map<String, Object> header = safeMap(schema != null ? schema.get("header") : null);
        if (header.get("university") != null && !header.get("university").toString().isBlank()) {
            return header.get("university").toString();
        }
        String uniCode = submission.getUniversityCode();
        if ("DYPIU".equalsIgnoreCase(uniCode)) {
            return "D Y Patil International University, Akurdi, Pune";
        }
        return uniCode != null && !uniCode.isBlank() ? uniCode + " University" : "D Y Patil International University, Akurdi, Pune";
    }

    private String resolveReportTitle(Submission submission, Map<String, Object> schema) {
        if (schema != null && schema.get("title") != null && !schema.get("title").toString().isBlank()) {
            return schema.get("title").toString();
        }
        if ("administrative".equalsIgnoreCase(submission.getAuditType())) {
            return "Annual Administrative Performance Appraisal Report";
        }
        return "Annual Performance Appraisal Report - School Directors";
    }

    private String extractSectionKeyFromTableKey(String key) {
        if (key.contains("__")) {
            String[] parts = key.split("__");
            if (parts.length >= 4) return parts[2];
            if (parts.length >= 3) return parts[1];
        }
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("(?i)part[_-]?([0-9a-zA-Z]+)").matcher(key);
        if (m.find()) {
            return "part_" + m.group(1).toLowerCase();
        }
        return "part_1";
    }

    private String formatCleanTitle(String str) {
        if (str == null) return "";
        return str.replace('_', ' ').replace('-', ' ').trim();
    }

    private String capitalize(String str) {
        if (str == null || str.isBlank()) return "";
        return Character.toUpperCase(str.charAt(0)) + str.substring(1).toLowerCase();
    }

    private String sanitizeSheetName(String name) {
        if (name == null) return "Sheet";
        String clean = name.replaceAll("[\\\\/*?\\[\\]:]", " ").trim();
        return clean.length() > 30 ? clean.substring(0, 30) : clean;
    }

    private void addMetaCell(PdfPTable table, String text, boolean isLabel) {
        com.lowagie.text.Font font = isLabel
                ? FontFactory.getFont(FontFactory.HELVETICA_BOLD, 8f, COLOR_PRIMARY)
                : FontFactory.getFont(FontFactory.HELVETICA, 8f, COLOR_TEXT);
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBackgroundColor(isLabel ? COLOR_HEADER_BG : Color.WHITE);
        cell.setBorderColor(COLOR_BORDER);
        cell.setPadding(4.5f);
        table.addCell(cell);
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> parseJsonMap(String json) {
        if (json == null || json.isBlank()) return Collections.emptyMap();
        try {
            return objectMapper.readValue(json, Map.class);
        } catch (Exception e) {
            return Collections.emptyMap();
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, Object> safeMap(Object obj) {
        return (obj instanceof Map<?, ?> m) ? (Map<String, Object>) m : Collections.emptyMap();
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> safeListOfMaps(Object obj) {
        if (obj instanceof List<?> l) {
            List<Map<String, Object>> res = new ArrayList<>();
            for (Object o : l) {
                if (o instanceof Map<?, ?> m) {
                    res.add((Map<String, Object>) m);
                }
            }
            return res;
        }
        return Collections.emptyList();
    }

    // =========================================================================
    // 5. PDF PAGE EVENT HELPER (Header & Footer)
    // =========================================================================

    private static class PdfPageHeaderFooter extends PdfPageEventHelper {
        private final String headerText;
        private final String reportTitle;
        private final com.lowagie.text.Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 7.5f, Color.GRAY);
        private final com.lowagie.text.Font footerFont = FontFactory.getFont(FontFactory.HELVETICA, 7.5f, new Color(0x64, 0x74, 0x8B));

        public PdfPageHeaderFooter(String headerText, String reportTitle) {
            this.headerText = headerText;
            this.reportTitle = reportTitle;
        }

        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            // Running top header (from page 2 onward)
            if (writer.getPageNumber() > 1) {
                PdfPTable topTable = new PdfPTable(1);
                topTable.setTotalWidth(document.right() - document.left());
                PdfPCell cell = new PdfPCell(new Phrase(headerText + " — " + reportTitle, headerFont));
                cell.setBorder(com.lowagie.text.Rectangle.BOTTOM);
                cell.setBorderColor(new Color(0xDC, 0xE1, 0xE6));
                cell.setPaddingBottom(3);
                cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                topTable.addCell(cell);
                topTable.writeSelectedRows(0, -1, document.left(), document.top() + 18, writer.getDirectContent());
            }

            // Running bottom footer (all pages)
            PdfPTable botTable = new PdfPTable(2);
            botTable.setTotalWidth(document.right() - document.left());
            try {
                botTable.setWidths(new float[]{78f, 22f});
            } catch (Exception ignored) {}

            PdfPCell leftCell = new PdfPCell(new Phrase("Official Appraisal & Audit Document | Confidential", footerFont));
            leftCell.setBorder(com.lowagie.text.Rectangle.TOP);
            leftCell.setBorderColor(new Color(0xDC, 0xE1, 0xE6));
            leftCell.setPaddingTop(3);
            leftCell.setHorizontalAlignment(Element.ALIGN_LEFT);
            botTable.addCell(leftCell);

            PdfPCell rightCell = new PdfPCell(new Phrase("Page " + writer.getPageNumber(), footerFont));
            rightCell.setBorder(com.lowagie.text.Rectangle.TOP);
            rightCell.setBorderColor(new Color(0xDC, 0xE1, 0xE6));
            rightCell.setPaddingTop(3);
            rightCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            botTable.addCell(rightCell);

            botTable.writeSelectedRows(0, -1, document.left(), document.bottom() - 10, writer.getDirectContent());
        }
    }
}
