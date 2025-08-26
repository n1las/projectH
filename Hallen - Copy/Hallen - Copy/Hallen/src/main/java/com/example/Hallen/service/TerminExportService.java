package com.example.Hallen.service;

import com.example.Hallen.model.Termin;
import com.example.Hallen.repository.TerminRepository;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class TerminExportService {

    private final TerminRepository terminRepository;
    @Autowired
    private TerminService terminService;

    public TerminExportService(TerminRepository terminRepository) {
        this.terminRepository = terminRepository;
    }

    public void writeExcelToResponse(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Termine");

        // Header
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("ID");
        header.createCell(1).setCellValue("Mieter");
        header.createCell(2).setCellValue("Anlass");
        header.createCell(3).setCellValue("Anfang");
        header.createCell(4).setCellValue("Ende");
        header.createCell(5).setCellValue("Status");
        header.createCell(6).setCellValue("Feld_Name");
        header.createCell(7).setCellValue("Hallen_Name");

        // Data
        List<Termin> termine = terminRepository.findAll();
        int rowIdx = 1;
        for (Termin t : termine) {

            Row row = sheet.createRow(rowIdx++);

            row.createCell(0).setCellValue(t.getId());
            row.createCell(1).setCellValue(terminService.getMieterName(t.getId()));
            row.createCell(2).setCellValue(t.getAnlass());
            row.createCell(3).setCellValue(t.getAnfang().toString());
            row.createCell(4).setCellValue(t.getEnde().toString());
            row.createCell(5).setCellValue(t.getConfirmed());
            row.createCell(6).setCellValue(terminService.getFeldName(t.getId()));
            row.createCell(7).setCellValue(terminService.getHallenName(t.getId()));
        }

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}
