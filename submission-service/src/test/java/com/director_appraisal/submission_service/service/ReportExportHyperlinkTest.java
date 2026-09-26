package com.director_appraisal.submission_service.service;

import com.director_appraisal.submission_service.client.AuthUserClient;
import com.director_appraisal.submission_service.client.FormDataClient;
import com.director_appraisal.submission_service.controller.SubmissionController;
import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.model.SubmissionAuditorAssignment;
import com.director_appraisal.submission_service.repository.SubmissionAuditorAssignmentRepository;
import com.lowagie.text.pdf.PdfArray;
import com.lowagie.text.pdf.PdfDictionary;
import com.lowagie.text.pdf.PdfName;
import com.lowagie.text.pdf.PdfReader;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import java.io.ByteArrayInputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

class ReportExportHyperlinkTest {

    private FormDataClient formDataClient;
    private AuthUserClient authUserClient;
    private SubmissionAuditorAssignmentRepository auditorAssignmentRepository;
    private ReportExportService reportExportService;

    @BeforeEach
    void setUp() {
        formDataClient = Mockito.mock(FormDataClient.class);
        authUserClient = Mockito.mock(AuthUserClient.class);
        auditorAssignmentRepository = Mockito.mock(SubmissionAuditorAssignmentRepository.class);
        reportExportService = new ReportExportService(formDataClient, authUserClient, auditorAssignmentRepository);
    }

    private Submission createTestSubmissionWithAttachments() {
        Submission s = new Submission();
        s.setId(101L);
        s.setAuditCycle("2024-2025");
        s.setAcademicYear("2024-2025");
        s.setAuditType("academic");
        s.setSchool("School of Computer Science");
        s.setEmail("director.scs@dypiu.ac.in");
        s.setSubmittedBy("Dr. John Doe");
        s.setStatus("APPROVED");
        s.setSubmittedAt(LocalDateTime.of(2025, 6, 15, 10, 30));
        s.setApprovedByName("Prof. Vice Chancellor");
        s.setApprovedAt(LocalDateTime.of(2025, 6, 20, 14, 0));
        s.setRemarks("Excellent performance");

        // General attachments JSON
        s.setAttachments("[{\"fileName\":\"STQA ut2.pdf\",\"url\":\"/uploads/users/1/attachments/2026/09/uuid1-STQA-ut2.pdf\"}," +
                "{\"fileName\":\"Spring AI Certificate.pdf\",\"url\":\"/uploads/users/1/attachments/2026/09/uuid2-spring-ai.pdf\"}]");

        // Values data with scalar attachment field
        s.setValuesData("{\"general_notes\":\"All goals achieved\"," +
                "\"proof_of_appointment\":{\"fileName\":\"Appointment_Order.pdf\",\"url\":\"/uploads/users/1/attachments/order.pdf\"}}");

        // Tables data with row attachment cells (one JSON object, one plain text matching attachment name)
        s.setTablesData("{\"publications_table\":[" +
                "{\"title\":\"AI in Higher Education\",\"indexing\":\"Scopus\",\"certificate\":{\"fileName\":\"Paper_Certificate.pdf\",\"url\":\"/uploads/users/1/attachments/cert1.pdf\"}}," +
                "{\"title\":\"Advanced Testing Automation\",\"indexing\":\"Web of Science\",\"certificate\":\"STQA ut2.pdf\"}" +
                "]}");

        return s;
    }

    private Map<String, Object> createTestSchema() {
        return Map.of(
                "header", Map.of(
                        "university", "D. Y. Patil International University",
                        "address", "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044",
                        "act", "(Established under Maharashtra Private Universities Act No. VI of 2019)"
                ),
                "sections", List.of(
                        Map.of(
                                "id", "sec_1",
                                "number", "A",
                                "title", "General Information",
                                "fields", List.of(
                                        Map.of("fieldKey", "general_notes", "label", "General Notes"),
                                        Map.of("fieldKey", "proof_of_appointment", "label", "Proof of Appointment")
                                ),
                                "tables", List.of(
                                        Map.of(
                                                "tableKey", "publications_table",
                                                "title", "Research Publications",
                                                "columns", List.of(
                                                        Map.of("key", "title", "label", "Paper Title"),
                                                        Map.of("key", "indexing", "label", "Indexing"),
                                                        Map.of("key", "certificate", "label", "Certificate / Document")
                                                )
                                        )
                                )
                        )
                )
        );
    }

