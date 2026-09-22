package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.client.SubmissionServiceClient;
import com.director_appraisal.form_data_service.dto.config.*;
import com.director_appraisal.form_data_service.model.config.*;
import com.director_appraisal.form_data_service.repository.config.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Service
public class FormConfigService {

    private final FormSchemaRepository formSchemaRepository;
    private final SchemaVersionRepository schemaVersionRepository;
    private final FormSectionRepository formSectionRepository;
    private final FormTableRepository formTableRepository;
    private final FormFieldRepository formFieldRepository;
    private final SchemaCompilerService schemaCompilerService;
    private final ObjectMapper objectMapper;
    private final SubmissionServiceClient submissionServiceClient;

    @Autowired
    public FormConfigService(FormSchemaRepository formSchemaRepository,
                             SchemaVersionRepository schemaVersionRepository,
                             FormSectionRepository formSectionRepository,
                             FormTableRepository formTableRepository,
                             FormFieldRepository formFieldRepository,
                             SchemaCompilerService schemaCompilerService,
                             ObjectMapper objectMapper,
                             @Autowired(required = false) SubmissionServiceClient submissionServiceClient) {
        this.formSchemaRepository = formSchemaRepository;
        this.schemaVersionRepository = schemaVersionRepository;
        this.formSectionRepository = formSectionRepository;
        this.formTableRepository = formTableRepository;
        this.formFieldRepository = formFieldRepository;
        this.schemaCompilerService = schemaCompilerService;
        this.objectMapper = objectMapper;
        this.submissionServiceClient = submissionServiceClient;
    }

    public FormConfigService(FormSchemaRepository formSchemaRepository,
                             SchemaVersionRepository schemaVersionRepository,
                             FormSectionRepository formSectionRepository,
                             FormTableRepository formTableRepository,
                             FormFieldRepository formFieldRepository,
                             SchemaCompilerService schemaCompilerService,
                             ObjectMapper objectMapper) {
        this(formSchemaRepository, schemaVersionRepository, formSectionRepository,
                formTableRepository, formFieldRepository, schemaCompilerService, objectMapper, null);
    }

    @Transactional(readOnly = true)
    public CompiledSchemaDto getActiveCompiledSchema(String auditType) {
        return getActiveCompiledSchema(auditType, null);
    }

    @Transactional(readOnly = true)
    public CompiledSchemaDto getActiveCompiledSchema(String universityCode, String auditType, String school) {
        return getActiveCompiledSchema(auditType, school);
    }

    @Transactional(readOnly = true)
    public CompiledSchemaDto getActiveCompiledSchema(String auditType, String school) {
        String type = (auditType != null && !auditType.isBlank()) ? auditType.trim().toLowerCase() : "academic";

        List<FormSchema> allSchemas = formSchemaRepository.findAll();
        List<FormSchema> matchingType = allSchemas.stream()
                .filter(s -> type.equalsIgnoreCase(s.getAuditType()) && "ACTIVE".equalsIgnoreCase(s.getStatus()))
                .toList();

        if (matchingType.isEmpty()) {
            throw new IllegalArgumentException("No active form schema found for " + type);
        }

        FormSchema selectedSchema = null;
        if (school != null && !school.isBlank()) {
            String cleanSchool = school.trim().toLowerCase();
            for (FormSchema s : matchingType) {
                if (matchesSchool(s.getAssignedSchools(), cleanSchool)) {
                    selectedSchema = s;
                    break;
                }
            }
        }

        if (selectedSchema == null) {
            // Fallback to ALL or first matching
            selectedSchema = matchingType.stream()
                    .filter(s -> s.getAssignedSchools() == null || "ALL".equalsIgnoreCase(s.getAssignedSchools().trim()) || s.getAssignedSchools().isBlank())
                    .findFirst()
                    .orElse(matchingType.get(0));
        }

        Long versionId = selectedSchema.getActiveVersionId();
        if (versionId == null) {
            List<SchemaVersion> versions = schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(selectedSchema.getId());
            if (versions.isEmpty()) {
                throw new IllegalStateException("No versions found for schema: " + selectedSchema.getName());
            }
            versionId = versions.get(0).getId();
        }

        return getCompiledSchemaByVersion(versionId);
    }

    public static List<String> parseAssignedSchools(String assignedSchools) {
        if (assignedSchools == null || assignedSchools.isBlank()) {
            return Collections.emptyList();
        }
        String trimmed = assignedSchools.trim();
        if ("ALL".equalsIgnoreCase(trimmed) || "\"ALL\"".equalsIgnoreCase(trimmed)) {
            return Collections.emptyList();
        }

        List<String> result = new ArrayList<>();
        if (trimmed.startsWith("[") && trimmed.endsWith("]")) {
            try {
                ObjectMapper om = new ObjectMapper();
                List<?> list = om.readValue(trimmed, List.class);
                for (Object item : list) {
                    if (item != null && !item.toString().isBlank()) {
                        result.add(item.toString().trim().toUpperCase());
                    }
                }
                return result;
            } catch (Exception ignored) {}
        }

        for (String part : trimmed.split(",")) {
            String clean = part.replaceAll("[\"\\[\\]]", "").trim().toUpperCase();
            if (!clean.isBlank() && !"ALL".equalsIgnoreCase(clean)) {
                result.add(clean);
            }
        }
        return result;
    }

