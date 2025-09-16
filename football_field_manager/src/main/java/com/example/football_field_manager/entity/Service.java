package com.example.football_field_manager.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Value;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Service {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String name;
    @Length(max = 1000)
    String description;
    @NotNull(message = "giá dịch vụ không được bỏ trống")
    @Column(nullable = false, precision = 15, scale = 2)
    BigDecimal price;
    int quantity;
    @ManyToOne
    @JoinColumn(name = "football_field_id", nullable = false)
    FootballField footballField;
    boolean status;
    @CreationTimestamp
    @Column(updatable = false)
    Date onCreate;
    @UpdateTimestamp
    Date onUpdate;
}
