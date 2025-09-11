package com.example.football_field_manager.dto.request;

import com.example.football_field_manager.constant.Gender;
import com.example.football_field_manager.constant.Province;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserRequest {
    String username;
    String password;
    String fullName;
    String phoneNumber;
    @Enumerated(EnumType.STRING)
    Gender gender;
    LocalDate dateOfBirth;
    @Enumerated(EnumType.STRING)
    Province hometown;
    String address;

    boolean active = true;

    Date onCreate = new Date();
    Date onUpdate = new Date();
}
