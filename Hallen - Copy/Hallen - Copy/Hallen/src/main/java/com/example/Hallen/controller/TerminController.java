package com.example.Hallen.controller;

import com.example.Hallen.model.Termin;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/termine")
@CrossOrigin
public class TerminController {
    @Autowired
    private TerminService service;

    @GetMapping
    public List<Termin> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public Termin getById(@PathVariable Long id) {
        return service.getById(id).orElseThrow(() -> new RuntimeException("Termin not found"));
    }

    @PostMapping
    public Termin create(@RequestBody Termin termin) {
        return service.create(termin);
    }

    @PutMapping("/{id}")
    public Termin update(@PathVariable Long id, @RequestBody Termin termin) {
        return service.update(id, termin);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
