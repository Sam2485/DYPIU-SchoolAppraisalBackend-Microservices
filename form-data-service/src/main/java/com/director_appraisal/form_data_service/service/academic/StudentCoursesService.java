package com.director_appraisal.form_data_service.service.academic;

import com.director_appraisal.form_data_service.model.academic.StudentCourses;
import com.director_appraisal.form_data_service.repository.academic.StudentCoursesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StudentCoursesService {

    private final StudentCoursesRepository repository;

    public List<StudentCourses> getBySubmissionId(Long submissionId) {
        return repository.findBySubmissionId(submissionId);
    }

    @Transactional
    public List<StudentCourses> saveAll(Long submissionId, List<StudentCourses> rows) {
        repository.deleteBySubmissionId(submissionId);
        for (StudentCourses row : rows) {
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
