package com.example.Hallen.service;

import com.example.Hallen.repository.HallenRepository;
import com.example.Hallen.model.Halle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class HallenService {

    @Autowired
    private HallenRepository hallenRepository;

    public List<Halle> getAllHallenEntites() {
        return hallenRepository.findAll();
    }

    public Halle getHalleById(Long id) {
        return hallenRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Halle not found with" + id));


    }
    public String getHallenNameById(Long id){
        return hallenRepository.findById(id)
                .map(Halle::getName)
                .orElse("Halle nicht gefunden");
    }


}
