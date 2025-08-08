package com.example.Hallen.service;

import com.example.Hallen.model.Mieter;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.MieterRepository;
import com.example.Hallen.repository.TerminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TerminService {
    @Autowired
    private TerminRepository repository;
    @Autowired
    private  EmailService emailService;

    @Autowired
    private MieterRepository mieterRepository;

    public List<Termin> getAll() {
        return repository.findAll();
    }

    public Optional<Termin> getById(Long id) {
        return repository.findById(id);
    }

    public Termin create(Termin termin) {
        termin.setConfirmed("unconfirmed");
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

    public List<Termin> findByMieterIdAndConfirmed(Long mieterID, String confirmed){
        List<Termin> allTermine = repository.findByMieterId(mieterID);
        List<Termin> confirmedTermine = new ArrayList<>();
        for(Termin t: allTermine){
            if(t.getConfirmed().equals(confirmed)){
                confirmedTermine.add(t);
            }
        }
        return confirmedTermine;
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
    public List<Termin> findByConfirmed(String confirmed){
        return repository.findByIsConfirmed(confirmed);
    }

    public Optional<Termin> updateTerminStatus(Long id, String terminStatus){
        Optional<Termin> terminOptional = repository.findById(id);
        if(terminOptional.isPresent()){
            Termin termin = terminOptional.get();
            if(terminStatus.equals("cancelled")){
                Optional<Mieter> mieterOptional = mieterRepository.findById(termin.getMieterId());
                if(mieterOptional.isPresent()){
                    Mieter mieter = mieterOptional.get();
                    String receiver = "arz.niklas@gmail.com";
                    String subject = "Termin wurde gecancelt";
                    String text = "Hallo,\n" +
                            "der Termin mit den Folgend Infos wurde von " + mieter.getUsername() + "abgesagt\n" +
                            "TerminId: " + termin.getId() +
                            "\n Anlass: " + termin.getAnlass() +
                            "\n Anfang: " + termin.getAnfang() +
                            "\n Ende: " + termin.getEnde() +
                            "\n HallenID: " + termin.getHallenId();

                    emailService.sendEmail(receiver, subject, text);
                }

            }

            termin.setConfirmed(terminStatus);
            repository.save(termin);
        }
        return terminOptional;
    }

}
