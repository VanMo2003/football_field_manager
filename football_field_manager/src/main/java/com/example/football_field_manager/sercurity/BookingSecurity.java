package com.example.football_field_manager.sercurity;

import com.example.football_field_manager.entity.Booking;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.repository.BookingRepository;
import com.example.football_field_manager.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Component;

@Component("BookingSecurity")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class BookingSecurity {
    UserRepository userRepository;
    BookingRepository bookingRepository;
    public boolean isOwner(Long bookingId, String username){
        User userLogin = userRepository.findByUsername(username).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        Booking booking = bookingRepository.findById(bookingId).orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_EXISTED));

        return userLogin.getPhoneNumber().equals(booking.getUserPhoneNumber());
    }

    public boolean isFootballFieldOwner(Long bookingId, String username){
        Booking booking = bookingRepository.findById(bookingId).orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_EXISTED));

        return booking.getFootballField().getUser().getUsername().equals(username);
    }
}
