package com.example.Hallen.dto;

import java.time.LocalDateTime;
import java.util.List;

public class RentMultipleFelderRequest {
    List<Long> feldIds;
    Long mieterId;
    String anlass;
    LocalDateTime anfang;
    LocalDateTime ende;

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
}
