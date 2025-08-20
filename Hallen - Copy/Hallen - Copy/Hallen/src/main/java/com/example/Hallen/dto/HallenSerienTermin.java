package com.example.Hallen.dto;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;

public class HallenSerienTermin {
    private Long halleId;
    private Long mieterId;
    private String anlass;
    private LocalTime anfang;
    private LocalTime ende;
    private LocalDate serieAnfang;
    private LocalDate serieEnde;
    private DayOfWeek wochentag;

    public Long getHalleId() {
        return halleId;
    }

    public void setHalleId(Long halleId) {
        this.halleId = halleId;
    }

    public Long getMieterId() {
        return mieterId;
    }

    public void setMieterId(Long mieterId) {
        this.mieterId = mieterId;
    }

    public String getAnlass() {
        return anlass;
    }

    public void setAnlass(String anlass) {
        this.anlass = anlass;
    }

    public LocalTime getAnfang() {
        return anfang;
    }

    public void setAnfang(LocalTime anfang) {
        this.anfang = anfang;
    }

    public LocalTime getEnde() {
        return ende;
    }

    public void setEnde(LocalTime ende) {
        this.ende = ende;
    }

    public LocalDate getSerieAnfang() {
        return serieAnfang;
    }

    public void setSerieAnfang(LocalDate serieAnfang) {
        this.serieAnfang = serieAnfang;
    }

    public LocalDate getSerieEnde() {
        return serieEnde;
    }

    public void setSerieEnde(LocalDate serieEnde) {
        this.serieEnde = serieEnde;
    }

    public DayOfWeek getWochentag() {
        return wochentag;
    }

    public void setWochentag(DayOfWeek wochentag) {
        this.wochentag = wochentag;
    }
}
