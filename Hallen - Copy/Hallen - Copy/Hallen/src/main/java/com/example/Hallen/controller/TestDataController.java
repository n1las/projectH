/*
package com.example.Hallen.controller;

import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;


import java.time.LocalDateTime;
import java.util.Random;

public class TestDataController {
    @Autowired
    private TerminRepository terminRepository;
    @Autowired
    private TerminService terminService;

    private final Random random = new Random();


    @GetMapping("/api/testdata/termine")
    public String createTestTermine() {


        for (int i = 1; i <= 50; i++) { // generate 50 Termine
            String title = "Test Termin " + i;
            LocalDateTime start = LocalDateTime.now().plusDays(random.nextInt(30)).withHour(random.nextInt(8) + 8);
            LocalDateTime end = start.withHour(random.nextInt(8));


            terminRepository.save(termin);
        }

        return "50 test Termine created!";
    }
}
*/