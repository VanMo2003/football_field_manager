package com.example.football_field_manager.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UpdateFootballFieldRequest {
    String name;
    String description;
    String location;
    BigDecimal price;
    Integer totalPitches;
}