    public static boolean isAllSchools(String assignedSchools) {
        if (assignedSchools == null || assignedSchools.isBlank()) return true;
        String t = assignedSchools.trim();
        return "ALL".equalsIgnoreCase(t) || "\"ALL\"".equalsIgnoreCase(t);
    }

    public void validateSchoolAssignments(Long targetSchemaId, String auditType, String assignedSchools) {
        if (assignedSchools == null || assignedSchools.isBlank()) {
            return;
        }

        String targetType = (auditType != null && !auditType.isBlank()) ? auditType.trim().toLowerCase() : "academic";
        boolean isAll = isAllSchools(assignedSchools);
        List<String> targetSchools = parseAssignedSchools(assignedSchools);

        List<FormSchema> existingSchemas = formSchemaRepository.findAll();

        for (FormSchema other : existingSchemas) {
            // Skip self
            if (targetSchemaId != null && targetSchemaId.equals(other.getId())) {
                continue;
            }
            // Only compare within the same auditType and active status
            if (!targetType.equalsIgnoreCase(other.getAuditType()) || !"ACTIVE".equalsIgnoreCase(other.getStatus())) {
                continue;
            }

            if (isAll) {
                if (isAllSchools(other.getAssignedSchools())) {
                    throw new ResponseStatusException(
                            HttpStatus.BAD_REQUEST,
                            "Form '" + other.getName() + "' is already assigned to ALL schools for " + targetType + ". Only one form can be assigned to ALL schools at a time."
                    );
                }
            } else {
                List<String> otherSchools = parseAssignedSchools(other.getAssignedSchools());
                for (String school : targetSchools) {
                    for (String otherSchool : otherSchools) {
                        if (school.equalsIgnoreCase(otherSchool)) {
                            throw new ResponseStatusException(
                                    HttpStatus.BAD_REQUEST,
                                    "School '" + school + "' is already assigned to form '" + other.getName() + "'. A school can only be assigned to one form at a time."
                            );
                        }
                    }
                }
            }
        }
    }

    private boolean matchesSchool(String assignedSchools, String schoolQuery) {
        if (assignedSchools == null || assignedSchools.isBlank() || isAllSchools(assignedSchools)) {
            return false;
        }
        if (schoolQuery == null || schoolQuery.isBlank()) {
            return false;
        }
        List<String> assignedList = parseAssignedSchools(assignedSchools);
        String q = schoolQuery.trim().toUpperCase();
        for (String code : assignedList) {
            if (code.equalsIgnoreCase(q) || q.contains(code) || code.contains(q)) {
                return true;
            }
        }
        return false;
    }

    @Transactional(readOnly = true)
    public CompiledSchemaDto getCompiledSchemaByVersion(Long versionId) {
        SchemaVersion version = schemaVersionRepository.findById(versionId)
                .orElseThrow(() -> new IllegalArgumentException("Version not found: " + versionId));

        if (version.getCompiledSchema() != null && !version.getCompiledSchema().isBlank()) {
            try {
                return objectMapper.readValue(version.getCompiledSchema(), CompiledSchemaDto.class);
            } catch (Exception e) {
                log.warn("Failed to parse cached compiled schema, recompiling version {}: {}", versionId, e.getMessage());
            }
        }

        return schemaCompilerService.compile(versionId);
    }

    @Transactional
    public SchemaVersion createDraftVersion(Long schemaId, String createdBy) {
        FormSchema schema = formSchemaRepository.findById(schemaId)
                .orElseThrow(() -> new IllegalArgumentException("Schema not found: " + schemaId));

        List<SchemaVersion> existingVersions = schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(schemaId);
        
        Optional<SchemaVersion> existingDraft = existingVersions.stream()
                .filter(v -> "DRAFT".equalsIgnoreCase(v.getStatus()))
                .findFirst();
        if (existingDraft.isPresent()) {
            return existingDraft.get();
        }

        int nextVersionNumber = 1;
        SchemaVersion sourceVersion = null;
        if (!existingVersions.isEmpty()) {
            sourceVersion = existingVersions.get(0);
            nextVersionNumber = sourceVersion.getVersionNumber() + 1;
        }

        SchemaVersion draft = SchemaVersion.builder()
                .schemaId(schema.getId())
                .versionNumber(nextVersionNumber)
                .status("DRAFT")
                .academicYear(sourceVersion != null ? sourceVersion.getAcademicYear() : resolveDefaultAcademicYear())
                .title(sourceVersion != null ? sourceVersion.getTitle() : schema.getName())
                .ownerRole(sourceVersion != null ? sourceVersion.getOwnerRole() : ("administrative".equalsIgnoreCase(schema.getAuditType()) ? "administrative" : "director-schools"))
                .publishedBy(createdBy)
                .build();

        SchemaVersion savedDraft = schemaVersionRepository.save(draft);

        if (sourceVersion != null) {
            cloneVersionTree(sourceVersion.getId(), savedDraft.getId());
        }

        return savedDraft;
    }

