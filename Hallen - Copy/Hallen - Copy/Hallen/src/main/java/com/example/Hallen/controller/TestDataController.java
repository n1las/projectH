package com.example.Hallen.controller;
import com.example.Hallen.exception.TerminNotAvailableException;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
@RestController
@RequestMapping()
public class TestDataController {
    @Autowired
    private TerminRepository terminRepository;
    @Autowired
    private TerminService terminService;

    private final Random random = new Random();
    private String[] anlass = {"Training", "Turnier", "Freundschaftsspiel", "Vereinsmeisterschaft", "Sportkurs", "Fußballtraining", "Abschlussfeier", "Volleyball", "Basketball", "Handball", "Tanzkurs",
            "Messe", "Flohmarkt", "Konzert", "Gemeindeversammlung"};



    @GetMapping("/api/testdata/termine")
    public String createTestTermine() {
        List<Termin> createdTermine = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            Termin termin = new Termin();

            LocalDateTime start = LocalDateTime.of(2025, 9, 20, 0, 0);
            LocalDateTime end = LocalDateTime.of(2026, 6, 30, 0, 0);

            long startEpoch = start.toEpochSecond(ZoneOffset.UTC);
            long endEpoch = end.toEpochSecond(ZoneOffset.UTC);
            long randomEpoch = startEpoch + (long) (random.nextDouble() * (endEpoch - startEpoch));
            LocalDateTime randomDateTime = LocalDateTime.ofEpochSecond(randomEpoch, 0, ZoneOffset.UTC);
            termin.setAnlass(anlass[random.nextInt(anlass.length)]);
            termin.setAnfang(randomDateTime);
            termin.setEnde(randomDateTime.plusHours(random.nextLong((9 - 2) + 1)));
            termin.setMieterId(22L);
            termin.setFeldId(18L);

            try {
                terminService.isTerminAvailable(termin.getFeldId(), termin.getAnfang(), termin.getEnde());
                terminService.create(termin);
                createdTermine.add(termin);

            } catch (TerminNotAvailableException e) {
                return "mehhhh";
            }

        }
        return createdTermine.toString();
    }



}
