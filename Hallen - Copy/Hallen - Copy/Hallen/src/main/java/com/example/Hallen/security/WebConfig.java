package com.example.Hallen.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // This tells Spring to serve your login page at /login without a controller
        registry.addViewController("/login").setViewName("login");
    }
}
