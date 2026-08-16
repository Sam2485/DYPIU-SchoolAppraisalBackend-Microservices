package com.director_appraisal.form_data_service.service.administrative;

import com.director_appraisal.form_data_service.model.administrative.SupportingStaff;
import com.director_appraisal.form_data_service.repository.administrative.SupportingStaffRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SupportingStaffService {

    private final SupportingStaffRepository repository;

    public List<SupportingStaff> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<SupportingStaff> saveAll(Long submissionId, List<SupportingStaff> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (SupportingStaff row : rows) {
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
