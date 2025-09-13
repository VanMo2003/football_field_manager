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

@RestController
@RequestMapping("/timeslot")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class TimeSlotController {
    TimeSlotService timeSlotService;

    @PostMapping
    ApiResponse<TimeSlotResponse> createTimeSlot(@RequestBody @Valid TimeSlotRequest request){
        log.warn("call api [POST] /timeslot");
        ApiResponse<TimeSlotResponse> response = new ApiResponse<>();
        response.setData(timeSlotService.createTimeSlot(request));
        log.info("==> [1000][POST] /timeslot");
        return response;
    }

}
