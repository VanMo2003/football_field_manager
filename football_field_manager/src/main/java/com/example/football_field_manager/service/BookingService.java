package com.example.football_field_manager.service;

import com.example.football_field_manager.constant.BookingStatus;
import com.example.football_field_manager.dto.request.BookingRequest;
import com.example.football_field_manager.dto.request.BookingUpdateRequest;
import com.example.football_field_manager.dto.response.BookingResponse;
import com.example.football_field_manager.entity.Booking;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.Service;
import com.example.football_field_manager.entity.TimeSlot;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.BookingMapper;
import com.example.football_field_manager.repository.BookingRepository;
import com.example.football_field_manager.repository.FootballFieldRepository;
import com.example.football_field_manager.repository.ServiceRepository;
import com.example.football_field_manager.repository.TimeSlotRepository;
import com.example.football_field_manager.utils.CompareListUtil;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.*;

@org.springframework.stereotype.Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class BookingService {
    BookingMapper bookingMapper;
    BookingRepository bookingRepository;
    FootballFieldRepository footballFieldRepository;
    TimeSlotRepository timeSlotRepository;
    ServiceRepository serviceRepository;

    public List<BookingResponse> getAllBookingByUser(String userPhoneNumber){
        List<BookingResponse> bookingResponses = new ArrayList<>();

        bookingRepository.findBookingByUserPhoneNumber(userPhoneNumber).stream().map(booking ->
            bookingResponses.add(bookingMapper.toBookingResponse(booking))
        ).toList();

        return bookingResponses;
    }

    public List<BookingResponse> getAllBookingByFootballField(Long footballFieldId){
        FootballField footballField = footballFieldRepository.findById(footballFieldId).orElseThrow(() -> new AppException(ErrorCode.FOOTBALL_FIELD_NOT_EXIST));

        List<BookingResponse> bookingResponses = new ArrayList<>();

        bookingRepository.findBookingByFootballField(footballField).stream().map(booking ->
                bookingResponses.add(bookingMapper.toBookingResponse(booking))
        ).toList();

        return bookingResponses;
    }

    public BookingResponse createBooking(BookingRequest request){
        FootballField footballField = footballFieldRepository.findById(request.getFootballFieldId()).orElseThrow(() -> new AppException(ErrorCode.FOOTBALL_FIELD_NOT_EXIST));

        if (request.getPitchNumber() > footballField.getTotalPitches()) throw new AppException(ErrorCode.PITCH_NUMBER_EXCEEDS_LIMIT);

        TimeSlot timeSlot = timeSlotRepository.findById(request.getTimeSlotId()).orElseThrow(() -> new AppException(ErrorCode.TIMESLOT_NOT_EXIST));

        Optional<Booking> bookingFind = bookingRepository.findBookingByFootballFieldAndTimeSlotAndPitchNumber(footballField, timeSlot, request.getPitchNumber());

        if (bookingFind.isPresent()) throw new AppException(ErrorCode.TIMESLOT_EXISTED);

        Booking booking = bookingMapper.toBooking(request);

        booking.setFootballField(footballField);
        booking.setTimeSlot(timeSlot);
        if (!request.getServiceIds().isEmpty()) {
            booking.setServices(new HashSet<>());
            request.getServiceIds().forEach(serviceId -> {
                Service service = serviceRepository.findById(serviceId).orElseThrow(() -> new AppException(ErrorCode.SERVICE_NOT_EXIST));
                booking.getServices().add(service);
            });
        }

        BookingResponse bookingResponse = bookingMapper.toBookingResponse(booking);

        bookingRepository.save(booking);

        return bookingResponse;
    }

    public  BookingResponse updateBooking(Long bookingId, BookingUpdateRequest request){
        Booking booking = bookingRepository.findById(bookingId).orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_EXISTED));

        if (request.getPitchNumber() != booking.getPitchNumber()){
            FootballField footballField = booking.getFootballField();

            if (request.getPitchNumber() > footballField.getTotalPitches()) throw new AppException(ErrorCode.PITCH_NUMBER_EXCEEDS_LIMIT);

            TimeSlot timeSlot = booking.getTimeSlot();

            Optional<Booking> bookingFind = bookingRepository.findBookingByFootballFieldAndTimeSlotAndPitchNumber(footballField, timeSlot, request.getPitchNumber());

            if (bookingFind.isPresent()) throw new AppException(ErrorCode.TIME_SLOT_HAS_BEEN_BOOKED);
        }

        bookingMapper.updateBooking(booking, request);
        if (!CompareListUtil.compare(booking.getServices().stream().map(service -> service.getId()).toList(), request.getServiceIds().stream().toList())){
            booking.getServices().clear();

            request.getServiceIds().forEach(serviceId -> {
                Service service = serviceRepository.findById(serviceId).orElseThrow(() -> {throw new AppException(ErrorCode.SERVICE_NOT_EXIST);});
                booking.getServices().add(service);
            });
        }

        BookingResponse bookingResponse = bookingMapper.toBookingResponse(booking);

        bookingRepository.save(booking);

        return bookingResponse;
    }

    public BookingResponse confirmBooking(Long bookingId){
        Booking booking = bookingRepository.findById(bookingId).orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_EXISTED));

        booking.setBookingStatus(BookingStatus.confirmed);

        BookingResponse bookingResponse = bookingMapper.toBookingResponse(booking);

        bookingRepository.save(booking);

        return bookingResponse;
    }

    public BookingResponse completeBooking(Long bookingId){
        Booking booking = bookingRepository.findById(bookingId).orElseThrow(() -> new AppException(ErrorCode.BOOKING_NOT_EXISTED));

        booking.setBookingStatus(BookingStatus.completed);

        BookingResponse bookingResponse = bookingMapper.toBookingResponse(booking);

        bookingRepository.save(booking);

        return bookingResponse;
    }
}
