package com.example.Hallen.service;

import com.example.Hallen.model.Mieter;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.MieterRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
public class MieterService {

    private final MieterRepository repository;

    public MieterService(MieterRepository repository) {
        this.repository = repository;
    }

    public List<Mieter> getAll() {
        return repository.findAll();
    }
    public Mieter getMieterById(Long id){
        return repository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Mieter not found with ID" + id));
    }
    public Mieter update(Long id, Mieter updatedMieter) {
        Mieter existing = repository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Mieter not found with ID " + id));

        existing.setUsername(updatedMieter.getUsername());
        existing.setPasswort(updatedMieter.getPasswort());
        existing.setAdmin(updatedMieter.getAdmin());

        return repository.save(existing);
    }



    public Mieter save(Mieter mieter) {
        return repository.save(mieter);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }

    public Mieter findByUsername(String username) {
        // Datenbankabfrage, z.B. über Repository
        return repository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("Mieter with username: " + username + "was not found"));
    }
}
