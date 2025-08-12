package com.example.Hallen.service;

import com.example.Hallen.model.Feld;
import com.example.Hallen.repository.FeldRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FeldService {
    @Autowired
    private FeldRepository feldRepository;

    public List<Feld> getAllFelder(){
        return feldRepository.findAll();
    }
}
