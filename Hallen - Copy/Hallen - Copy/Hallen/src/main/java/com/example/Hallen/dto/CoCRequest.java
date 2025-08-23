package com.example.Hallen.dto;

import java.util.List;

// Cancel or Confirm Request :))))
public class CoCRequest {
    private List<Long> terminIds;
    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Long> getTerminIds() {
        return terminIds;
    }

    public void setTerminIds(List<Long> terminIds) {
        this.terminIds = terminIds;
    }
}
