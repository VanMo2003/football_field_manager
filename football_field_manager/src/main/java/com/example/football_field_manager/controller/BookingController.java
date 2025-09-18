package com.example.football_field_manager.controller;

import com.example.football_field_manager.dto.request.BookingRequest;
import com.example.football_field_manager.dto.request.BookingUpdateRequest;
import com.example.football_field_manager.dto.response.ApiResponse;
import com.example.football_field_manager.dto.response.BookingResponse;
import com.example.football_field_manager.service.BookingService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/booking")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class BookingController {
    BookingService bookingService;
    @GetMapping("/getAllByUser/{userPhoneNumber}")
    ApiResponse<List<BookingResponse>> getAllBookingByUser(@PathVariable String userPhoneNumber){
        log.warn("call api [POST] /booking/getAllByUser/{userPhoneNumber}");
        ApiResponse<List<BookingResponse>> response = new ApiResponse<>();
        response.setData(bookingService.getAllBookingByUser(userPhoneNumber));
        log.info("==> [1000][POST] /booking/getAllByUser/{userPhoneNumber}");
        return response;
    }

    @GetMapping("/getAllByFootballField/{userPhoneNumber}")
    ApiResponse<List<BookingResponse>> getAllBookingByFootballField(@PathVariable Long userPhoneNumber){
        log.warn("call api [POST] /booking/getAllByFootballField/{userPhoneNumber}");
        ApiResponse<List<BookingResponse>> response = new ApiResponse<>();
        response.setData(bookingService.getAllBookingByFootballField(userPhoneNumber));
        log.info("==> [1000][POST] /booking/getAllByFootballField/{userPhoneNumber}");
        return response;
    }

    @PostMapping
    ApiResponse<BookingResponse> createBooking(@RequestBody @Valid BookingRequest request){
        log.warn("call api [POST] /booking");
        ApiResponse<BookingResponse> response = new ApiResponse<>();
        response.setData(bookingService.createBooking(request));
        log.info("==> [1000][POST] /booking");
        return response;
    }

    @PutMapping("/{bookingId}")
    ApiResponse<BookingResponse> updateBooking(@PathVariable Long bookingId, @RequestBody @Valid BookingUpdateRequest request){
        log.warn("call api [PUT] /booking/{bookingId}");
        ApiResponse<BookingResponse> response = new ApiResponse<>();
        response.setData(bookingService.updateBooking(bookingId, request));
        log.info("==> [1000][PUT] /booking/{bookingId}");
        return response;
    }
}
