package com.example.Hallen.dto;


import java.time.LocalDateTime;

public class BlockTimeRequest {
    private String anlass;
    private Long HallenId;
    private LocalDateTime anfang;
    private LocalDateTime ende;

    public String getAnlass() {
        return anlass;
    }

    public void setAnlass(String anlass) {
        this.anlass = anlass;
    }

    public Long getHallenId() {
        return HallenId;
    }

    public void setHallenId(Long hallenId) {
        HallenId = hallenId;
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
