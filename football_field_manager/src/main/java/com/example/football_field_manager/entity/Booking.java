package com.example.football_field_manager.entity;

import com.example.football_field_manager.constant.BookingStatus;
import com.example.football_field_manager.constant.PaymentStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    String orderCode;

    LocalDate bookingDate;

    @Pattern(
            regexp = "0\\d{9}",
            message = "Số điện thoại phải bắt đầu bằng 0 và có đúng 10 chữ số"
    )
    @NotNull
    String userPhoneNumber;

    @ManyToOne
    @JoinColumn(name = "football_field_id", nullable = false)
    FootballField footballField;

    @ManyToOne
    @JoinColumn(name = "time_slot_id", nullable = false)
    TimeSlot timeSlot;

    @ManyToMany
    Set<Service> services;

    @Enumerated(EnumType.STRING)
    BookingStatus bookingStatus;

    @Enumerated(EnumType.STRING)
    PaymentStatus paymentStatus;

    @NotNull(message = "tổng tiền không được bỏ trống")
    @Column(nullable = false, precision = 15)
    BigDecimal price;

    @CreationTimestamp
    @Column(updatable = false)
    Date onCreate;

    @UpdateTimestamp
    Date onUpdate;
}
