package com.example.football_field_manager.controller;

import com.example.football_field_manager.dto.request.RoleRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.service.RoleService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/role")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class RoleController {
    RoleService roleService;

    @GetMapping
    ApiResponse<List<RoleResponse>> getAllRole() {
        log.warn("call api [GET] /role");
        ApiResponse<List<RoleResponse>> response = new ApiResponse<>();
        response.setData(roleService.getAllRole());
        log.info("==> [1000][GET] /role");
        return response;
    }

    @PostMapping
    ApiResponse<RoleResponse> createUser(@RequestBody @Valid RoleRequest request) {
        log.warn("call api [POST] /role");
        ApiResponse<RoleResponse> response = new ApiResponse<>();
        response.setData(roleService.createRole(request));
        log.info("==> [1000][POST] /role");
        return response;
    }
}
