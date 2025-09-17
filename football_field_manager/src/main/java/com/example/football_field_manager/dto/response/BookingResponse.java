package com.example.football_field_manager.dto.response;

import com.example.football_field_manager.constant.BookingStatus;
import com.example.football_field_manager.constant.PaymentStatus;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BookingResponse {
    Long id;

    String orderCode;

    LocalDate bookingDate;

    String userPhoneNumber;

    FootballFieldResponse footballField;

    TimeSlotBookingResponse timeSlot;

    Set<ServiceBookingResponse> services;

    BookingStatus bookingStatus;

    PaymentStatus paymentStatus;

    BigDecimal price;

    Date onCreate;

    Date onUpdate;
}
