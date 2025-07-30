package com.example.Hallen.controller.pageLoadController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RentDeleteController {
    @GetMapping("/admin/mieten")
    public String showMietenPage(){
        return "mieten";
    }
    @GetMapping("/admin/delete")
    public String showDeletePage(){
        return "delete";
    }

}
