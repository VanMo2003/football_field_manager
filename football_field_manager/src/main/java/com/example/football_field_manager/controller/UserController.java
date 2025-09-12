package com.example.football_field_manager.controller;

import com.example.football_field_manager.dto.request.UserCreateRequest;
import com.example.football_field_manager.dto.request.UserUpdateInfoRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.UserResponse;
import com.example.football_field_manager.service.UserService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    UserService userService;

    @GetMapping
    ApiResponse<List<UserResponse>> getAllUsers() {
        log.warn("call api [GET] /user {}", new Date());

        var authentication = SecurityContextHolder.getContext().getAuthentication();
        log.info("Username : {}", authentication.getName());
        authentication.getAuthorities().forEach(grantedAuthority -> log.info(grantedAuthority.getAuthority()));

        ApiResponse<List<UserResponse>> response = new ApiResponse<>();
        response.setData(userService.getAllUsers());
        log.info("==> [1000][GET] /user");
        return response;
    }

    @GetMapping("/{userId}")
    ApiResponse<UserResponse> getUserById(@PathVariable String userId) {
        log.warn("call api [GET] /user/{userId} {}", new Date());
        ApiResponse<UserResponse> response = new ApiResponse<>();
        response.setData(userService.getUserById(userId));
        log.info("==> [1000][GET] /user/{userId}");
        return response;
    }

    @PostMapping
    ApiResponse<UserResponse> createUser(@RequestBody @Valid UserCreateRequest request) {
        log.warn("call api [POST] /user {}", new Date());
        ApiResponse<UserResponse> response = new ApiResponse<>();
        response.setData(userService.createUser(request));
        log.info("==> [1000][POST] /user");
        return response;
    }
    @PutMapping("/{userId}")
    ApiResponse<UserResponse> updateInfoUserById(@PathVariable String userId, @RequestBody @Valid UserUpdateInfoRequest request){
        log.warn("call api [PUT] /user/{userId} {}", new Date());
        ApiResponse<UserResponse> response = new ApiResponse<>();
        response.setData(userService.updateInfoUserById(userId, request));
        log.info("==> [1000][PUT] /user/{userId}");
        return response;
    }
}
