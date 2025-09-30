package com.example.Hallen.dto;

import java.time.LocalDateTime;

public class DeleteTerminKomplettRequest {
    private Long halleId;
    private LocalDateTime anfang;

    public Long getHalleId() {
        return halleId;
    }

    public void setHalleId(Long halleId) {
        this.halleId = halleId;
    }

    public LocalDateTime getAnfang() {
        return anfang;
    }

    public void setAnfang(LocalDateTime anfang) {
        this.anfang = anfang;
    }
}
