package com.example.football_field_manager.sercurity;

import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.repository.FootballFieldRepository;
import com.example.football_field_manager.repository.ServiceRepository;
import com.example.football_field_manager.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Component;

@Component("ServiceSecurity")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ServiceSecurity {
    ServiceRepository serviceRepository;
    UserRepository userRepository;
    FootballFieldRepository footballFieldRepository;
    public boolean isOwner(Long serviceId, String username) {
        User user = userRepository.findByUsername(username).orElseThrow(() -> new AppException(ErrorCode.ACCESS_DENIED));

        FootballField footballField = footballFieldRepository.findByUser(user).orElseThrow(() -> new AppException(ErrorCode.ACCESS_DENIED));

        return serviceRepository.findById(serviceId).get().getFootballField().equals(footballField);
    }
}
