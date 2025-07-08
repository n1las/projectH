package com.example.Hallen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class TestController {
    @GetMapping("/testS")
    public String showTestPage(){
        return "serienTest";
    }
}
