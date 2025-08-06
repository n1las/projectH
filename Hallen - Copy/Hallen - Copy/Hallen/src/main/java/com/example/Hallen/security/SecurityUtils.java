package com.example.Hallen.security;

import com.example.Hallen.security.CustomMieterDetails;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityUtils {

    public static Long getCurrentMieterId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof CustomMieterDetails) {
            return ((CustomMieterDetails) auth.getPrincipal()).getId();
        }
        return null;
    }
}
