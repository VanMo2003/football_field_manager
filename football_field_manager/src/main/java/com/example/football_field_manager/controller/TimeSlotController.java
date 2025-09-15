package com.example.football_field_manager.controller;


import com.example.football_field_manager.dto.request.TimeSlotRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.TimeSlotResponse;
import com.example.football_field_manager.service.TimeSlotService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/timeslot")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class TimeSlotController {
    TimeSlotService timeSlotService;
    @GetMapping
    ApiResponse<List<TimeSlotResponse>> getAllTimeSlotByFootballField(@RequestParam("football_field_id") Long footballFieldId){
        log.warn("call api [GET] /timeslot?football_field_id=id");
        ApiResponse<List<TimeSlotResponse>> response = new ApiResponse<>();
        response.setData(timeSlotService.getAllTimeSlotByFootballField(footballFieldId));
        log.info("==> [1000][GET] /timeslot?football_field_id=id");
        return response;
    }

    @PostMapping
    ApiResponse<TimeSlotResponse> createTimeSlot(@RequestBody @Valid TimeSlotRequest request){
        log.warn("call api [POST] /timeslot");
        ApiResponse<TimeSlotResponse> response = new ApiResponse<>();
        response.setData(timeSlotService.createTimeSlot(request));
        log.info("==> [1000][POST] /timeslot");
        return response;
    }
    @PutMapping("/{id}")
    ApiResponse<TimeSlotResponse> updateTimeSlot(@PathVariable Long id,@RequestBody @Valid TimeSlotRequest request){
        log.warn("call api [PUT] /timeslot/{id}");
        ApiResponse<TimeSlotResponse> response = new ApiResponse<>();
        response.setData(timeSlotService.updateTimeSlot(id, request));
        log.info("==> [1000][PUT] /timeslot/{id}");
        return response;
    }

    @DeleteMapping("/{id}")
    ApiResponse<String> deleteTimeSlot(@PathVariable Long id){
        log.warn("call api [DELETE] /timeslot/{id}");
        timeSlotService.deleteTimeSlotById(id);
        log.info("==> [1000][DELETE] /timeslot/{id}");
        return ApiResponse.<String>builder()
                .data("Timeslot has been deleted")
                .build();
    }
}
