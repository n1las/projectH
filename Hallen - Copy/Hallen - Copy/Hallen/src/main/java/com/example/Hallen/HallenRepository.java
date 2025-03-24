package com.example.Hallen;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HallenRepository extends JpaRepository<Halle, Long> {
    Halle findById(long id);
}
