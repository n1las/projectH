package com.example.Hallen.controller;

import com.example.Hallen.dto.SerienTerminRequest;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/termine")
@CrossOrigin
public class TerminController {
    @Autowired
    private TerminService service;
    @Autowired
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
    @PatchMapping("/{id}/confirm")
    public ResponseEntity<?> confirmTermin(@PathVariable Long id) {
        Optional<Termin> optionalTermin = terminRepository.findById(id);
        if (optionalTermin.isPresent()) {
            Termin termin = optionalTermin.get();
            termin.setConfirmed(true);
            terminRepository.save(termin);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteTermin(
            @RequestParam Long hallenId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime anfang) {

        boolean deleted = service.deleteByHallenIdAndAnfang(hallenId, anfang);

        if (deleted) {
            return ResponseEntity.ok("Termin deleted successfully! 🧹");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No matching Termin found. ❌");
        }
    }

    @PostMapping("serienTermin")
    public ResponseEntity<List<Termin>> createSerienTermin(@RequestBody SerienTerminRequest str){
        List<Termin> erzeugteTermine = new ArrayList<>();
        LocalDate serienDatum = str.getSerieAnfang();

        while(!serienDatum.isAfter(str.getSerieEnde())){
            LocalDateTime anfang = LocalDateTime.of(serienDatum, str.getAnfang());
            LocalDateTime ende = LocalDateTime.of(serienDatum, str.getEnde());
            if(service.isTerminAvailable(str.getHallenId(), anfang, ende)){
                Termin termin = new Termin();
                termin.setAnfang(anfang);
                termin.setEnde(ende);
                termin.setMieterId(str.getMieterId());
                termin.setAnlass(str.getAnlass());

                service.create(termin);
                erzeugteTermine.add(termin);
            }
            serienDatum = serienDatum.plusWeeks(1);
        }
        return ResponseEntity.ok(erzeugteTermine);
    }

}
