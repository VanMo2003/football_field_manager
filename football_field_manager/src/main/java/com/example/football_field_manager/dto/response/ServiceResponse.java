package com.example.football_field_manager.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ServiceResponse {
    Long id;
    String name;
    String description;
    BigDecimal price;
    int quantity;
    boolean status;
    Date onCreate;
    Date onUpdate;
}
