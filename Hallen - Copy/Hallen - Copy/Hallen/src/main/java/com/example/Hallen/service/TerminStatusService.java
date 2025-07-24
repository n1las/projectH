
package com.example.Hallen.service;

import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class TerminStatusService {

    @Autowired
    private TerminRepository repository;

    @Scheduled(cron = "0 0 * * * *")
    public void updateExpiredTermine(){
        LocalDateTime now = LocalDateTime.now().minusHours(1);
        List<Termin> termine = repository.findByIsConfirmed("unconfirmed");

        for(Termin t: termine){
            if(t.getEnde().isBefore(now)){
                t.setConfirmed("expired");
                repository.save(t);
            }
        }
    }
}


