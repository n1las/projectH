package com.example.Hallen.controller.pageLoadController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserSiteController {
    @GetMapping("/users")
    public String showUserPage(){
        return "users";
    }
    @GetMapping("editUser")
    public String showEditUserPage(){
        return "editUser";
    }
}
