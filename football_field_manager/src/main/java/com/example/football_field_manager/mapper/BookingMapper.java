package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.BookingRequest;
import com.example.football_field_manager.dto.request.BookingUpdateRequest;
import com.example.football_field_manager.dto.response.BookingResponse;
import com.example.football_field_manager.entity.Booking;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface BookingMapper {
    Booking toBooking(BookingRequest request);
    BookingResponse toBookingResponse(Booking booking);
    void updateBooking(@MappingTarget Booking booking, BookingUpdateRequest request);
}
