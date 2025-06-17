package com.example.Hallen.controller;

import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/termine")
@CrossOrigin
public class TerminController {
    @Autowired
    private TerminService service;
    private TerminRepository terminRepository;

    @GetMapping
    public List<Termin> getAll() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public Termin getById(@PathVariable Long id) {
        return service.getById(id).orElseThrow(() -> new RuntimeException("Termin not found"));
    }
    @GetMapping("/mieter/{mieterId}")
    public List<Termin> getByMieterId(@PathVariable Long mieterId) {
        return service.findByMieterId(mieterId);
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
    @GetMapping("/check")
    public ResponseEntity<Boolean> checkAvailability(
            @RequestParam Long hallenId,
            @RequestParam String anfang,
            @RequestParam String ende) {
        try {
            LocalDateTime start = LocalDateTime.parse(anfang);
            LocalDateTime end = LocalDateTime.parse(ende);
            boolean isAvailable = service.isTerminAvailable(hallenId, start, end);
            return ResponseEntity.ok(isAvailable);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(false); // 400 if parsing fails or error occurs
        }
    }
    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteAppointment(
            @RequestParam("start") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime start) {

        boolean deleted = service.deleteByStart(start);
        if (deleted) {
            return ResponseEntity.ok("Appointment deleted successfully.");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Appointment not found.");
        }
    }
}
