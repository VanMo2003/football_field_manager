package com.example.football_field_manager.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserResponse {
    String id;
    String username;
    String fullName;
    String phoneNumber;
    String gender;
    LocalDate dateOfBirth;
    String hometown;
    String address;
    RoleResponse role;

    boolean active;

    Date onCreate;
    Date onUpdate;
}
