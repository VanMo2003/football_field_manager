package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.BookingRequest;
import com.example.football_field_manager.dto.response.BookingResponse;
import com.example.football_field_manager.entity.Booking;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookingMapper {
    Booking toBooking(BookingRequest request);
    BookingResponse toBookingResponse(Booking booking);
}
