package com.example.football_field_manager.controller;


import com.example.football_field_manager.dto.request.FootballFieldRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.FootballFieldResponse;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.service.FootballFieldService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/football-field")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class FootballFieldController {
    FootballFieldService footballFieldService;

    @PostMapping
    ApiResponse<FootballFieldResponse> createFootballField(@RequestBody @Valid FootballFieldRequest request){
        log.warn("call api [POST] /football-field");
        ApiResponse<FootballFieldResponse> response = new ApiResponse<>();
        response.setData(footballFieldService.createFootballField(request));
        log.info("==> [1000][POST] /football-field");
        return response;
    }
}
