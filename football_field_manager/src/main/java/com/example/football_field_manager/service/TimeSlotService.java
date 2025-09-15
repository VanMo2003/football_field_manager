package com.example.football_field_manager.service;


import com.example.football_field_manager.dto.request.TimeSlotRequest;
import com.example.football_field_manager.dto.response.TimeSlotResponse;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.TimeSlot;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.TimeSlotMapper;
import com.example.football_field_manager.repository.FootballFieldRepository;
import com.example.football_field_manager.repository.TimeSlotRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class TimeSlotService {
    TimeSlotRepository timeSlotRepository;
    TimeSlotMapper timeSlotMapper;
    FootballFieldRepository footballFieldRepository;

    @PreAuthorize("hasRole('MANEGE')")
    public List<TimeSlotResponse> getAllTimeSlotByFootballField(Long footballFieldId){
        FootballField footballField = footballFieldRepository.findById(footballFieldId).orElseThrow(() -> new AppException(ErrorCode.FOOTBALL_FIELD_NOT_EXIST));

        List<TimeSlotResponse> timeSlotResponses = new ArrayList<>();
        timeSlotRepository.findAllByFootballField(footballField).stream().map(timeSlot ->
                timeSlotResponses.add(timeSlotMapper.toTimeSlotResponse(timeSlot))
        ).toList();

        timeSlotResponses.sort(Comparator.comparing(TimeSlotResponse::getStartTime));
        return timeSlotResponses;
    }

    @PreAuthorize("hasRole('MANEGE')")
    public TimeSlotResponse createTimeSlot(TimeSlotRequest request){
        FootballField footballField = footballFieldRepository.findById(request.getFootballFieldId()).orElseThrow(() -> new AppException(ErrorCode.FOOTBALL_FIELD_NOT_EXIST));

        Optional<TimeSlot> timeSlotFind = timeSlotRepository.findTimeSlotIntersectStartTimeAndEndTime(
                request.getStartTime(), request.getEndTime(), request.getFootballFieldId()
        );

        if (timeSlotFind.isPresent()) throw new AppException(ErrorCode.TIMESLOT_EXISTED);

        TimeSlot timeSlot = timeSlotMapper.toTimeSlot(request);

        timeSlot.setFootballField(footballField);
        timeSlotRepository.save(timeSlot);

        TimeSlotResponse timeSlotResponse = timeSlotMapper.toTimeSlotResponse(timeSlot);

        return timeSlotResponse;
    }

    @PreAuthorize("hasRole('MANEGE')")
    public TimeSlotResponse updateTimeSlot(Long id, TimeSlotRequest request){
        TimeSlot timeSlot = timeSlotRepository.findById(id).orElseThrow(() -> new AppException(ErrorCode.TIMESLOT_NOT_EXIST));

        timeSlotMapper.updateTimeslot(timeSlot, request);

        timeSlotRepository.save(timeSlot);
        TimeSlotResponse timeSlotResponse = timeSlotMapper.toTimeSlotResponse(timeSlot);

        return timeSlotResponse;
    }

    @PreAuthorize("hasRole('MANEGE')")
    public void deleteTimeSlotById(Long id){
        timeSlotRepository.deleteById(id);
    }
}
