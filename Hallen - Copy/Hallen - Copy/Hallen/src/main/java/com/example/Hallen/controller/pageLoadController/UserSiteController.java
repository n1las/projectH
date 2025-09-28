package com.example.Hallen.controller.pageLoadController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class UserSiteController {
    @GetMapping("/admin/users")
    public String showUserPage(){
        return "users";
    }
    @GetMapping("/admin/editUser/{id}")
    public String showEditUserPage(@PathVariable String id){
        return "editUser";
    }
    @GetMapping("/admin/termine")
    public String showTerminePage(){
        return"termine";
    }
    @GetMapping("/admin/editTermine") String editTerminePage(){
        return "editTermine";
    }
}
