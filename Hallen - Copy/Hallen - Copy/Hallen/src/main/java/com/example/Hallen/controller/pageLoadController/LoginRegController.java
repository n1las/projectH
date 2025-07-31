package com.example.Hallen.controller.pageLoadController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginRegController {
    @GetMapping("/login")
    public String showLoginPage(){
        return "login";
    }

    @GetMapping("/admin/signup")
    public String showSignupPage(){
        return "signup";
    }
}
