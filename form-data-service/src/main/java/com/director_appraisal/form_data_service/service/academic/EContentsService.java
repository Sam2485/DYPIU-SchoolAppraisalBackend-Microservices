package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.EContents;
import com.director_appraisal.form_data_service.repository.academic.EContentsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EContentsService {

    private final EContentsRepository repository;

    public List<EContents> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<EContents> saveAll(Long submissionId, List<EContents> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (EContents row : rows) {
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
