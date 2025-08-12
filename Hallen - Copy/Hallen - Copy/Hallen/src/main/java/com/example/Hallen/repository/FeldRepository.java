package com.example.Hallen.repository;

import com.example.Hallen.model.Feld;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FeldRepository extends JpaRepository<Feld, Long> {
    List<Feld> findByHalleId(Long halleId);


}