    private void cloneVersionTree(Long sourceVersionId, Long targetVersionId) {
        List<FormSection> sourceSections = formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(sourceVersionId);

        for (FormSection srcSec : sourceSections) {
            FormSection newSec = FormSection.builder()
                    .versionId(targetVersionId)
                    .sectionKey(srcSec.getSectionKey())
                    .title(srcSec.getTitle())
                    .sectionNumber(srcSec.getSectionNumber())
                    .ownerRole(srcSec.getOwnerRole())
                    .description(srcSec.getDescription())
                    .displayOrder(srcSec.getDisplayOrder())
                    .tableButtons(srcSec.getTableButtons())
                    .build();
            FormSection savedSec = formSectionRepository.save(newSec);

            List<FormField> topFields = formFieldRepository.findBySectionIdAndTableIdIsNullOrderByDisplayOrderAscIdAsc(srcSec.getId());
            for (FormField f : topFields) {
                FormField newField = FormField.builder()
                        .sectionId(savedSec.getId())
                        .tableId(null)
                        .fieldKey(f.getFieldKey())
                        .label(f.getLabel())
                        .fieldType(f.getFieldType())
                        .kind(f.getKind())
                        .isRequired(f.getIsRequired())
                        .placeholder(f.getPlaceholder())
                        .defaultValue(f.getDefaultValue())
                        .validationRules(f.getValidationRules())
                        .options(f.getOptions())
                        .attachmentRules(f.getAttachmentRules())
                        .displayOrder(f.getDisplayOrder())
                        .build();
                formFieldRepository.save(newField);
            }

            List<FormTable> tables = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(srcSec.getId());
            for (FormTable tbl : tables) {
                FormTable newTbl = FormTable.builder()
                        .sectionId(savedSec.getId())
                        .tableKey(tbl.getTableKey())
                        .title(tbl.getTitle())
                        .showTitle(tbl.getShowTitle())
                        .isRepeatable(tbl.getIsRepeatable())
                        .displayOrder(tbl.getDisplayOrder())
                        .initialRows(tbl.getInitialRows())
                        .selectOptions(tbl.getSelectOptions())
                        .dateColumns(tbl.getDateColumns())
                        .numberColumns(tbl.getNumberColumns())
                        .textareaColumns(tbl.getTextareaColumns())
                        .textareaMaxLengths(tbl.getTextareaMaxLengths())
                        .build();
                FormTable savedTbl = formTableRepository.save(newTbl);

                List<FormField> colFields = formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(tbl.getId());
                for (FormField cf : colFields) {
                    FormField newCol = FormField.builder()
                            .sectionId(savedSec.getId())
                            .tableId(savedTbl.getId())
                            .fieldKey(cf.getFieldKey())
                            .label(cf.getLabel())
                            .fieldType(cf.getFieldType())
                            .kind(cf.getKind())
                            .isRequired(cf.getIsRequired())
                            .placeholder(cf.getPlaceholder())
                            .defaultValue(cf.getDefaultValue())
                            .validationRules(cf.getValidationRules())
                            .options(cf.getOptions())
                            .attachmentRules(cf.getAttachmentRules())
                            .displayOrder(cf.getDisplayOrder())
                            .build();
                    formFieldRepository.save(newCol);
                }
            }
        }
    }

    @Transactional
    public CompiledSchemaDto publishVersion(Long versionId, String publisher) {
        SchemaVersion version = schemaVersionRepository.findById(versionId)
                .orElseThrow(() -> new IllegalArgumentException("Version not found: " + versionId));

        FormSchema schema = formSchemaRepository.findById(version.getSchemaId())
                .orElseThrow(() -> new IllegalArgumentException("Schema not found: " + version.getSchemaId()));

        validateVersionIntegrity(versionId);

        CompiledSchemaDto compiled = schemaCompilerService.compile(versionId);
        try {
            version.setCompiledSchema(objectMapper.writeValueAsString(compiled));
        } catch (Exception e) {
            log.error("Failed to serialize compiled schema for version {}: {}", versionId, e.getMessage());
        }

        version.setStatus("PUBLISHED");
        version.setPublishedBy(publisher);
        version.setPublishedAt(LocalDateTime.now());
        schemaVersionRepository.save(version);

        schema.setActiveVersionId(version.getId());
        schema.setActiveVersionNumber(version.getVersionNumber());
        formSchemaRepository.save(schema);

        log.info("Successfully published schema '{}' version {} (ID: {})", schema.getName(), version.getVersionNumber(), version.getId());
        return compiled;
    }

