package com.example.Hallen.controller.pageLoadController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RentDeleteController {
    @GetMapping("/mieten")
    public String showMietenPage(){
        return "mieten";
    }
    @GetMapping("delete")
    public String showDeletePage(){
        return "delete";
    }

}
