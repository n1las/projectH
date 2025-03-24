package com.example.Hallen;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;

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

}