    @Transactional
    public void rollbackVersion(Long schemaId, Long targetVersionId) {
        FormSchema schema = formSchemaRepository.findById(schemaId)
                .orElseThrow(() -> new IllegalArgumentException("Schema not found: " + schemaId));

        SchemaVersion target = schemaVersionRepository.findById(targetVersionId)
                .orElseThrow(() -> new IllegalArgumentException("Target version not found: " + targetVersionId));

        if (!target.getSchemaId().equals(schemaId)) {
            throw new IllegalArgumentException("Version does not belong to schema: " + schemaId);
        }

        if (!"PUBLISHED".equalsIgnoreCase(target.getStatus())) {
            throw new IllegalStateException("Cannot rollback to a non-published version.");
        }

        schema.setActiveVersionId(target.getId());
        schema.setActiveVersionNumber(target.getVersionNumber());
        formSchemaRepository.save(schema);
        log.info("Rolled back schema '{}' to version {} (ID: {})", schema.getName(), target.getVersionNumber(), target.getId());
    }

    @Transactional
    public void deleteVersion(Long versionId) {
        SchemaVersion version = schemaVersionRepository.findById(versionId)
                .orElseThrow(() -> new IllegalArgumentException("Version not found: " + versionId));

        validateNoSubmissionsForVersions(List.of(versionId), "This version");

        deleteVersionInternal(version);
    }

    @Transactional
    public void deleteSchema(Long schemaId) {
        FormSchema schema = formSchemaRepository.findById(schemaId)
                .orElseThrow(() -> new IllegalArgumentException("Schema not found: " + schemaId));

        List<SchemaVersion> versions = schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(schemaId);
        List<Long> versionIds = versions.stream().map(SchemaVersion::getId).toList();
        if (!versionIds.isEmpty()) {
            validateNoSubmissionsForVersions(versionIds, "This schema");
        }

        for (SchemaVersion v : versions) {
            deleteVersionInternal(v);
        }

        formSchemaRepository.deleteById(schemaId);
        log.info("Deleted schema '{}' (ID: {})", schema.getName(), schemaId);
    }

    private void deleteVersionInternal(SchemaVersion version) {
        Long versionId = version.getId();
        Long schemaId = version.getSchemaId();

        // 1. Delete all fields, tables, sections
        List<FormSection> sections = formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(versionId);
        for (FormSection s : sections) {
            List<FormTable> tables = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(s.getId());
            for (FormTable t : tables) {
                formFieldRepository.deleteByTableId(t.getId());
            }
            formTableRepository.deleteBySectionId(s.getId());
            formFieldRepository.deleteBySectionId(s.getId());
        }
        formSectionRepository.deleteByVersionId(versionId);

        // 2. Delete the version
        schemaVersionRepository.deleteById(versionId);

        // 3. Update active version on parent schema if this was the active version
        if (schemaId != null) {
            formSchemaRepository.findById(schemaId).ifPresent(parentSchema -> {
                if (versionId.equals(parentSchema.getActiveVersionId())) {
                    List<SchemaVersion> remainingVersions = schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(schemaId);
                    Optional<SchemaVersion> latestPublished = remainingVersions.stream()
                            .filter(v -> "PUBLISHED".equalsIgnoreCase(v.getStatus()))
                            .findFirst();
                    if (latestPublished.isPresent()) {
                        parentSchema.setActiveVersionId(latestPublished.get().getId());
                        parentSchema.setActiveVersionNumber(latestPublished.get().getVersionNumber());
                    } else if (!remainingVersions.isEmpty()) {
                        parentSchema.setActiveVersionId(remainingVersions.get(0).getId());
                        parentSchema.setActiveVersionNumber(remainingVersions.get(0).getVersionNumber());
                    } else {
                        parentSchema.setActiveVersionId(null);
                        parentSchema.setActiveVersionNumber(null);
                    }
                    formSchemaRepository.save(parentSchema);
                }
            });
        }
        log.info("Deleted version {}", versionId);
    }

    private void validateNoSubmissionsForVersions(List<Long> versionIds, String targetDescription) {
        if (versionIds == null || versionIds.isEmpty() || submissionServiceClient == null) {
            return;
        }

        Map<String, Long> counts;
        try {
            counts = submissionServiceClient.countBySchemaVersion(versionIds);
        } catch (Exception e) {
            log.error("Failed to verify submissions with submission-service for versions {}: {}", versionIds, e.getMessage(), e);
            throw new ResponseStatusException(
                    HttpStatus.CONFLICT,
                    "Cannot verify whether submissions exist for " + targetDescription.toLowerCase() + " because submission-service is unreachable. Deletion aborted for safety."
            );
        }

        if (counts == null) {
            throw new ResponseStatusException(
                    HttpStatus.CONFLICT,
                    "Invalid response received from submission-service when checking existing submissions. Deletion aborted for safety."
            );
        }

        long totalSubmissions = 0;
        for (Map.Entry<?, ?> entry : counts.entrySet()) {
            if (entry.getValue() != null) {
                long count = ((Number) entry.getValue()).longValue();
                if (count > 0) {
                    totalSubmissions += count;
                }
            }
        }

        if (totalSubmissions > 0) {
            String unit = totalSubmissions == 1 ? "submission" : "submissions";
            throw new ResponseStatusException(
                    HttpStatus.CONFLICT,
                    targetDescription + " has " + totalSubmissions + " " + unit + " and cannot be deleted."
            );
        }
    }

