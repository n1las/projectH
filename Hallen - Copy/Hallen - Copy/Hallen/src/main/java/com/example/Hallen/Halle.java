package com.example.Hallen;

import jakarta.persistence.*;

@Entity
@Table(name = "entities")
public class Halle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    @Column(name = "image_url")
    private String imageUrl;
    private String strasse;
    private String ort;
    private int plz;
    private int strasse_nr;
    private int spielfeldgroesse;

    public int getStrasse_nr() {
        return strasse_nr;
    }

    public void setStrasse_nr(int strasse_nr) {
        this.strasse_nr = strasse_nr;
    }

    public int getSpielfeldgroesse() {
        return spielfeldgroesse;
    }

    public void setSpielfeldgroesse(int spielfeldgroesse) {
        this.spielfeldgroesse = spielfeldgroesse;
    }

    public int getPlz() {
        return plz;
    }

    public void setPlz(int plz) {
        this.plz = plz;
    }

    public String getOrt() {
        return ort;
    }

    public void setOrt(String ort) {
        this.ort = ort;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStrasse() {
        return strasse;
    }

    public void setStrasse(String strasse) {
        this.strasse = strasse;
    }
}
