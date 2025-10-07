package com.example.football_field_manager.repository;


import com.example.football_field_manager.entity.Booking;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    Optional<Booking> findBookingByBookingDateAndFootballFieldAndTimeSlotAndPitchNumber(
            LocalDate bookingDate,
            FootballField footballField,
            TimeSlot timeSlot,
            Integer pitchNumber);

    List<Booking> findBookingByUserPhoneNumber(String userPhoneNumber);
    List<Booking> findBookingByFootballField(FootballField footballField);
    List<Booking> findBookingByFootballFieldAndBookingDate(FootballField footballField, LocalDate localDate);
}
