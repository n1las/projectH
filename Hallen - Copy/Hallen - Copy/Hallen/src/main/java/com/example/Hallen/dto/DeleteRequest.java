package com.example.Hallen.dto;

import java.time.LocalDateTime;
import java.util.List;

public class DeleteRequest {
    private List<Long> feldIds;
    private LocalDateTime start;

    public List<Long> getFeldIds() {
        return feldIds;
    }

    public void setFeldIds(List<Long> feldIds) {
        this.feldIds = feldIds;
    }

    public LocalDateTime getStart() {
        return start;
    }

    public void setStart(LocalDateTime start) {
        this.start = start;
    }
}