    @Test
    @DisplayName("PDF report export should generate clickable hyperlinks for attachment cells and fields")
    void testPdfReportGeneratesClickableHyperlinks() throws Exception {
        Submission submission = createTestSubmissionWithAttachments();
        Map<String, Object> schema = createTestSchema();
        when(formDataClient.getActiveConfig(eq("academic"), any())).thenReturn(schema);

        MockHttpServletResponse response = new MockHttpServletResponse();
        String publicBaseUrl = "http://150.129.156.37:3003";

        reportExportService.generatePdfReport(submission, response, publicBaseUrl);

        byte[] pdfBytes = response.getContentAsByteArray();
        assertNotNull(pdfBytes);
        assertTrue(pdfBytes.length > 0, "PDF should not be empty");

        // Read the generated PDF and inspect URI annotations
        PdfReader reader = new PdfReader(new ByteArrayInputStream(pdfBytes));
        int numPages = reader.getNumberOfPages();
        assertTrue(numPages >= 1);

        List<String> uriLinksFound = new ArrayList<>();
        for (int i = 1; i <= numPages; i++) {
            PdfDictionary pageDict = reader.getPageN(i);
            PdfArray annotArray = pageDict.getAsArray(PdfName.ANNOTS);
            if (annotArray != null) {
                for (int j = 0; j < annotArray.size(); j++) {
                    PdfDictionary annot = annotArray.getAsDict(j);
                    if (annot != null) {
                        PdfDictionary action = annot.getAsDict(PdfName.A);
                        if (action != null) {
                            String uri = action.getAsString(PdfName.URI) != null
                                    ? action.getAsString(PdfName.URI).toString()
                                    : null;
                            if (uri != null) {
                                uriLinksFound.add(uri);
                            }
                        }
                    }
                }
            }
        }

        assertFalse(uriLinksFound.isEmpty(), "Generated PDF must contain URI hyperlink annotations for attachments");

        // Verify that attachment URLs route through /api/attachments/download with inline=true and publicBaseUrl
        boolean foundStqaLink = uriLinksFound.stream().anyMatch(u ->
                u.startsWith("http://150.129.156.37:3003/api/attachments/download")
                        && u.contains("STQA")
                        && u.contains("inline=true"));
        assertTrue(foundStqaLink, "Expected clickable link for 'STQA ut2.pdf' routing to storage download endpoint");

        boolean foundAppointmentLink = uriLinksFound.stream().anyMatch(u ->
                u.startsWith("http://150.129.156.37:3003/api/attachments/download")
                        && u.contains("Appointment_Order")
                        && u.contains("inline=true"));
        assertTrue(foundAppointmentLink, "Expected clickable link for 'Appointment_Order.pdf' in fields table");

        reader.close();
    }

