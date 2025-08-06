package com.example.Hallen.security;

import com.example.Hallen.model.Mieter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class CustomMieterDetails implements UserDetails {

    private final Mieter mieter;
    private final Collection<? extends GrantedAuthority> authorities;

    public CustomMieterDetails(Mieter mieter, Collection<? extends GrantedAuthority> authorities) {
        this.mieter = mieter;
        this.authorities = authorities;
    }

    public Long getId() {
        return mieter.getId();  // You can now use this!
    }

    public Mieter getMieter() {
        return mieter; // Optional: full access to Mieter object if needed
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return mieter.getPasswort();
    }

    @Override
    public String getUsername() {
        return mieter.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true; // or: return mieter.isEnabled();
    }
}
