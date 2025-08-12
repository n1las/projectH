package com.example.Hallen.dto;

import com.example.Hallen.model.Mieter;

import java.time.LocalDateTime;
import java.util.List;

public class RentMultipleFelderRequest {
    List<Long> feldIds;
    Long mieterId;
    String anlass;
    LocalDateTime Anfang;
    LocalDateTime Ende;

    public List<Long> getFeldIds() {
        return feldIds;
    }

    public void setFeldIds(List<Long> feldIds) {
        this.feldIds = feldIds;
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

    public LocalDateTime getAnfang() {
        return Anfang;
    }

    public void setAnfang(LocalDateTime anfang) {
        Anfang = anfang;
    }

    public LocalDateTime getEnde() {
        return Ende;
    }

    public void setEnde(LocalDateTime ende) {
        Ende = ende;
    }
}
