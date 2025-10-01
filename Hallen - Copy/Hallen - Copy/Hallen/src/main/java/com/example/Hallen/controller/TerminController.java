package com.example.Hallen.controller;

import com.example.Hallen.dto.*;
import com.example.Hallen.exception.TerminNotAvailableException;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

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
    @GetMapping("/getMergedTermine")
    public List<MergedTermine> getMergedTermine(){
        return service.mergeAll();
    }

    @GetMapping("/ByConfirmed/{confirmed}")
    public List<Termin> getByConfirmed(@PathVariable String confirmed){
        return service.findByConfirmed(confirmed);
    }

    @GetMapping("/MergedTermine/ByConfirmed/{confirmed}")
    public List<MergedTermine> getMergedTermineByConfirmed(@PathVariable String confirmed){
        return service.getMergedTermineByConfirmed(confirmed);
    }
    @GetMapping("/MergedTermine/ForUser")
    public List<MergedTermine> getMergedTermineForUser(){
        return service.mergeForUser();
    }
    @GetMapping("/MergedTermine/ForCalendar/{halleId}")
    public List<MergedTermine> getMergedForCalendar(@PathVariable Long halleId){
        return service.mergeForCalendar(halleId);
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
    @PostMapping("/serienTermin/Halle")
    public ResponseEntity<List<Termin>> createSerienTermin(@RequestBody HallenSerienTermin hst) {
        List<Termin> termine = service.halleSerienTermin(hst);
        return ResponseEntity.status(HttpStatus.CREATED).body(termine);
    }
    @PostMapping("/serienTermin/Felder")
    public ResponseEntity<List<Termin>> createSerienTerminFelder(@RequestBody SerienTerminRequest srt){
        List<Termin> termine = service.serieRequestToTermine(srt);
        return ResponseEntity.status(HttpStatus.CREATED).body(termine);
    }

    @PostMapping("/blockHalle")
    public ResponseEntity<List<Termin>> blockHalle(@RequestBody RentHalleRequest rentHalleRequest) {
        try{
            List<Termin> createdBlockTermine = service.blockHalle(rentHalleRequest) ;
            return ResponseEntity.status(HttpStatus.CREATED).body(createdBlockTermine);
        }catch(IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }

    }

    @PutMapping("/{id}")
    public Termin update(@PathVariable Long id, @RequestBody Termin termin) {
        return service.update(id, termin);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }

    // Note: find a way to maybe put cancelTermin and confirmTermin into one Method called updateTerminStatus
    @PatchMapping("/CoC")
    public ResponseEntity<String> confirmTermine(@RequestBody CoCRequest coc){
        if(coc.getTerminIds() == null || coc.getTerminIds().isEmpty()){
            return ResponseEntity.badRequest().body("Keine Termin Ids erhalten");
        }
        service.updateTerminConfirmed(coc);
        return ResponseEntity.ok("Termin erfolgreich geupdated");

    }

    @DeleteMapping("/delete")
    public ResponseEntity<String> deleteTermin(@RequestBody DeleteRequest deleteRequest) {

        boolean deleted = service.deleteByFeldIdAndAnfang(deleteRequest.getFeldIds(), deleteRequest.getStart());

        if (deleted) {
            return ResponseEntity.ok("Termin deleted successfully! 🧹");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No matching Termin found. ❌");
        }
    }
    @DeleteMapping("/delete/byIds")
    public ResponseEntity<String>deleteByIds(@RequestBody AdminDeleteRequest adminDeleteRequest){
        boolean deleted = service.deleteByIds(adminDeleteRequest.getTerminIds());
        if (deleted) {
            return ResponseEntity.ok("Termin deleted successfully! 🧹");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No matching Termin found. ❌");
        }
    }
    @DeleteMapping("/delete/Halle")
    public ResponseEntity<String>deleteByHalle(@RequestBody DeleteTerminKomplettRequest request){
        boolean deleted = service.deleteByHalle(request);
        if (deleted) {
            return ResponseEntity.ok("Termin deleted successfully! 🧹");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No matching Termin found. ❌");
        }
    }
    @PutMapping("/editTermin")
    public ResponseEntity<List<Termin>> update (@RequestBody EditTerminRequest request){
       try{
           List<Termin> updated = service.editTermin(request);
           return ResponseEntity.status(HttpStatus.OK).body(updated);
       }
       catch (NoSuchElementException e){
           return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
       }

    }

}



