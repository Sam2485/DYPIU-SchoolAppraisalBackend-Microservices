package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.LibraryInfrastructure;
import com.director_appraisal.form_data_service.repository.administrative.LibraryInfrastructureRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LibraryInfrastructureService {

    private final LibraryInfrastructureRepository repository;

    public List<LibraryInfrastructure> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<LibraryInfrastructure> saveAll(Long submissionId, List<LibraryInfrastructure> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (LibraryInfrastructure row : rows) {
            row.setId(null);
            row.setSubmissionId(submissionId);
        }
        return repository.saveAll(rows);
    }

    @Transactional
    public void deleteBySubmissionId(Long submissionId) {
        repository.deleteBySubmissionId(submissionId);
    }
}