    @Transactional
    public void deleteAllSchemasForUniversity(Long universityId) {
        List<FormSchema> schemas = formSchemaRepository.findAll();
        for (FormSchema s : schemas) {
            deleteSchema(s.getId());
        }
        log.info("Deleted all schemas");
    }

    public static boolean isAuditorSection(FormSection section) {
        if (section == null) return false;
        if (section.getOwnerRole() != null && section.getOwnerRole().toLowerCase().contains("auditor")) {
            return true;
        }
        if (section.getSectionKey() != null && section.getSectionKey().toLowerCase().contains("auditor")) {
            return true;
        }
        if (section.getTitle() != null && section.getTitle().toLowerCase().contains("auditor")) {
            return true;
        }
        return false;
    }

    private void validateVersionIntegrity(Long versionId) {
        List<FormSection> sections = formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(versionId);
        if (sections.isEmpty()) {
            throw new IllegalStateException("Cannot publish a schema with 0 sections.");
        }

        boolean hasAuditorSection = false;
        for (FormSection s : sections) {
            if (isAuditorSection(s)) {
                hasAuditorSection = true;
                break;
            }
        }
        if (!hasAuditorSection) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST,
                    "Cannot publish form: Every form must contain at least one section designated for the Auditor (Auditor Section). Please configure an Auditor section before publishing."
            );
        }

        Set<String> sectionKeys = new HashSet<>();
        Set<String> versionTableKeys = new HashSet<>();

        for (FormSection s : sections) {
            if (s.getSectionKey() == null || s.getSectionKey().isBlank()) {
                s.setSectionKey(toSnakeCase(s.getTitle()));
                formSectionRepository.save(s);
            }
            if (!sectionKeys.add(s.getSectionKey().toLowerCase())) {
                String baseKey = s.getSectionKey();
                int suffix = 1;
                String newKey;
                do {
                    newKey = baseKey + "_" + (++suffix);
                } while (!sectionKeys.add(newKey.toLowerCase()));
                s.setSectionKey(newKey);
                formSectionRepository.save(s);
                log.info("Auto-healed duplicate section key to: {}", newKey);
            }

            List<FormTable> tables = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(s.getId());
            for (FormTable t : tables) {
                if (t.getTableKey() == null || t.getTableKey().isBlank()) {
                    t.setTableKey(toSnakeCase(t.getTitle()));
                    formTableRepository.save(t);
                }
                if (!versionTableKeys.add(t.getTableKey().toLowerCase())) {
                    String baseKey = t.getTableKey();
                    String newKey = s.getSectionKey() + "_" + baseKey;
                    int suffix = 1;
                    while (!versionTableKeys.add(newKey.toLowerCase())) {
                        newKey = baseKey + "_" + (++suffix);
                    }
                    t.setTableKey(newKey);
                    formTableRepository.save(t);
                    log.info("Auto-healed duplicate table key in version {} section {} to: {}", versionId, s.getTitle(), newKey);
                }

                List<FormField> columns = formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(t.getId());
                if (columns.isEmpty()) {
                    throw new IllegalStateException("Table '" + t.getTitle() + "' must have at least one column.");
                }
            }
        }
    }

    @Transactional
    public FormSchema cloneSchema(Long sourceSchemaId, String newName, String newAuditType, Long universityId, String assignedSchools, String createdBy) {
        FormSchema source = formSchemaRepository.findById(sourceSchemaId)
                .orElseThrow(() -> new IllegalArgumentException("Source schema not found: " + sourceSchemaId));

        Long targetUniId = universityId != null ? universityId : source.getUniversityId();
        String targetType = (newAuditType != null && !newAuditType.isBlank()) ? newAuditType.trim().toLowerCase() : source.getAuditType();
        String targetName = (newName != null && !newName.isBlank()) ? newName.trim() : (source.getName() + " (Copy)");
        String targetAssigned = (assignedSchools != null && !assignedSchools.isBlank()) ? assignedSchools.trim() : "ALL";

        validateSchoolAssignments(null, targetType, targetAssigned);

        FormSchema newSchema = FormSchema.builder()
                .universityId(targetUniId)
                .auditType(targetType)
                .name(targetName)
                .description(source.getDescription())
                .assignedSchools(targetAssigned)
                .status("ACTIVE")
                .build();

        FormSchema savedSchema = formSchemaRepository.save(newSchema);

        // Find source version to clone from (prefer active version, or latest published, or latest draft)
        Long sourceVersionId = source.getActiveVersionId();
        List<SchemaVersion> sourceVersions = schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(sourceSchemaId);
        if (sourceVersionId == null && !sourceVersions.isEmpty()) {
            sourceVersionId = sourceVersions.get(0).getId();
        }

        SchemaVersion draft = SchemaVersion.builder()
                .schemaId(savedSchema.getId())
                .versionNumber(1)
                .status("DRAFT")
                .academicYear(sourceVersions.isEmpty() ? resolveDefaultAcademicYear() : sourceVersions.get(0).getAcademicYear())
                .title(targetName)
                .ownerRole("administrative".equalsIgnoreCase(targetType) ? "administrative" : "director-schools")
                .publishedBy(createdBy != null ? createdBy : "admin")
                .build();

        SchemaVersion savedDraft = schemaVersionRepository.save(draft);

        if (sourceVersionId != null) {
            cloneVersionTree(sourceVersionId, savedDraft.getId());
        }

        return savedSchema;
    }

    @Transactional
    public FormTable copyTable(Long sourceTableId, Long targetSectionId, String newTitle, String newTableKey) {
        FormTable sourceTable = formTableRepository.findById(sourceTableId)
                .orElseThrow(() -> new IllegalArgumentException("Source table not found: " + sourceTableId));

        FormSection targetSection = formSectionRepository.findById(targetSectionId)
                .orElseThrow(() -> new IllegalArgumentException("Target section not found: " + targetSectionId));

        List<FormTable> existingInTarget = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(targetSectionId);

        String finalTitle = (newTitle != null && !newTitle.isBlank()) ? newTitle.trim() : (sourceTable.getTitle() + " (Copy)");
        String finalKey = (newTableKey != null && !newTableKey.isBlank()) ? newTableKey.trim() : (sourceTable.getTableKey() + "_copy_" + System.currentTimeMillis() % 10000);

        FormTable newTable = FormTable.builder()
                .sectionId(targetSectionId)
                .title(finalTitle)
                .tableKey(finalKey)
                .showTitle(sourceTable.getShowTitle())
                .isRepeatable(sourceTable.getIsRepeatable())
                .displayOrder(existingInTarget.size() + 1)
                .initialRows(sourceTable.getInitialRows())
                .selectOptions(sourceTable.getSelectOptions())
                .dateColumns(sourceTable.getDateColumns())
                .numberColumns(sourceTable.getNumberColumns())
                .textareaColumns(sourceTable.getTextareaColumns())
                .textareaMaxLengths(sourceTable.getTextareaMaxLengths())
                .build();

        FormTable savedTable = formTableRepository.save(newTable);

        List<FormField> sourceColumns = formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(sourceTableId);
        for (FormField col : sourceColumns) {
            FormField newCol = FormField.builder()
                    .sectionId(targetSectionId)
                    .tableId(savedTable.getId())
                    .fieldKey(col.getFieldKey())
                    .label(col.getLabel())
                    .fieldType(col.getFieldType())
                    .kind(col.getKind())
                    .isRequired(col.getIsRequired())
                    .placeholder(col.getPlaceholder())
                    .defaultValue(col.getDefaultValue())
                    .validationRules(col.getValidationRules())
                    .options(col.getOptions())
                    .attachmentRules(col.getAttachmentRules())
                    .displayOrder(col.getDisplayOrder())
                    .build();
            formFieldRepository.save(newCol);
        }

        log.info("Copied table '{}' (ID: {}) to section '{}' (ID: {}) with {} columns",
                sourceTable.getTitle(), sourceTableId, targetSection.getTitle(), targetSectionId, sourceColumns.size());
        return savedTable;
    }

    @Transactional(readOnly = true)
    public List<Map<String, Object>> getAvailableTablesForUniversity(Long universityId) {
        List<FormSchema> schemas = formSchemaRepository.findAll();
        List<Map<String, Object>> result = new ArrayList<>();

        for (FormSchema schema : schemas) {
            Long activeVersionId = schema.getActiveVersionId();
            if (activeVersionId == null) {
                List<SchemaVersion> versions = schemaVersionRepository.findBySchemaIdOrderByVersionNumberDesc(schema.getId());
                if (!versions.isEmpty()) {
                    activeVersionId = versions.get(0).getId();
                }
            }
            if (activeVersionId == null) continue;

            List<FormSection> sections = formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(activeVersionId);
            for (FormSection sec : sections) {
                List<FormTable> tables = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(sec.getId());
                for (FormTable t : tables) {
                    List<FormField> cols = formFieldRepository.findByTableIdOrderByDisplayOrderAscIdAsc(t.getId());
                    Map<String, Object> tMap = new LinkedHashMap<>();
                    tMap.put("tableId", t.getId());
                    tMap.put("title", t.getTitle());
                    tMap.put("tableKey", t.getTableKey());
                    tMap.put("isRepeatable", t.getIsRepeatable());
                    tMap.put("columnCount", cols.size());
                    tMap.put("sectionId", sec.getId());
                    tMap.put("sectionTitle", sec.getTitle());
                    tMap.put("schemaId", schema.getId());
                    tMap.put("schemaName", schema.getName());
                    tMap.put("auditType", schema.getAuditType());
                    tMap.put("assignedSchools", schema.getAssignedSchools());
                    result.add(tMap);
                }
            }
        }
        return result;
    }

    @Transactional
    public List<FormTable> importBatchTables(Long sectionId, BatchTableImportRequestDto req) {
        FormSection section = formSectionRepository.findById(sectionId)
                .orElseThrow(() -> new IllegalArgumentException("Section not found: " + sectionId));

        if (req == null || req.getTables() == null || req.getTables().isEmpty()) {
            throw new IllegalArgumentException("No tables provided for import");
        }

        // Collect existing table keys across ALL sections of this schema version
        Set<String> existingKeys = new HashSet<>();
        if (section.getVersionId() != null) {
            List<FormSection> siblingSections = formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(section.getVersionId());
            List<Long> sectionIds = siblingSections.stream().map(FormSection::getId).toList();
            List<FormTable> allTablesInVersion = formTableRepository.findBySectionIdIn(sectionIds);
            for (FormTable t : allTablesInVersion) {
                if (t.getTableKey() != null) existingKeys.add(t.getTableKey().toLowerCase());
            }
        } else {
            List<FormTable> existingTables = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(sectionId);
            for (FormTable t : existingTables) {
                if (t.getTableKey() != null) existingKeys.add(t.getTableKey().toLowerCase());
            }
        }

        List<FormTable> existingInThisSection = formTableRepository.findBySectionIdOrderByDisplayOrderAscIdAsc(sectionId);
        int currentOrder = existingInThisSection.size();
        List<FormTable> createdTables = new ArrayList<>();

        for (BatchTableImportRequestDto.TableImportItem tableItem : req.getTables()) {
            if (tableItem.getTitle() == null || tableItem.getTitle().isBlank()) {
                continue;
            }

            String baseKey = (tableItem.getTableKey() != null && !tableItem.getTableKey().isBlank())
                    ? toSnakeCase(tableItem.getTableKey())
                    : toSnakeCase(tableItem.getTitle());

            String candidateKey = baseKey;
            if (existingKeys.contains(candidateKey.toLowerCase())) {
                candidateKey = toSnakeCase(section.getSectionKey() != null ? section.getSectionKey() : section.getTitle()) + "_" + baseKey;
            }
            int suffix = 1;
            while (existingKeys.contains(candidateKey.toLowerCase())) {
                candidateKey = baseKey + "_" + (++suffix);
            }
            existingKeys.add(candidateKey.toLowerCase());

            FormTable newTable = FormTable.builder()
                    .sectionId(sectionId)
                    .title(tableItem.getTitle().trim())
                    .tableKey(candidateKey)
                    .isRepeatable(tableItem.getIsRepeatable() != null ? tableItem.getIsRepeatable() : true)
                    .showTitle(tableItem.getShowTitle() != null ? tableItem.getShowTitle() : true)
                    .displayOrder(++currentOrder)
                    .build();

            FormTable savedTable = formTableRepository.save(newTable);
            createdTables.add(savedTable);

            if (tableItem.getFields() != null && !tableItem.getFields().isEmpty()) {
                Set<String> existingColKeys = new HashSet<>();
                int fieldOrder = 0;

                for (BatchTableImportRequestDto.FieldImportItem fieldItem : tableItem.getFields()) {
                    if (fieldItem.getLabel() == null || fieldItem.getLabel().isBlank()) {
                        continue;
                    }

                    String colBaseKey = (fieldItem.getFieldKey() != null && !fieldItem.getFieldKey().isBlank())
                            ? toSnakeCase(fieldItem.getFieldKey())
                            : toSnakeCase(fieldItem.getLabel());

                    String colCandidateKey = colBaseKey;
                    int colSuffix = 1;
                    while (existingColKeys.contains(colCandidateKey.toLowerCase())) {
                        colCandidateKey = colBaseKey + "_" + (++colSuffix);
                    }
                    existingColKeys.add(colCandidateKey.toLowerCase());

                    String fieldType = (fieldItem.getFieldType() != null && !fieldItem.getFieldType().isBlank())
                            ? fieldItem.getFieldType().trim().toUpperCase()
                            : "TEXT";

                    String optionsJson = null;
                    if (fieldItem.getOptions() != null && !fieldItem.getOptions().isEmpty()) {
                        try {
                            optionsJson = objectMapper.writeValueAsString(fieldItem.getOptions());
                        } catch (Exception e) {
                            optionsJson = null;
                        }
                    } else if (fieldItem.getOptionsString() != null && !fieldItem.getOptionsString().isBlank()) {
                        try {
                            List<String> optList = Arrays.stream(fieldItem.getOptionsString().split(","))
                                    .map(String::trim)
                                    .filter(s -> !s.isEmpty())
                                    .toList();
                            optionsJson = objectMapper.writeValueAsString(optList);
                        } catch (Exception e) {
                            optionsJson = null;
                        }
                    }

                    FormField col = FormField.builder()
                            .sectionId(sectionId)
                            .tableId(savedTable.getId())
                            .label(fieldItem.getLabel().trim())
                            .fieldKey(colCandidateKey)
                            .fieldType(fieldType)
                            .isRequired(fieldItem.getIsRequired() != null ? fieldItem.getIsRequired() : false)
                            .placeholder(fieldItem.getPlaceholder())
                            .defaultValue(fieldItem.getDefaultValue())
                            .options(optionsJson)
                            .displayOrder(++fieldOrder)
                            .build();

                    formFieldRepository.save(col);
                }
            } else {
                // If no columns provided, auto-create a default Sr No column
                FormField srNo = FormField.builder()
                        .sectionId(sectionId)
                        .tableId(savedTable.getId())
                        .fieldKey("sr_no")
                        .label("Sr No")
                        .fieldType("TEXT")
                        .displayOrder(1)
                        .isRequired(false)
                        .build();
                formFieldRepository.save(srNo);
            }
        }

        log.info("Batch imported {} tables into section ID {}", createdTables.size(), sectionId);
        return createdTables;
    }

    @Transactional
    public List<FormSection> importFullSchema(Long versionId, BatchSchemaImportRequestDto req) {
        SchemaVersion version = schemaVersionRepository.findById(versionId)
                .orElseThrow(() -> new IllegalArgumentException("Version not found: " + versionId));

        if (req == null || req.getSections() == null || req.getSections().isEmpty()) {
            throw new IllegalArgumentException("No sections provided for schema import");
        }

        List<FormSection> existingSections = formSectionRepository.findByVersionIdOrderByDisplayOrderAscIdAsc(versionId);
        int currentSectionOrder = existingSections.size();
        Set<String> existingSectionKeys = new HashSet<>();
        for (FormSection s : existingSections) {
            if (s.getSectionKey() != null) existingSectionKeys.add(s.getSectionKey().toLowerCase());
        }

        List<FormSection> createdSections = new ArrayList<>();

        for (BatchSchemaImportRequestDto.SectionImportItem secItem : req.getSections()) {
            if (secItem.getTitle() == null || secItem.getTitle().isBlank()) {
                continue;
            }

            String baseSecKey = (secItem.getSectionKey() != null && !secItem.getSectionKey().isBlank())
                    ? toSnakeCase(secItem.getSectionKey())
                    : toSnakeCase(secItem.getTitle());

            String candidateSecKey = baseSecKey;
            int secSuffix = 1;
            while (existingSectionKeys.contains(candidateSecKey.toLowerCase())) {
                candidateSecKey = baseSecKey + "_" + (++secSuffix);
            }
            existingSectionKeys.add(candidateSecKey.toLowerCase());

            String secNumber = secItem.getSectionNumber();
            if (secNumber == null || secNumber.isBlank()) {
                secNumber = String.valueOf((char) ('A' + currentSectionOrder));
            }

            FormSection newSec = FormSection.builder()
                    .versionId(versionId)
                    .title(secItem.getTitle().trim())
                    .sectionNumber(secNumber)
                    .sectionKey(candidateSecKey)
                    .ownerRole(secItem.getOwnerRole() != null && !secItem.getOwnerRole().isBlank() ? secItem.getOwnerRole() : "director-schools")
                    .description(secItem.getDescription())
                    .displayOrder(++currentSectionOrder)
                    .build();

            FormSection savedSection = formSectionRepository.save(newSec);
            createdSections.add(savedSection);

            if (secItem.getTables() != null && !secItem.getTables().isEmpty()) {
                BatchTableImportRequestDto tblDto = BatchTableImportRequestDto.builder()
                        .tables(secItem.getTables())
                        .build();
                importBatchTables(savedSection.getId(), tblDto);
            }
        }

        log.info("Batch imported {} sections into version ID {}", createdSections.size(), versionId);
        return createdSections;
    }

    public static String toSnakeCase(String label) {
        if (label == null) return "field";
        String s = label.replaceAll("[^a-zA-Z0-9\\s]", "").trim().replaceAll("\\s+", "_").toLowerCase();
        return s.isBlank() ? "field_" + System.currentTimeMillis() : s;
    }

    private String resolveDefaultAcademicYear() {
        int year = java.time.LocalDate.now().getYear();
        int month = java.time.LocalDate.now().getMonthValue();
        int startYear = month >= 6 ? year : year - 1;
        return startYear + "-" + String.valueOf(startYear + 1).substring(2);
    }
}
