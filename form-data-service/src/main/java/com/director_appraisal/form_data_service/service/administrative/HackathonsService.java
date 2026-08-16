package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.Hackathons;
import com.director_appraisal.form_data_service.repository.administrative.HackathonsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HackathonsService {

    private final HackathonsRepository repository;

    public List<Hackathons> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<Hackathons> saveAll(Long submissionId, List<Hackathons> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (Hackathons row : rows) {
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
