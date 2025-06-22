package com.example.Hallen.service;

import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
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

    public boolean deleteByStart(LocalDateTime start){
        Optional<Termin> temp = repository.findByAnfang(start);
        if(temp.isPresent()){
            repository.delete(temp.get());
            return true;
        }
        return false;
    }
    public boolean isTerminAvailable(Long hallenId, LocalDateTime anfang, LocalDateTime ende) {
        List<Termin> existing = repository.findByHallenId(hallenId);
        for (Termin t : existing) {
            if (t.getAnfang().isBefore(ende) && t.getEnde().isAfter(anfang)) {
                // Overlap exists
                return false;
            }
        }
        return true; // No conflicts
    }
    public List<Termin> findByMieterId(Long mieterId){
        return repository.findByMieterId(mieterId);
    }

    public boolean deleteByHallenIdAndAnfang(Long hallenId, LocalDateTime anfang) {
        Optional<Termin> terminOpt = repository.findByHallenIdAndAnfang(hallenId, anfang)   ;
        if (terminOpt.isPresent()) {
            repository.delete(terminOpt.get());
            return true;
        } else {
            return false;
        }
    }

}
