package com.example.Hallen.controller.pageLoadController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class UserSiteController {
    @GetMapping("/users")
    public String showUserPage(){
        return "users";
    }
    @GetMapping("editUser/{id}")
    public String showEditUserPage(@PathVariable String id){
        return "editUser";
    }
}
