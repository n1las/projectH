package com.example.Hallen.controller;
import com.example.Hallen.exception.TerminNotAvailableException;
import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import com.example.Hallen.service.TerminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;
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
    private String[] anlass = {"Training", "Turnier", "Freundschaftsspiel", "Vereinsmeisterschaft", "Sportkurs",
            "Fußballtraining", "Abschlussfeier", "Volleyball", "Basketball", "Handball",
            "Tanzkurs", "Messe", "Flohmarkt", "Konzert", "Gemeindeversammlung"};
    private String[] status = {"cancelled", "unconfirmed", "confirmed"};
    private Long[] felder = { 2L, 3L, 4L};
    private Long[] mieter = {22L, 30L, 29L, 28L };
    private int dupes = 0;



    @GetMapping("/api/testdata/termine")
    public String createTestTermine() {
        List<Termin> createdTermine = new ArrayList<>();
        for (int i = 0; i < 20; i++) {
            Termin termin = new Termin();

            LocalDate start = LocalDate.of(2025, 9, 30);
            LocalDate end = LocalDate.of(2026, 1, 1);

            // Pick a random date first
            long daysBetween = ChronoUnit.DAYS.between(start, end);
            LocalDate randomDate = start.plusDays(random.nextInt((int) daysBetween + 1));

            // Pick a random time between 00:00 and 18:00
            int randomHour = random.nextInt(18); // 0 to 17
            int randomMinute = random.nextInt(60);

            LocalTime randomTime = LocalTime.of(randomHour, randomMinute, 0);

            LocalDateTime randomDateTime = LocalDateTime.of(randomDate, randomTime);
            termin.setAnlass(anlass[random.nextInt(anlass.length)]);
            termin.setAnfang(randomDateTime);
            long hoursToAdd = 5 + random.nextInt(2);
            termin.setEnde(randomDateTime.plusHours(hoursToAdd));
            termin.setFeldId(Long.valueOf(random.nextInt(14) + 1));
            termin.setConfirmed(status[random.nextInt(status.length)]);
            termin.setMieterId(mieter[random.nextInt(mieter.length)]);


            try {
                terminService.isTerminAvailable(termin.getFeldId(), termin.getAnfang(), termin.getEnde());

            } catch (TerminNotAvailableException e) {
                dupes++;
                continue;
            }
            createdTermine.add(termin);
            terminRepository.save(termin);

        }
        return createdTermine.toString() + dupes;
    }



}
