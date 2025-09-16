package com.example.football_field_manager.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ServiceRequest {
    String name;
    String description;
    BigDecimal price;
    int quantity = 1;
    boolean status = true;
    Long footballFieldId;
}
