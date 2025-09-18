package com.example.football_field_manager.repository;


import com.example.football_field_manager.entity.Booking;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    Optional<Booking> findBookingByFootballFieldAndTimeSlotAndPitchNumber(FootballField footballField, TimeSlot timeSlot, Integer pitchNumber);
}
