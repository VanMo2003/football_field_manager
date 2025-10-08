package com.example.football_field_manager.dto.response;


import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class FootballFieldResponse {
    Long id;
    String defaultImageUrl;
    String name;
    String description;
    String location;
    BigDecimal price;
    Integer totalPitches;
    boolean active = true;
}
