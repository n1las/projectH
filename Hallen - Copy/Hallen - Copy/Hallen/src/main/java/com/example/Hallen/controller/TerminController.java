package com.example.Hallen.controller;

import com.example.Hallen.dto.BlockTimeRequest;
import com.example.Hallen.dto.RentHalleRequest;
import com.example.Hallen.dto.RentMultipleFelderRequest;
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

    @GetMapping("/getByMieterIdAndConfirmed/{mieterId}/{confirmed}")
    public List<Termin> getUnconfirmedTerminByMieterId(@PathVariable Long mieterId, @PathVariable String confirmed){
        return service.findByMieterIdAndConfirmed(mieterId,confirmed);
    }
    @GetMapping("/getByFeldId/{feldId}")
        public List<Termin> getTerminByFeldId(@PathVariable Long feldId){
            return service.getTerminByFeldId(feldId);
        }
    @GetMapping("/getByHalleId/{halleId}")
    public List<Termin>getTerminByHalleId(@PathVariable Long halleId){
        return service.getByHalleId(halleId);
    }


    @PostMapping("/mieten/multipleFelder")
    public ResponseEntity<List<Termin>> rentMultipleFelder(@RequestBody RentMultipleFelderRequest rentMultipleFelderRequest) {
        List<Termin> termine = service.rentMultipleFelder(rentMultipleFelderRequest);
        return ResponseEntity.ok(termine);
    }
    @PostMapping("/mieten/halle")
    public ResponseEntity<List<Termin>> rentHalle(@RequestBody RentHalleRequest rentHalleRequest){
        List<Termin> termine = service.rentHalle(rentHalleRequest);
        return ResponseEntity.ok(termine);
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
    // Note: find a way to maybe put cancelTermin and confirmTermin into one Method called updateTerminStatus
    @PatchMapping("/{id}/confirm")
    public ResponseEntity<?> confirmTermin(@PathVariable Long id) {
        Optional<Termin> terminOptional = service.updateTerminStatus(id, "confirmed");
        if(terminOptional.isPresent()){
            return ResponseEntity.ok(terminOptional.get());
        }
        else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("keinen Termin mit der Id" + id +"gefunden.");
        }
    }
    @PatchMapping("/{id}/cancel")
    public ResponseEntity<?> cancelTermin(@PathVariable Long id) {
        Optional<Termin> terminOptional = service.updateTerminStatus(id, "cancelled");
        if(terminOptional.isPresent()){
            return ResponseEntity.ok(terminOptional.get());
        }
        else{
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("keinen Termin mit der Id" + id +"gefunden.");
        }
    }

    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteTermin(
            @RequestParam Long feldId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime anfang) {

        boolean deleted = service.deleteByFeldIdAndAnfang(feldId, anfang);

        if (deleted) {
            return ResponseEntity.ok("Termin deleted successfully! 🧹");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No matching Termin found. ❌");
        }
    }

    @PostMapping("serienTermin")
    public ResponseEntity<List<Termin>> createSerienTermin(@RequestBody SerienTerminRequest str) {
        List<Termin> erzeugteTermine = new ArrayList<>();
        LocalDate serienDatum = str.getSerieAnfang();

        while (!serienDatum.isAfter(str.getSerieEnde())) {
            LocalDateTime anfang = LocalDateTime.of(serienDatum, str.getAnfang());
            LocalDateTime ende = LocalDateTime.of(serienDatum, str.getEnde());
            if (service.isTerminAvailable(str.getHallenId(), anfang, ende) && serienDatum.getDayOfWeek() == str.getWochentag()) {
                Termin termin = new Termin();
                termin.setAnfang(anfang);
                termin.setEnde(ende);
                termin.setMieterId(str.getMieterId());
                termin.setAnlass(str.getAnlass());
                termin.setFeldId(str.getHallenId());
                termin.setConfirmed("unconfirmed");
                service.create(termin);
                erzeugteTermine.add(termin);
            }
            serienDatum = serienDatum.plusDays(1);
        }
        return ResponseEntity.ok(erzeugteTermine);
    }

    @PostMapping("/blockTermin")
    public ResponseEntity<BlockTimeRequest> createBlock(@RequestBody BlockTimeRequest btr) {
        try{
            BlockTimeRequest blockTimeRequest = service.createBlockTermin(btr);
            return ResponseEntity.status(HttpStatus.CREATED).body(blockTimeRequest);
        }catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }

    }

    @GetMapping("/ByConfirmed/{confirmed}")
    public List<Termin> getByConfirmed(@PathVariable String confirmed){
        return service.findByConfirmed(confirmed);
    }
}


