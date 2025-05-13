package com.example.Hallen;

import jakarta.persistence.*;

@Entity
@Table(name = "entities") // Correct table name
public class Halle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Column(name = "image_url") // Column name with an underscore
    private String imageUrl;

    private String strasse;

    private String ort;

    @Column(name = "plz") // Ensure the column name matches
    private Integer plz;  // Changed to Integer to allow null values

    @Column(name = "strasse_nr") // Ensure column name matches
    private Integer strasseNr; // Changed field name to follow Java conventions

    @Column(name = "spielfeldgroesse") // Ensure column name matches
    private Integer spielfeldgroesse; // Changed to Integer to allow null values

    // Getters and setters
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

    public String getOrt() {
        return ort;
    }

    public void setOrt(String ort) {
        this.ort = ort;
    }

    public Integer getPlz() {
        return plz;
    }

    public void setPlz(Integer plz) {
        this.plz = plz;
    }

    public Integer getStrasseNr() {
        return strasseNr;
    }

    public void setStrasseNr(Integer strasseNr) {
        this.strasseNr = strasseNr;
    }

    public Integer getSpielfeldgroesse() {
        return spielfeldgroesse;
    }

    public void setSpielfeldgroesse(Integer spielfeldgroesse) {
        this.spielfeldgroesse = spielfeldgroesse;
    }
}
