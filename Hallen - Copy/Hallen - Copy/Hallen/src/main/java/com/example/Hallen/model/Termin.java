package com.example.Hallen.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "termin")
public class Termin {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;
    @Column(name = "Halle_ID")
    private Long hallenId;
    @Column(name = "Mieter_ID")
    private Long mieterId;
    @Column(name = "Anlass")
    private String anlass;
    @Column(name = "Anfang")
    private LocalDateTime anfang;
    @Column(name = "Ende")
    private LocalDateTime ende;
    // isConfirmed descriebes the Staus of the appointment
    // expired = not confirmed until 1h after appointment
    // cancelled = user cancelled the apointment before it happend, email gets send to admin and appointment get deleted after 7 days
    // block = used to block other appointments when the Halle is closed
    @Column(name = "isConfirmed")
    private String isConfirmed; // confirmed, unconfirmed, expired, cancelled, block
    public Termin(){

    }

    public String getConfirmed() {
        return isConfirmed;
    }

    public void setConfirmed(String confirmed) {
        isConfirmed = confirmed;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getHallenId() {
        return hallenId;
    }

    public void setHallenId(Long hallenId) {
        this.hallenId = hallenId;
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
