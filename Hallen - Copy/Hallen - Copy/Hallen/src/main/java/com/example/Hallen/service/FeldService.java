package com.example.Hallen.service;

import com.example.Hallen.model.Feld;
import com.example.Hallen.repository.FeldRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class FeldService {
    @Autowired
    private FeldRepository feldRepository;

    public List<Feld> getAllFelder(){
        return feldRepository.findAll();
    }

    public Feld getById(Long id){
        return feldRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("feld mit ID" + id + "nicht gefunden"));
    }

    public List<Feld> getFelderByHalleId(Long halleId){
        return feldRepository.findByHalleId(halleId);
    }

    public List<String> getFeldeNameByHalleId(Long halleId){
        List<String> feldNamen = new ArrayList<>();
        List<Feld> felder = getFelderByHalleId(halleId);
        for(Feld feld: felder){
            feldNamen.add(feld.getName());
        }
        return feldNamen;
    }
}
