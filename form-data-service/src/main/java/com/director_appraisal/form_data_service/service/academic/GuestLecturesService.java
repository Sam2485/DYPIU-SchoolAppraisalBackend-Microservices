package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.GuestLectures;
import com.director_appraisal.form_data_service.repository.academic.GuestLecturesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class GuestLecturesService {

    private final GuestLecturesRepository repository;

    public List<GuestLectures> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<GuestLectures> saveAll(Long submissionId, List<GuestLectures> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (GuestLectures row : rows) {
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
