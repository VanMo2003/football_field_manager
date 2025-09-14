package com.example.football_field_manager.service;


import com.example.football_field_manager.dto.request.TimeSlotRequest;
import com.example.football_field_manager.dto.response.TimeSlotResponse;
import com.example.football_field_manager.entity.TimeSlot;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.TimeSlotMapper;
import com.example.football_field_manager.repository.TimeSlotRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class TimeSlotService {
    TimeSlotRepository timeSlotRepository;
    TimeSlotMapper timeSlotMapper;

    public TimeSlotResponse createTimeSlot(TimeSlotRequest request){
        TimeSlot timeSlot = timeSlotMapper.toTimeSlot(request);

        timeSlotRepository.save(timeSlot);
        TimeSlotResponse timeSlotResponse = timeSlotMapper.toTimeSlotResponse(timeSlot);

        return timeSlotResponse;
    }

    public TimeSlotResponse updateTimeSlot(Long id, TimeSlotRequest request){
        TimeSlot timeSlot = timeSlotRepository.findById(id).orElseThrow(() -> new AppException(ErrorCode.TIMESLOT_NOT_EXIST));

        timeSlotMapper.updateTimeslot(timeSlot, request);

        timeSlotRepository.save(timeSlot);
        TimeSlotResponse timeSlotResponse = timeSlotMapper.toTimeSlotResponse(timeSlot);

        return timeSlotResponse;
    }

    public void deleteTimeSlotById(Long id){
        timeSlotRepository.deleteById(id);
    }
}
