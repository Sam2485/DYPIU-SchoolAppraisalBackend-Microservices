package com.director_appraisal.submission_service.repository;

import com.director_appraisal.submission_service.model.Snapshot;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SnapshotRepository extends JpaRepository<Snapshot, Long> {
    List<Snapshot> findBySubmissionIdOrderByVersionDesc(Long submissionId);
    void deleteBySubmissionId(Long submissionId);
}
