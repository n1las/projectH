package com.example.Hallen.controller;

import com.example.Hallen.dto.LoginRequest;
import com.example.Hallen.model.Mieter;
import com.example.Hallen.service.MieterService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/Mieter")
public class MieterController {

    private final MieterService service;

    public MieterController(MieterService service) {
        this.service = service;
    }

    @GetMapping()
    public List<Mieter> getAll() {
        return service.getAll();
    }
    @GetMapping("/{id}")
    public Mieter getById(@PathVariable Long id){
        return service.getMieterById(id);
    }
    @PutMapping("/{id}")
    public Mieter update(@PathVariable Long id, @RequestBody Mieter updatedMieter) {
        return service.update(id, updatedMieter);
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
