package com.example.Hallen.service;

import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TerminService {
    @Autowired
    private TerminRepository repository;

    public List<Termin> getAll() {
        return repository.findAll();
    }

    public Optional<Termin> getById(Long id) {
        return repository.findById(id);
    }

    public Termin create(Termin termin) {
        return repository.save(termin);
    }

    public Termin update(Long id, Termin termin) {
        termin.setId(id);
        return repository.save(termin);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
