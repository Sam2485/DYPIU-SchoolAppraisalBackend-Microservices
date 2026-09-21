package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.model.config.University;
import com.director_appraisal.form_data_service.repository.config.UniversityRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UniversityService {

    public static final String DEFAULT_CODE = "dypiu";
    public static final String DEFAULT_NAME = "D Y Patil International University, Akurdi, Pune";
    public static final String DEFAULT_DOMAIN = "dypiu.ac.in";
    public static final String DEFAULT_ADDRESS = "Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044";
    public static final String DEFAULT_ESTABLISHMENT_ACT = "Maharashtra State Act No. VI of 2019";
    public static final String DEFAULT_STATUS = "ACTIVE";

    private final UniversityRepository universityRepository;

    @PostConstruct
    public void initDefaultInstitution() {
        try {
            if (universityRepository.count() == 0) {
                log.info("[STARTUP] No institution record found. Initializing default institution profile.");
                createDefaultInstitution();
            }
        } catch (Exception e) {
            log.warn("[STARTUP] Notice: Default institution initialization at startup will be handled lazily if needed: {}", e.getMessage());
        }
    }

    @Transactional(readOnly = true)
    public List<University> getAllUniversities(boolean includeArchived) {
        if (includeArchived) {
            return universityRepository.findAll();
        }
        return universityRepository.findAllActive();
    }

    @Transactional(readOnly = true)
    public List<University> getAllUniversities() {
        return getAllUniversities(false);
    }

    @Transactional(readOnly = true)
    public Optional<University> getById(Long id) {
        return universityRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public Optional<University> getByCode(String code) {
        if (code == null || code.isBlank()) return Optional.empty();
        return universityRepository.findByCodeIgnoreCase(code.trim());
    }

    @Transactional
    public University getInstitution() {
        Optional<University> existing = universityRepository.findAllActive().stream().findFirst()
                .or(() -> universityRepository.findAll().stream().findFirst());
        if (existing.isPresent()) {
            return existing.get();
        }
        return createDefaultInstitution();
    }

    @Transactional
    public University createDefaultInstitution() {
        Optional<University> existing = universityRepository.findAllActive().stream().findFirst()
                .or(() -> universityRepository.findAll().stream().findFirst());
        if (existing.isPresent()) {
            return existing.get();
        }

        try {
            University defaultUni = University.builder()
                    .name(DEFAULT_NAME)
                    .code(DEFAULT_CODE)
                    .domain(DEFAULT_DOMAIN)
                    .address(DEFAULT_ADDRESS)
                    .establishmentAct(DEFAULT_ESTABLISHMENT_ACT)
                    .status(DEFAULT_STATUS)
                    .build();
            return universityRepository.save(defaultUni);
        } catch (DataIntegrityViolationException e) {
            log.warn("Concurrent creation detected for default institution code '{}'. Re-reading from database.", DEFAULT_CODE);
            return universityRepository.findByCodeIgnoreCase(DEFAULT_CODE)
                    .or(() -> universityRepository.findAll().stream().findFirst())
                    .orElseThrow(() -> new IllegalStateException("Failed to load or initialize default institution", e));
        }
    }

    @Transactional
    public University createUniversity(University university) {
        if (university.getCode() == null || university.getCode().isBlank()) {
            throw new IllegalArgumentException("University code is required.");
        }
        String cleanCode = university.getCode().trim().toLowerCase();
        if (universityRepository.existsByCodeIgnoreCase(cleanCode)) {
            throw new IllegalArgumentException("University code '" + cleanCode + "' already exists.");
        }
        university.setCode(cleanCode);
        return universityRepository.save(university);
    }

    @Transactional
    public University updateUniversity(Long id, University req) {
        University existing = (id != null ? universityRepository.findById(id) : Optional.<University>empty())
                .orElseGet(this::getInstitution);

        if (req.getName() != null && !req.getName().isBlank()) {
            existing.setName(req.getName());
        }
        if (req.getDomain() != null) {
            existing.setDomain(req.getDomain());
        }
        if (req.getAddress() != null) {
            existing.setAddress(req.getAddress());
        }
        if (req.getEstablishmentAct() != null) {
            existing.setEstablishmentAct(req.getEstablishmentAct());
        }
        if (req.getLogoUrl() != null) {
            existing.setLogoUrl(req.getLogoUrl());
        }
        if (req.getIqacLogoUrl() != null) {
            existing.setIqacLogoUrl(req.getIqacLogoUrl());
        }
        if (req.getPrimaryColor() != null) {
            existing.setPrimaryColor(req.getPrimaryColor());
        }
        if (req.getThemeBranding() != null) {
            existing.setThemeBranding(req.getThemeBranding());
        }
        if (req.getStatus() != null) {
            existing.setStatus(req.getStatus());
        }

        return universityRepository.save(existing);
    }
}
