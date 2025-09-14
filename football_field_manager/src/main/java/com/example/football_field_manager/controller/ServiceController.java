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
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/service")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ServiceController {
    ServiceService serviceService;

    @PostMapping
    ApiResponse<ServiceResponse> createService(@RequestBody @Valid ServiceRequest request) {
        log.warn("call api [POST] /service");
        ApiResponse<ServiceResponse> response = new ApiResponse<>();
        response.setData(serviceService.createService(request));
        log.info("==> [1000][POST] /service");
        return response;
    }

    @PutMapping("/{id}")
    ApiResponse<ServiceResponse> updateService(@PathVariable Long id, @RequestBody @Valid ServiceRequest request){
        log.warn("call api [PUT] /service");
        ApiResponse<ServiceResponse> response = new ApiResponse<>();
        response.setData(serviceService.updateService(id, request));
        log.info("==> [1000][PUT] /service");
        return response;
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteService(@PathVariable Long id){
        log.warn("call api [DELETE] /service");
        serviceService.deleteService(id);
        log.info("==> [1000][DELETE] /service");
        return ApiResponse.<String>builder()
                .data("Service has been deleted")
                .build();
    }

}
