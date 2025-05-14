package com.example.Hallen.controller;

import com.example.Hallen.model.Mieter;
import com.example.Hallen.service.MieterService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/mieter")
public class MieterController {

    private final MieterService service;

    public MieterController(MieterService service) {
        this.service = service;
    }

    @GetMapping
    public List<Mieter> getAll() {
        return service.getAll();
    }

    @PostMapping
    public Mieter create(@RequestBody Mieter mieter) {
        return service.save(mieter);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
