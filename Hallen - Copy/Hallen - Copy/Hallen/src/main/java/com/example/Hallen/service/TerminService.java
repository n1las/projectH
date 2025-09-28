package com.example.Hallen.service;

import com.example.Hallen.dto.*;
import com.example.Hallen.exception.TerminNotAvailableException;
import com.example.Hallen.model.Feld;
import com.example.Hallen.model.Halle;
import com.example.Hallen.model.Mieter;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.MieterRepository;
import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.security.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class TerminService {
    @Autowired
    private TerminRepository repository;
    @Autowired
    private  EmailService emailService;
    @Autowired
    private FeldService feldService;
    @Autowired
    private HallenService hallenService;
    @Autowired
    private MieterService mieterService;

    @Autowired
    private MieterRepository mieterRepository;

    public List<Termin> getAll() {
        return repository.findAll();
    }

    public Optional<Termin> getById(Long id) {
        return repository.findById(id);
    }

    public List<Termin> getTerminByFeldId(Long feldId){
        return repository.findByFeldId(feldId);
    }

    public List<Termin> getByHalleId(Long halleId){
        List<Feld> felder = feldService.getFelderByHalleId(halleId);
        List<Termin> termine = new ArrayList<>();
        for(Feld f: felder){
            termine.addAll(getTerminByFeldId(f.getId()));
        }
        return termine;
    }
    //TODO: SCHLECHTESTER CODE JEMALS BITTE ÄNDERN (ABER ES FUNKTIONIERT)
    public Long getHalleIdByTerminId(Long terminId){
        Long respone = terminId;
        Optional<Termin> terminOptional = getById(terminId);
        if(terminOptional.isPresent()){
            Termin termin = terminOptional.get();
            Feld feld = feldService.getById(termin.getFeldId());
            respone = feld.getHalleId();
        }
        return respone;

    }
    public String getHallenName(Long terminId){

        return hallenService
                .getHallenNameById(getHalleIdByTerminId(terminId));
    }
    public String getMieterName(Long terminId){
        Optional<Termin> terminOptional = getById(terminId);
        if(terminOptional.isPresent()){
            Termin termin = terminOptional.get();
            return mieterService.getMieterById(termin.getMieterId()).getUsername();
        }

        return "Fehler";
    }
    public String getFeldName(Long terminId){
        Optional<Termin> terminOptional = getById(terminId);
        if(terminOptional.isPresent()){
            Termin termin = terminOptional.get();
            Feld feld = feldService.getById(termin.getFeldId());
            return feld.getName();
        }
        return "Felher";
    }
    public List<MergedTermine> mergeAll(){
        return merge(repository.findAll());
    }

    public Termin create(Termin termin) {
        termin.setConfirmed("unconfirmed");
        return repository.save(termin);
    }
    public List<Termin> rentHalle(RentHalleRequest rentHalleRequest) {
        List<Termin> createdTermine = new ArrayList<>();
        try{
            createdTermine = rentHalleRequestToTerminList(rentHalleRequest);
            for(Termin t: createdTermine){
                create(t);
            }
            return createdTermine;
        }
        catch (IllegalArgumentException e){
            return createdTermine;
        }

    }
    public List<Termin> blockHalle(RentHalleRequest rentHalleRequest) {
        List<Termin> createdBlockTermine = new ArrayList<>();
        createdBlockTermine = rentHalleRequestToTerminList(rentHalleRequest);
        for(Termin t: createdBlockTermine){
            t.setConfirmed("block");
            t.setMieterId(SecurityUtils.getCurrentMieterId());
            repository.save(t);
        }
        return createdBlockTermine;

    }
    public List<Termin> rentMultipleFelder(RentMultipleFelderRequest rentMultipleFelderRequest){
        if(rentMultipleFelderRequest == null || rentMultipleFelderRequest.getFeldIds().isEmpty()){
            throw new IllegalArgumentException("Keine Felder Ausgewählt");
        }
        List<Termin> addedTermine = new ArrayList<>();
        for(Long ids: rentMultipleFelderRequest.getFeldIds()){

            isTerminAvailable(ids, rentMultipleFelderRequest.getAnfang(),rentMultipleFelderRequest.getEnde());
            Termin termin = new Termin();
            termin.setFeldId(ids);
            termin.setAnfang(rentMultipleFelderRequest.getAnfang());
            termin.setEnde(rentMultipleFelderRequest.getEnde());
            termin.setAnlass(rentMultipleFelderRequest.getAnlass());
            termin.setMieterId(rentMultipleFelderRequest.getMieterId());
            addedTermine.add(create(termin));
        }
        return addedTermine;
    }
    // TODO: COMBINE BOTH METHODS SHOULD WORK
    public List<Termin> rentHalleRequestToTerminList(RentHalleRequest rentHalleRequest){
        List<Feld> feldIds = feldService.getFelderByHalleId(rentHalleRequest.getHalleId());
        List<Termin> termine = new ArrayList<>();
        for(Feld feld: feldIds){
            isTerminAvailable(feld.getId(),rentHalleRequest.getAnfang(),rentHalleRequest.getEnde());
            Termin termin = new Termin();
            termin.setFeldId(feld.getId());
            termin.setMieterId(rentHalleRequest.getMieterId());
            termin.setAnlass(rentHalleRequest.getAnlass());
            termin.setAnfang(rentHalleRequest.getAnfang());
            termin.setEnde(rentHalleRequest.getEnde());
            termine.add(termin);
        }
        return termine;
    }
    // bitte bessere Lösung finden ong
    public List<Termin> halleSerienTermin(HallenSerienTermin hallenSerienTermin){
        SerienTerminRequest serienTerminRequest = new SerienTerminRequest();
        List<Feld> felder = feldService.getFelderByHalleId(hallenSerienTermin.getHalleId());
        List<Long> feldIds = new ArrayList<>();
        for(Feld f: felder){
            feldIds.add(f.getId());
        }
        serienTerminRequest.setFeldIds(feldIds);
        serienTerminRequest.setAnfang(hallenSerienTermin.getAnfang());
        serienTerminRequest.setAnlass(hallenSerienTermin.getAnlass());
        serienTerminRequest.setEnde(hallenSerienTermin.getEnde());
        serienTerminRequest.setWochentag(hallenSerienTermin.getWochentag());
        serienTerminRequest.setSerieAnfang(hallenSerienTermin.getSerieAnfang());
        serienTerminRequest.setSerieEnde(hallenSerienTermin.getSerieEnde());
        serienTerminRequest.setMieterId(hallenSerienTermin.getMieterId());
        serienTerminRequest.setWochentag(hallenSerienTermin.getWochentag());
        return serieRequestToTermine(serienTerminRequest);

    }

    //TODO: FRAG OB MAN TERMINE DIE IN SERIE GEBUCHT WERDEN ÜBERSPRINGEN SOLL WENN ZB NUR EINER BELEGT IST ODER KOMPLETT ABBRECHEN SOLL
    public List<Termin> serieRequestToTermine(SerienTerminRequest serienTerminRequest){
        List<Termin> erzeugteTermine = new ArrayList<>();
        LocalDate serienDatum = serienTerminRequest.getSerieAnfang();
        List<Long> feldIds = serienTerminRequest.getFeldIds();

        while (!serienDatum.isAfter(serienTerminRequest.getSerieEnde())) {
            LocalDateTime anfang = LocalDateTime.of(serienDatum, serienTerminRequest.getAnfang());
            LocalDateTime ende = LocalDateTime.of(serienDatum, serienTerminRequest.getEnde());

            if(serienDatum.getDayOfWeek() == serienTerminRequest.getWochentag() && areTermineAvailable(feldIds, anfang, ende)){
                RentMultipleFelderRequest rmfr = new RentMultipleFelderRequest();
                rmfr.setFeldIds(serienTerminRequest.getFeldIds());
                rmfr.setAnfang(anfang);
                rmfr.setEnde(ende);
                rmfr.setMieterId(serienTerminRequest.getMieterId());
                rmfr.setAnlass(serienTerminRequest.getAnlass());
                try{
                    erzeugteTermine.addAll(rentMultipleFelder(rmfr));

                }
                catch (IllegalArgumentException e){
                    return erzeugteTermine;
                }

            }


            serienDatum = serienDatum.plusDays(1);
        }
        return erzeugteTermine;
    }


    public Termin update(Long id, Termin termin) {
        termin.setId(id);
        return repository.save(termin);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
    public boolean deleteByIds(List<Long> terminIds){
        for(Long id: terminIds){
            Optional<Termin> terminOptional = repository.findById(id);
            if(terminOptional.isPresent()){
                repository.delete(terminOptional.get());
            }
            else{
                return false;
            }
        }
        return true;
    }

    public boolean deleteByStart(LocalDateTime start){
        Optional<Termin> temp = repository.findByAnfang(start);
        if(temp.isPresent()){
            repository.delete(temp.get());
            return true;
        }
        return false;
    }
    public void isTerminAvailable(Long feldId, LocalDateTime anfang, LocalDateTime ende) {
        List<Termin> existing = repository.findByFeldId(feldId);
        for (Termin t : existing) {
            if (t.getAnfang().isBefore(ende) && t.getEnde().isAfter(anfang)) {
                // Overlap exists
                throw new TerminNotAvailableException("Termin am" + t.getAnfang() + "bereits belegt");
            }
        }
    }
    public boolean areTermineAvailable(List<Long> feldIds, LocalDateTime anfang, LocalDateTime ende){
        for(Long feldId: feldIds){
            List<Termin> existing = repository.findByFeldId(feldId);
            for(Termin termin: existing){
                if(termin.getAnfang().isBefore(ende) && termin.getEnde().isAfter(anfang)){
                    return false;
                }
            }
        }
        return true;

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

    public boolean deleteByFeldIdAndAnfang(List<Long> feldIds, LocalDateTime anfang) {
        for(Long l: feldIds){
            Optional<Termin> terminOpt = repository.findByFeldIdAndAnfang(l, anfang)   ;
            if (terminOpt.isPresent()) {
                repository.delete(terminOpt.get());
            }
            else {
                return false;
            }
        }
        return true;
    }
    public List<Termin> findByConfirmed(String confirmed){
        return repository.findByIsConfirmed(confirmed);
    }

    public Optional<Termin> updateTerminStatus(Long id, String terminStatus){
        Optional<Termin> terminOptional = repository.findById(id);
        if(terminOptional.isPresent()){
            Termin termin = terminOptional.get();
            termin.setConfirmed(terminStatus);
            repository.save(termin);
            if(terminStatus.equals("cancelled")){
                Optional<Mieter> mieterOptional = mieterRepository.findById(termin.getMieterId());
                if(mieterOptional.isPresent()){
                    Mieter mieter = mieterOptional.get();
                    String receiver = "arz.niklas@gmail.com";
                    String subject = "Termin wurde gecancelt";
                    String text = "Hallo,\n" +
                            "der Termin mit den Folgend Infos wurde von " + mieter.getUsername() + " abgesagt\n" +
                            "TerminId: " + termin.getId() +
                            "\n Anlass: " + termin.getAnlass() +
                            "\n Anfang: " + termin.getAnfang() +
                            "\n Ende: " + termin.getEnde() +
                            "\n FeldID: " + termin.getFeldId();

                    emailService.sendEmail(receiver, subject, text);
                }

            }
        }
        return terminOptional;
    }

    public  List<MergedTermine> merge(List<Termin> termine) {
        Map<String, MergedTermine> map = new HashMap<>();

        for (Termin t : termine) {
            Long halleId = feldService.getById(t.getFeldId()).getHalleId();
            String key = halleId + "|" +  t.getAnlass() + "|" + t.getAnfang() + "|" + t.getEnde();
            Halle halle = hallenService.getHalleById(halleId);

            MergedTermine mergedTermine = map.get(key);
            if(mergedTermine != null){
                mergedTermine.addToTerminIds(t.getId());
                mergedTermine.addToFeldId(t.getFeldId());
                if(mergedTermine.getTerminIds().size() == halle.getHallenTyp()){
                    mergedTermine.setAnzahlFelder("Komplette Halle");
                }
                else{
                    Feld feld = feldService.getById(t.getFeldId());
                    mergedTermine.addAnzahlFelder(feld.getName());

                }
            }
            else {
                List<Long> id = new ArrayList<>();
                List<Long> feldIds = new ArrayList<>();
                id.add(t.getId());
                feldIds.add(t.getFeldId());
                Feld feld = feldService.getById(t.getFeldId());
                if(halle.getHallenTyp() == 1){
                    map.put(key, new MergedTermine(id, feldIds,t.getAnfang(),t.getEnde(),t.getAnlass(),"Komplette Halle", halleId, t.getConfirmed(),t.getMieterId()));
                }
                else{
                    map.put(key, new MergedTermine(id, feldIds, t.getAnfang(),t.getEnde(),t.getAnlass(),feld.getName(), halleId, t.getConfirmed(), t.getMieterId()));
                }

            }
        }

        return new ArrayList<>(map.values());
    }
    public List<MergedTermine> getMergedTermineByConfirmed(String confirmed){
        return merge(repository.findByIsConfirmed(confirmed));
    }
    public List<MergedTermine> mergeForUser(){
        Long mieterId = SecurityUtils.getCurrentMieterId();
        List<Termin> mieterTermine = repository.findByMieterId(mieterId);
        List<Termin> mieterTermineUn = new ArrayList<>();
        for(Termin termin: mieterTermine){
            if (termin.getConfirmed().equals("unconfirmed")){
                mieterTermineUn.add(termin);
            }

        }
        return merge(mieterTermineUn);
    }
    public List<MergedTermine> mergeForCalendar(Long halleId){
        return merge(getByHalleId(halleId));
    }

    public void updateTerminConfirmed(CoCRequest coc){
        for(Long id: coc.getTerminIds()){
            updateTerminStatus(id,coc.getStatus());
        }

    }
    public List<Termin> editTermin(EditTerminRequest request){
        List<Termin> updated = new ArrayList<>();
        for(Long id: request.getIds()){
            Termin termin = repository.findById(id)
                    .orElseThrow(() -> new NoSuchElementException("Termin with id:" + id + " not found"));
            termin.setMieterId(mieterService.findByUsername(request.getMieterName()).getId());
            termin.setAnlass(request.getAnlass());
            termin.setAnfang(request.getAnfang());
            termin.setEnde(request.getEnde());
            termin.setConfirmed(request.getStatus());
            updated.add(termin);
            isTerminAvailable(termin.getFeldId(),termin.getAnfang(),termin.getEnde());
            repository.save(termin);


        }
        return updated;
    }



}
