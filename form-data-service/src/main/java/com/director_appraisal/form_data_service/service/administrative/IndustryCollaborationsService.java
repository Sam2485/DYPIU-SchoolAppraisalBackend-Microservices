package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.IndustryCollaborations;
import com.director_appraisal.form_data_service.repository.administrative.IndustryCollaborationsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class IndustryCollaborationsService {

    private final IndustryCollaborationsRepository repository;

    public List<IndustryCollaborations> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<IndustryCollaborations> saveAll(Long submissionId, List<IndustryCollaborations> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (IndustryCollaborations row : rows) {
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