    @Test
    @DisplayName("Excel report export should generate clickable POI Hyperlinks for attachment cells and fields")
    void testExcelReportGeneratesClickableHyperlinks() throws Exception {
        Submission submission = createTestSubmissionWithAttachments();
        Map<String, Object> schema = createTestSchema();
        when(formDataClient.getActiveConfig(eq("academic"), any())).thenReturn(schema);

        MockHttpServletResponse response = new MockHttpServletResponse();
        String publicBaseUrl = "http://150.129.156.37:3003";

        reportExportService.generateExcelReport(submission, response, publicBaseUrl);

        byte[] xlsxBytes = response.getContentAsByteArray();
        assertNotNull(xlsxBytes);
        assertTrue(xlsxBytes.length > 0, "Excel output should not be empty");

        // Read the generated Excel spreadsheet with Apache POI
        try (XSSFWorkbook workbook = new XSSFWorkbook(new ByteArrayInputStream(xlsxBytes))) {
            // Check Summary Sheet for consolidated attachments archive ZIP link
            XSSFSheet summarySheet = workbook.getSheet("Summary");
            assertNotNull(summarySheet, "Summary sheet must exist");

            boolean foundZipArchiveLink = false;
            for (Row row : summarySheet) {
                for (Cell cell : row) {
                    if (cell.getHyperlink() != null && cell.getHyperlink().getAddress() != null) {
                        String addr = cell.getHyperlink().getAddress();
                        if (addr.contains("/api/submissions/101/attachments/download")) {
                            foundZipArchiveLink = true;
                        }
                    }
                }
            }
            assertTrue(foundZipArchiveLink, "Summary sheet should have consolidated ZIP archive download hyperlink");

            // Check Section Sheet for cell attachment hyperlinks
            XSSFSheet sectionSheet = workbook.getSheetAt(1); // Part 1 - General Information
            assertNotNull(sectionSheet, "Part sheet must exist");

            List<String> hyperlinkAddresses = new ArrayList<>();
            for (Row row : sectionSheet) {
                for (Cell cell : row) {
                    if (cell.getHyperlink() != null && cell.getHyperlink().getAddress() != null) {
                        hyperlinkAddresses.add(cell.getHyperlink().getAddress());
                    }
                }
            }

            assertFalse(hyperlinkAddresses.isEmpty(), "Section sheet must have clickable cell hyperlinks for attachments");

            boolean foundStqaExcelLink = hyperlinkAddresses.stream().anyMatch(addr ->
                    addr.startsWith("http://150.129.156.37:3003/api/attachments/download")
                            && addr.contains("STQA")
                            && addr.contains("inline=true"));
            assertTrue(foundStqaExcelLink, "Excel table row must have clickable hyperlink for STQA ut2.pdf");

            boolean foundAppointmentExcelLink = hyperlinkAddresses.stream().anyMatch(addr ->
                    addr.startsWith("http://150.129.156.37:3003/api/attachments/download")
                            && addr.contains("Appointment_Order")
                            && addr.contains("inline=true"));
            assertTrue(foundAppointmentExcelLink, "Excel field response must have clickable hyperlink for Appointment_Order.pdf");
        }
    }

    @Test
    @DisplayName("SubmissionController.resolvePublicBaseUrl should correctly extract base URL from headers")
    void testResolvePublicBaseUrlFromRequestHeaders() {
        SubmissionController controller = new SubmissionController(
                null, null, null, null, null
        );

        // 1. Test X-Forwarded-Host with X-Forwarded-Proto
        MockHttpServletRequest req1 = new MockHttpServletRequest();
        req1.addHeader("X-Forwarded-Host", "150.129.156.37:3003");
        req1.addHeader("X-Forwarded-Proto", "http");
        assertEquals("http://150.129.156.37:3003", controller.resolvePublicBaseUrl(req1));

        // 2. Test Origin header
        MockHttpServletRequest req2 = new MockHttpServletRequest();
        req2.addHeader("Origin", "http://150.129.156.37:3003");
        assertEquals("http://150.129.156.37:3003", controller.resolvePublicBaseUrl(req2));

        // 3. Test Referer header
        MockHttpServletRequest req3 = new MockHttpServletRequest();
        req3.addHeader("Referer", "http://150.129.156.37:3003/app/submissions/101");
        assertEquals("http://150.129.156.37:3003", controller.resolvePublicBaseUrl(req3));

        // 4. Test standard Host header
        MockHttpServletRequest req4 = new MockHttpServletRequest();
        req4.setScheme("http");
        req4.addHeader("Host", "150.129.156.37:3003");
        assertEquals("http://150.129.156.37:3003", controller.resolvePublicBaseUrl(req4));

        // 5. Test multi-proxy chaining (X-Forwarded-Proto: http,http and X-Forwarded-Host with commas)
        MockHttpServletRequest req5 = new MockHttpServletRequest();
        req5.addHeader("X-Forwarded-Proto", "http,http");
        req5.addHeader("X-Forwarded-Host", "150.129.156.37, 150.129.156.37:8080, 80");
        req5.addHeader("X-Forwarded-Port", "8080, 80");
        // Should sanitize without commas and pick valid host/port
        assertFalse(controller.resolvePublicBaseUrl(req5).contains(","));
        assertTrue(controller.resolvePublicBaseUrl(req5).startsWith("http://"));

        // 6. Test Referer precedence over multi-proxy headers
        MockHttpServletRequest req6 = new MockHttpServletRequest();
        req6.addHeader("Referer", "http://150.129.156.37:3003/dashboard/reports");
        req6.addHeader("X-Forwarded-Proto", "http,http");
        req6.addHeader("X-Forwarded-Host", "150.129.156.37, 150.129.156.37:8080, 80");
        assertEquals("http://150.129.156.37:3003", controller.resolvePublicBaseUrl(req6));
    }
}
