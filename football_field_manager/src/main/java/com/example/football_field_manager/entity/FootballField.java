package com.example.football_field_manager.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.validator.constraints.Length;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FootballField {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String name;
    @Length(max = 1000)
    String description;
    String location;

    @NotNull(message = "giá mặc định của sân không được bỏ trống")
    @Column(nullable = false, precision = 15)
    BigDecimal price;

    @Min(1)
    @Column(nullable = false)
    @NotNull(message = "Số lượng sân không được để trống")
    Integer totalPitches;

    boolean active;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;
    @CreationTimestamp
    @Column(updatable = false)
    Date onCreate;
    @UpdateTimestamp
    Date onUpdate;
}
