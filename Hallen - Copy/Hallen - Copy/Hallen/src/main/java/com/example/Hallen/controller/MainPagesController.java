package com.example.Hallen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainPagesController {
    @GetMapping("/home")
    public String showHomPage(){
        return "index";
    }
    @GetMapping("/verein")
    public String showVereinPage(){
        return "verein";
    }
}
