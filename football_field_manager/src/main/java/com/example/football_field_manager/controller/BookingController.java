package com.example.football_field_manager.controller;

import com.example.football_field_manager.dto.request.BookingRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.BookingResponse;
import com.example.football_field_manager.service.BookingService;
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
@RequestMapping("/booking")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class BookingController {
    BookingService bookingService;

    @PostMapping
    ApiResponse<BookingResponse> createBooking(@RequestBody @Valid BookingRequest request){
        log.warn("call api [POST] /booking");
        ApiResponse<BookingResponse> response = new ApiResponse<>();
        response.setData(bookingService.createBooking(request));
        log.info("==> [1000][POST] /booking");
        return response;
    }
}
