package com.example.Hallen.service;

        import com.example.Hallen.model.Mieter;
        import com.example.Hallen.repository.MieterRepository;
        import com.example.Hallen.security.CustomMieterDetails;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.security.core.authority.SimpleGrantedAuthority;
        import org.springframework.security.core.userdetails.*;
        import org.springframework.stereotype.Service;

        import java.util.Collections;

@Service
public class MieterDetailsService implements UserDetailsService {

    @Autowired
    private MieterRepository mieterRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Mieter mieter = mieterRepo.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        String role = mieter.getAdmin() ? "ROLE_ADMIN" : "ROLE_USER";

        return new CustomMieterDetails(mieter,
                Collections.singletonList(new SimpleGrantedAuthority(role)));
    }
}

