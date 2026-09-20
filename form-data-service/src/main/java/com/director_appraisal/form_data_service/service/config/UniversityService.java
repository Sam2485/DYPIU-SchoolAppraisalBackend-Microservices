package com.director_appraisal.form_data_service.service.config;

import com.director_appraisal.form_data_service.model.config.University;
import com.director_appraisal.form_data_service.repository.config.UniversityRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UniversityService {

    private final UniversityRepository universityRepository;

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

    @Transactional(readOnly = true)
    public University getInstitution() {
        return universityRepository.findAllActive().stream().findFirst()
                .or(() -> universityRepository.findAll().stream().findFirst())
                .orElseGet(() -> {
                    University defaultUni = University.builder()
                            .name("D Y Patil International University, Akurdi, Pune")
                            .code("dypiu")
                            .domain("dypiu.ac.in")
                            .address("Sector 29, Nigdi Pradhikaran, Akurdi, Pune 411044")
                            .establishmentAct("Maharashtra State Act No. VI of 2019")
                            .status("ACTIVE")
                            .build();
                    return universityRepository.save(defaultUni);
                });
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
