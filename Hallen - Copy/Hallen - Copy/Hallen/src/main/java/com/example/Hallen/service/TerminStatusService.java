
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

    // sets every termin to expired that has been expired for more than 1 hour it does check this every hour at Minute 0
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
    // Deletes every cancelled Termin every Monday at 00:00
    @Scheduled(cron = "0 0 0 * * MON")
    public void deleteCancelledTermine(){
        List<Termin> cancelledTermine = repository.findByIsConfirmed("cancelled");
        for(Termin t: cancelledTermine){
            repository.deleteById(t.getId());
        }
    }
}


