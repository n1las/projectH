package com.example.Hallen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {
    @GetMapping("/mieten")
    public String showMietenPage(){
        return "mieten";
    }
}
