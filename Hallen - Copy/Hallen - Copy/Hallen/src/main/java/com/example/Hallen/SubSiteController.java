package com.example.Hallen;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class SubSiteController {

    @GetMapping("/subsite/{id}")
    public String showSubsite(@PathVariable String id) {
        return "subsite"; // This will serve `subsite.html` from `src/main/resources/templates/`
    }
}
