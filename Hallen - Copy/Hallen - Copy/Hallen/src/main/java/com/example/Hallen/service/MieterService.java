package com.example.Hallen.service;

import com.example.Hallen.model.Mieter;
import com.example.Hallen.repository.MieterRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MieterService {

    private final MieterRepository repository;

    public MieterService(MieterRepository repository) {
        this.repository = repository;
    }

    public List<Mieter> getAll() {
        return repository.findAll();
    }

    public Mieter save(Mieter mieter) {
        return repository.save(mieter);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}
