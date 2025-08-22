package com.example.Hallen.dto;

import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;
import java.util.List;

public class MergedTermine {
    private List<Long> terminIds;
    private LocalDateTime anfang;
    private LocalDateTime ende;
    private String anlass;
    private String anzahlFelder; // zb (Feld 1, Feld 2) oder (komplette Halle)

    public String getAnzahlFelder() {
        return anzahlFelder;
    }

    public void setAnzahlFelder(String anzahlFelder) {
        this.anzahlFelder = anzahlFelder;
    }
    public void addAnzahlFelder(String feldName){
        this.anzahlFelder += ", " + feldName;
    }

    public MergedTermine(List<Long> terminIds, LocalDateTime anfang, LocalDateTime ende, String anlass, String anzahlFelder) {
        this.terminIds = terminIds;
        this.anfang = anfang;
        this.ende = ende;
        this.anlass = anlass;
        this.anzahlFelder = anzahlFelder;

    }

    public MergedTermine(List<Long> terminIds, LocalDateTime anfang, LocalDateTime ende, String anlass) {
        this.terminIds = terminIds;
        this.anfang = anfang;
        this.ende = ende;
        this.anlass = anlass;

    }

    public List<Long> getTerminIds() {
        return terminIds;
    }

    public void setTerminIds(List<Long> terminIds) {
        this.terminIds = terminIds;
    }
    public void addToTerminIds(Long id){
        terminIds.add(id);
    }

    public LocalDateTime getAnfang() {
        return anfang;
    }

    public void setAnfang(LocalDateTime anfang) {
        this.anfang = anfang;
    }

    public LocalDateTime getEnde() {
        return ende;
    }

    public void setEnde(LocalDateTime ende) {
        this.ende = ende;
    }

    public String getAnlass() {
        return anlass;
    }

    public void setAnlass(String anlass) {
        this.anlass = anlass;
    }

}
