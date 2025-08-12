package com.example.Hallen.model;

import jakarta.persistence.*;

@Entity
@Table(name="feld")
public class Feld {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    @Column(name="entities_id")
    private Long halleId;

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

    public Long getHalleId() {
        return halleId;
    }

    public void setHalleId(Long halleId) {
        this.halleId = halleId;
    }
}
