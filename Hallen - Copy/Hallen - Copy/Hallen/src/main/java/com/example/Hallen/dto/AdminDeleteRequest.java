package com.example.Hallen.dto;

import java.util.List;

public class AdminDeleteRequest {
    List<Long> terminIds;

    public List<Long> getTerminIds() {
        return terminIds;
    }

    public void setTerminIds(List<Long> terminIds) {
        this.terminIds = terminIds;
    }
}
