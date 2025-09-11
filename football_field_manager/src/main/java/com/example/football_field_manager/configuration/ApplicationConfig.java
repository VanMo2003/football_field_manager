package com.example.football_field_manager.configuration;

import com.example.football_field_manager.constant.PredefinedRole;
import com.example.football_field_manager.entity.Role;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.repository.RoleRepository;
import com.example.football_field_manager.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Date;

@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ApplicationConfig {

    PasswordEncoder passwordEncoder;
    @NonFinal
    static String ADMIN_USER_NAME = "admin";

    @NonFinal
    static String ADMIN_PASSWORD = "admin123";

    @Bean
    ApplicationRunner applicationRunner(UserRepository userRepository, RoleRepository roleRepository) {
        return args -> {
            if (!userRepository.existsByUsername(ADMIN_USER_NAME)) {
                roleRepository.save(Role.builder()
                        .name(PredefinedRole.USER_ROLE)
                        .description("User role")
                        .build());
                roleRepository.save(Role.builder()
                        .name(PredefinedRole.MANEGE_ROLE)
                        .description("Manege role")
                        .build());
                Role role = roleRepository.save(Role.builder()
                        .name(PredefinedRole.ADMIN_ROLE)
                        .description("Admin role")
                        .build());
                User user = User.builder()
                        .username(ADMIN_USER_NAME)
                        .password(passwordEncoder.encode(ADMIN_PASSWORD))
                        .active(true)
                        .role(role)
                        .onCreate(new Date())
                        .onUpdate(new Date())
                        .build();

                userRepository.save(user);
                log.info("{} user has been create with default password: {}, please change it", ADMIN_USER_NAME, ADMIN_PASSWORD);
            }
        };
    }
}
