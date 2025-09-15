package com.example.football_field_manager.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalTime;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TimeSlotResponse {
    Long id;
    LocalTime startTime;
    LocalTime endTime;
    double price;
    Date onCreate;
    Date onUpdate;
}
