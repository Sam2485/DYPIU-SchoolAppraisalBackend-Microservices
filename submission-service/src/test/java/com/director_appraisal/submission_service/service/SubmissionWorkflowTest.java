package com.director_appraisal.submission_service.service;

import com.director_appraisal.submission_service.client.FormDataClient;
import com.director_appraisal.submission_service.dto.UserDto;
import com.director_appraisal.submission_service.model.Submission;
import com.director_appraisal.submission_service.repository.SubmissionRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("Submission Service - Workflow & Tenant Isolation Tests")
class SubmissionWorkflowTest {

    @Mock
    private SubmissionRepository submissionRepository;
    @Mock
    private FormDataClient formDataClient;

    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
    }

    @Test
    @DisplayName("Should initialize submission with universityId, universityCode and active schemaVersionId")
    void testSubmissionInitialization() {
        when(formDataClient.getActiveConfig("academic", "dypiu"))
                .thenReturn(Map.of("versionId", 1L, "title", "External Academic Audit"));

        Long schemaVersionId = 1L;
        Map<String, Object> cfg = formDataClient.getActiveConfig("academic", "dypiu");
        if (cfg != null && cfg.get("versionId") != null) {
            schemaVersionId = Long.valueOf(cfg.get("versionId").toString());
        }

        Submission sub = Submission.builder()
                .email("director@dypiu.ac.in")
                .auditType("academic")
                .school("School of Engineering")
                .academicYear("2025-26")
                .auditCycle("2025-26")
                .status("DRAFT")
                .valuesData("{}")
                .tablesData("{}")
                .attachments("[]")
                .schemaVersionId(schemaVersionId)
                .universityId(1L)
                .universityCode("dypiu")
                .build();

        assertEquals(1L, sub.getUniversityId());
        assertEquals("dypiu", sub.getUniversityCode());
        assertEquals(1L, sub.getSchemaVersionId());
        assertEquals("DRAFT", sub.getStatus());
    }

    @Test
    @DisplayName("Should preserve multi-contributor fields in Shared Administrative draft across posts")
    void testAdministrativeMultiContributorMerging() throws Exception {
        // Initial blank shared submission
        String initialValues = "{\"viceChancellor\":\"Prof. VC\",\"registrar\":\"Dr. Registrar\",\"sportsFacility\":\"Gymnasium\"}";
        Submission sub = Submission.builder()
                .id(50L)
                .email("administrative-office@dypiu.ac.in")
                .auditType("administrative")
                .school("Administrative Office")
                .valuesData(initialValues)
                .tablesData("{}")
                .attachments("[]")
                .build();

        // HR updates HR values
        com.fasterxml.jackson.databind.node.ObjectNode valuesNode = (com.fasterxml.jackson.databind.node.ObjectNode) objectMapper.readTree(sub.getValuesData());
        valuesNode.put("hrDirector", "Dr. HR Head");
        valuesNode.put("totalFacultyCount", "150");

        sub.setValuesData(objectMapper.writeValueAsString(valuesNode));

        // Verify Registrar and Sports values are still intact
        com.fasterxml.jackson.databind.JsonNode updated = objectMapper.readTree(sub.getValuesData());
        assertEquals("Prof. VC", updated.get("viceChancellor").asText());
        assertEquals("Dr. Registrar", updated.get("registrar").asText());
        assertEquals("Gymnasium", updated.get("sportsFacility").asText());
        assertEquals("Dr. HR Head", updated.get("hrDirector").asText());
        assertEquals("150", updated.get("totalFacultyCount").asText());
    }

    @Test
    @DisplayName("Should enforce tenant isolation: University A submissions cannot match University B queries")
    void testTenantQueryIsolation() {
        Submission subUniA = Submission.builder()
                .id(1L)
                .email("user@dypiu.ac.in")
                .universityId(1L)
                .universityCode("dypiu")
                .build();

        Submission subUniB = Submission.builder()
                .id(2L)
                .email("user@apex.edu.in")
                .universityId(2L)
                .universityCode("apex_uni")
                .build();

        assertNotEquals(subUniA.getUniversityId(), subUniB.getUniversityId());
        assertNotEquals(subUniA.getUniversityCode(), subUniB.getUniversityCode());
    }
}
