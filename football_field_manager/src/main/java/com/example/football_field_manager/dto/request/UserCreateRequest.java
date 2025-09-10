package com.example.football_field_manager.dto.request;

import com.example.football_field_manager.constant.Gender;
import com.example.football_field_manager.constant.Province;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserCreateRequest {
    String username;
    String password;
    String fullName;
    String phoneNumber;
    Gender gender;

    LocalDate dateOfBirth;
    Province hometown;
    String address;

    boolean active = true;

    Date onCreate = new Date();
    Date onUpdate = new Date();
}
