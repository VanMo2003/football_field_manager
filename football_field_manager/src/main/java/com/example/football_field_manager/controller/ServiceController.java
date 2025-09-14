package com.example.football_field_manager.controller;


import com.example.football_field_manager.dto.request.RoleRequest;
import com.example.football_field_manager.dto.request.ServiceRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.dto.response.ServiceResponse;
import com.example.football_field_manager.service.ServiceService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/service")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ServiceController {
    ServiceService serviceService;

    @PostMapping
    ApiResponse<ServiceResponse> createUser(@RequestBody @Valid ServiceRequest request) {
        log.warn("call api [POST] /service");
        ApiResponse<ServiceResponse> response = new ApiResponse<>();
        response.setData(serviceService.createService(request));
        log.info("==> [1000][POST] /service");
        return response;
    }
}
