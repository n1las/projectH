package com.example.Hallen.repository;

import com.example.Hallen.model.Mieter;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MieterRepository extends JpaRepository<Mieter, Long> {
    Optional<Mieter> findByUsername(String username);

}
