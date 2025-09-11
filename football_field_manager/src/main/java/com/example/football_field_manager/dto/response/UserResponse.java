package com.example.football_field_manager.dto.response;

import com.example.football_field_manager.constant.Gender;
import com.example.football_field_manager.constant.Province;
import com.example.football_field_manager.entity.Role;
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
    Gender gender;
    LocalDate dateOfBirth;
    Province hometown;
    String address;
    RoleResponse role;

    boolean active;

    Date onCreate;
    Date onUpdate;
}
