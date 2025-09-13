package com.example.football_field_manager.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalTime;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TimeSlot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @NotNull(message = "thời gian bắt đầu ca không được bỏ trống")
    LocalTime startTime;
    @NotNull(message = "thời gian kết thúc ca không được bỏ trống")
    LocalTime endTime;
    @NotNull(message = "giá ca không được bỏ trống")
    @Column(nullable = false, precision = 15, scale = 2)
    BigDecimal price;
    @CreationTimestamp
    @Column(updatable = false)
    Date onCreate;
    @UpdateTimestamp
    Date onUpdate;
}
