package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.ResearchFunds;
import com.director_appraisal.form_data_service.repository.academic.ResearchFundsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ResearchFundsService {

    private final ResearchFundsRepository repository;

    public List<ResearchFunds> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<ResearchFunds> saveAll(Long submissionId, List<ResearchFunds> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (ResearchFunds row : rows) {
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
