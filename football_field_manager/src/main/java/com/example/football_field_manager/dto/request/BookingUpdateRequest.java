package com.example.football_field_manager.dto.request;

import com.example.football_field_manager.constant.BookingStatus;
import com.example.football_field_manager.constant.PaymentStatus;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BookingUpdateRequest {
    String userPhoneNumber;

    Long timeSlotId;

    Integer pitchNumber;

    Set<Long> serviceIds = new HashSet<>();

    BigDecimal price;
}
