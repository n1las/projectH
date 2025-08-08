package com.example.Hallen.controller;

import com.example.Hallen.model.Halle;
import com.example.Hallen.repository.HallenRepository;
import com.example.Hallen.service.HallenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
@RequestMapping()
public class HallenController {

    @Autowired
    private HallenService hallenService;
    @Autowired
    private HallenRepository halleRepository;


    @GetMapping("/api/Hallen")
    public List<Halle> getHallen(){
        return hallenService.getAllHallenEntites();
    }

    @GetMapping("/api/Hallen/{id}")
    public Halle getHalleById(@PathVariable Long id){
        return  hallenService.getHalleById(id);
    }
    @GetMapping("/api/Hallen/getName/{id}")
    public ResponseEntity<String> getHallenNameById(@PathVariable Long id) {
        String name = hallenService.getHallenNameById(id);
        System.out.println("Gefundener Name: " + name); // Debug
        return ResponseEntity.ok(name != null ? name : "");
    }

}
