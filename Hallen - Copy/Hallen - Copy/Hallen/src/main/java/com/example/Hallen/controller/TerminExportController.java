package com.example.Hallen.controller;

import com.example.Hallen.service.TerminExportService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
@RestController
@RequestMapping("/api/termineExport")
public class TerminExportController {

    final private TerminExportService terminExportService;

    @Autowired
    public TerminExportController(TerminExportService exportService) {
        this.terminExportService = exportService;
    }


    @GetMapping("/export/excel")
    public void exportToExcel(HttpServletResponse response)throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=termine.xlsx");

        terminExportService.writeExcelToResponse(response);
    }
    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }
}
