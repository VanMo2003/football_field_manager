package com.example.football_field_manager.controller;


import com.example.football_field_manager.dto.request.AuthenticationRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.AuthenticationResponse;
import com.example.football_field_manager.service.AuthenticationService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class AuthenticationController {
    AuthenticationService authenticationService;

    @PostMapping("/login")
    ApiResponse<AuthenticationResponse> getUserById(@RequestBody @Valid AuthenticationRequest request)  {
        log.warn("call api [POST] /auth/login {}", new Date());
        ApiResponse<AuthenticationResponse> response = new ApiResponse<>();
        response.setData(authenticationService.authentication(request));
        return response;
    }
}
