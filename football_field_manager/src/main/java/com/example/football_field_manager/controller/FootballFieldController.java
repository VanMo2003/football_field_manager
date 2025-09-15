package com.example.football_field_manager.controller;


import com.example.football_field_manager.dto.request.FootballFieldRequest;
import com.example.football_field_manager.dto.request.UpdateFootballFieldRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.FootballFieldResponse;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.service.FootballFieldService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/football-field")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class FootballFieldController {
    FootballFieldService footballFieldService;

    @GetMapping
    ApiResponse<List<FootballFieldResponse>> getAllFootballField(){
        log.warn("call api [GET] /football-field");
        ApiResponse<List<FootballFieldResponse>> response = new ApiResponse<>();
        response.setData(footballFieldService.getAllFootballField());
        log.info("==> [1000][GET] /football-field");
        return response;
    }

    @PostMapping
    ApiResponse<FootballFieldResponse> createFootballField(@RequestBody @Valid FootballFieldRequest request){
        log.warn("call api [POST] /football-field");
        ApiResponse<FootballFieldResponse> response = new ApiResponse<>();
        response.setData(footballFieldService.createFootballField(request));
        log.info("==> [1000][POST] /football-field");
        return response;
    }

    @PutMapping("/{id}")
    ApiResponse<FootballFieldResponse> updateFootballField(@PathVariable Long id, @RequestBody @Valid UpdateFootballFieldRequest request){
        log.warn("call api [PUT] /football-field/{id}");
        ApiResponse<FootballFieldResponse> response = new ApiResponse<>();
        response.setData(footballFieldService.updateFootballField(id, request));
        log.info("==> [1000][PUT] /football-field/{id}");
        return response;
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteFootballField(@PathVariable Long id){
        log.warn("call api [DELETE] /football-field/{id}");
        footballFieldService.deleteFootballFieldById(id);
        log.info("==> [1000][DELETE] /football-field/{id}");
        return ApiResponse.<String>builder()
                .data("Football field has been deleted")
                .build();
    }
}
