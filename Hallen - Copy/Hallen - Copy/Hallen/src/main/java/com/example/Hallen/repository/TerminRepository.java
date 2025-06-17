package com.example.Hallen.repository;

import com.example.Hallen.model.Termin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface TerminRepository extends JpaRepository<Termin, Long> {
    @Query("SELECT CASE WHEN COUNT(t) > 0 THEN true ELSE false END FROM Termin t " +
            "WHERE t.hallenId = :hallenId AND " +
            "(t.anfang < :ende AND t.ende > :anfang)")
    boolean existsByHallenIdAndOverlapping(
            @Param("hallenId") Long hallenId,
            @Param("anfang") LocalDateTime anfang,
            @Param("ende") LocalDateTime ende
    );
    List<Termin> findByHallenId(Long hallenId);

    Optional<Termin> findByStart(LocalDateTime start);

}
