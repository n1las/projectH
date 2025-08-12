package com.example.Hallen.dto;

import java.time.LocalDateTime;

public class RentHalleRequest {
    LocalDateTime anfang;
    LocalDateTime ende;
    Long halleId;
    String anlass;
    Long mieterId;

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

    public Long getHalleId() {
        return halleId;
    }

    public void setHalleId(Long halleId) {
        this.halleId = halleId;
    }

    public String getAnlass() {
        return anlass;
    }

    public void setAnlass(String anlass) {
        this.anlass = anlass;
    }

    public Long getMieterId() {
        return mieterId;
    }

    public void setMieterId(Long mieterId) {
        this.mieterId = mieterId;
    }
}
