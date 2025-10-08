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

import java.time.LocalDate;
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
        log.warn("call api [GET] /booking/getAllByUser/{userPhoneNumber}");
        ApiResponse<List<BookingResponse>> response = new ApiResponse<>();
        response.setData(bookingService.getAllBookingByUser(userPhoneNumber));
        log.info("==> [1000][GET] /booking/getAllByUser/{userPhoneNumber}");
        return response;
    }

    @GetMapping("/getAllByFootballField/{userPhoneNumber}")
    ApiResponse<List<BookingResponse>> getAllBookingByFootballField(@PathVariable Long userPhoneNumber){
        log.warn("call api [GET] /booking/getAllByFootballField/{userPhoneNumber}");
        ApiResponse<List<BookingResponse>> response = new ApiResponse<>();
        response.setData(bookingService.getAllBookingByFootballField(userPhoneNumber));
        log.info("==> [1000][GET] /booking/getAllByFootballField/{userPhoneNumber}");
        return response;
    }

    @GetMapping("/getAllBookingByBookingDate/{footballFieldId}/{bookingDate}")
    ApiResponse<List<BookingResponse>> getAllBookingByBookingDate(@PathVariable Long footballFieldId,@PathVariable LocalDate bookingDate){
        log.warn("call api [GET] /booking/getAllBookingByBookingDate/{bookingDate}");
        ApiResponse<List<BookingResponse>> response = new ApiResponse<>();
        response.setData(bookingService.getAllBookingByBookingDate(footballFieldId, bookingDate));
        log.info("==> [1000][GET] /booking/getAllBookingByBookingDate/{bookingDate}");
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

    @PutMapping("/confirmBooking/{bookingId}")
    ApiResponse<BookingResponse> confirmBooking(@PathVariable Long bookingId){
        log.warn("call api [PUT] /booking/confirmBooking/{bookingId}");
        ApiResponse<BookingResponse> response = new ApiResponse<>();
        response.setData(bookingService.confirmBooking(bookingId));
        log.info("==> [1000][PUT] /booking/confirmBooking/{bookingId}");
        return response;
    }

    @PutMapping("/completeBooking/{bookingId}")
    ApiResponse<BookingResponse> completeBooking(@PathVariable Long bookingId){
        log.warn("call api [PUT] /booking/completeBooking/{bookingId}");
        ApiResponse<BookingResponse> response = new ApiResponse<>();
        response.setData(bookingService.completeBooking(bookingId));
        log.info("==> [1000][PUT] /booking/completeBooking/{bookingId}");
        return response;
    }

    @PutMapping("/cancelBooking/{bookingId}")
    ApiResponse<BookingResponse> cancelBooking(@PathVariable Long bookingId){
        log.warn("call api [PUT] /booking/cancelBooking/{bookingId}");
        ApiResponse<BookingResponse> response = new ApiResponse<>();
        response.setData(bookingService.cancelBooking(bookingId));
        log.info("==> [1000][PUT] /booking/cancelBooking/{bookingId}");
        return response;
    }
}
