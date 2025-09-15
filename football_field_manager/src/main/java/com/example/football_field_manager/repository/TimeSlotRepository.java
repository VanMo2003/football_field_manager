package com.example.football_field_manager.repository;


import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface TimeSlotRepository extends JpaRepository<TimeSlot, Long> {
    @Query(
            nativeQuery = true,
            value =
                    """
			SELECT *\s
			FROM football_field_manager.time_slot
			where (football_field_manager.time_slot.start_time between :startTime and :endTime
			or football_field_manager.time_slot.end_time between :startTime and  :endTime
			or :startTime between football_field_manager.time_slot.start_time and football_field_manager.time_slot.end_time)
			and football_field_manager.time_slot.football_field_id = :footballFieldId;
		""")
    Optional<TimeSlot> findTimeSlotIntersectStartTimeAndEndTime(
			@Param("startTime") LocalTime startTime,
			@Param("endTime") LocalTime endTime,
			@Param("footballFieldId") Long footballFieldId
	);
}
