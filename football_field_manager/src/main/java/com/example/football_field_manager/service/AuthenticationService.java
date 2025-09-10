package com.example.football_field_manager.service;


import com.example.football_field_manager.dto.request.AuthenticationRequest;
import com.example.football_field_manager.dto.response.AuthenticationResponse;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationService {
    UserRepository userRepository;
    public AuthenticationResponse authentication(AuthenticationRequest request)  {
        AuthenticationResponse authenticationResponse = new AuthenticationResponse();

        authenticationResponse.setAuthenticated(userRepository.findByUsername(request.getUsername())
                .map(user -> request.getPassword().equals(user.getPassword()))
                .orElseThrow(() -> new AppException(ErrorCode.INCORRECT_ACCOUNT_OR_PASSWORD)));
        return authenticationResponse;
    }
}
