package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.SportsActivities;
import com.director_appraisal.form_data_service.repository.administrative.SportsActivitiesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SportsActivitiesService {

    private final SportsActivitiesRepository repository;

    public List<SportsActivities> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<SportsActivities> saveAll(Long submissionId, List<SportsActivities> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (SportsActivities row : rows) {
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
