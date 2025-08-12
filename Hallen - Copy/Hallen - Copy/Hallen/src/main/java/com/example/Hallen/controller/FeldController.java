package com.example.Hallen.controller;

import com.example.Hallen.model.Feld;
import com.example.Hallen.service.FeldService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/feld")
public class FeldController {
    @Autowired
    private FeldService feldService;
    @GetMapping()
    public List<Feld> gettAll(){
        return feldService.getAllFelder();
    }
    @GetMapping("/{id}")
    public Feld getById(@PathVariable Long id){
        return feldService.getById(id);
    }

    @GetMapping("/getByHallenId/{halleId}")
    public List<Feld> getByHallenId(@PathVariable Long halleId){
        return feldService.getFelderByHalleId(halleId);
    }
}
