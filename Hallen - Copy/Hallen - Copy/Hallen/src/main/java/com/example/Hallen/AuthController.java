package com.example.Hallen.controller;

import com.example.Hallen.dto.LoginRequest;
import com.example.Hallen.model.Mieter;
import com.example.Hallen.security.JwtUtil;
import com.example.Hallen.service.MieterService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    private final MieterService service;

    public AuthController(MieterService service) {
        this.service = service;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        Mieter mieter = service.findByUsername(loginRequest.getUsername());

        if (mieter == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Benutzername nicht gefunden");
        }

        if (mieter.getPasswort().equals(loginRequest.getPasswort())) {
            String token = JwtUtil.generateToken(mieter.getUsername());
            return ResponseEntity.ok(Map.of("token", token));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Falsches Passwort");
        }
    }
}
