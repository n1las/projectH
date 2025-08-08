package com.example.Hallen.repository;

import com.example.Hallen.model.Halle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HallenRepository extends JpaRepository<Halle, Long> {
    Halle findById(long id);

}
