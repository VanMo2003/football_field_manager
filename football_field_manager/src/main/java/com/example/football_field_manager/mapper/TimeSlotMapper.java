package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.TimeSlotRequest;
import com.example.football_field_manager.dto.request.UserUpdateInfoRequest;
import com.example.football_field_manager.dto.response.TimeSlotResponse;
import com.example.football_field_manager.entity.TimeSlot;
import com.example.football_field_manager.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface TimeSlotMapper {
    TimeSlot toTimeSlot(TimeSlotRequest request);
    TimeSlotResponse toTimeSlotResponse(TimeSlot timeSlot);
    void updateTimeslot(@MappingTarget TimeSlot timeSlot, TimeSlotRequest request);
}
