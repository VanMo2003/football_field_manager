package com.example.football_field_manager.entity;

import com.example.football_field_manager.annotation.MinAge;
import com.example.football_field_manager.constant.Gender;
import com.example.football_field_manager.constant.Province;
import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.validator.constraints.Length;

import java.time.LocalDate;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;

    @NotNull
    @Length(min = 3, message = "username must be at least 3 characters")
    String username;


    @NotNull
    @Length(min = 6, message = "password must be at least 6 characters")
    String password;

    @Nullable
    String fullName;


    @Pattern(
            regexp = "0\\d{9}",
            message = "Số điện thoại phải bắt đầu bằng 0 và có đúng 10 chữ số"
    )
    @NonNull
    String phoneNumber;

    @Enumerated(EnumType.STRING)
    @NotNull(message = "Giới tính không được để trống")
    Gender gender;

    @MinAge(value = 16)
    LocalDate dateOfBirth;

    @Enumerated(EnumType.STRING)
    @NotNull(message = "Tỉnh/Thành không được để trống")
    Province hometown;

    @Nullable
    String address;

    @ManyToOne
    Role role;

    @NotNull
    boolean active;

    @NotNull
    Date onCreate;
    @NotNull
    Date onUpdate;
}

