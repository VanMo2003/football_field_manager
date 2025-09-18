package com.example.football_field_manager.exception;


import lombok.AccessLevel;
import lombok.Getter;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
@FieldDefaults(level = AccessLevel.PRIVATE)
public enum ErrorCode {
    UNCATEGORIZED_EXCEPTION(999, "Uncategorized error", HttpStatus.INTERNAL_SERVER_ERROR),
    CANNOT_CONNECT_TO_SERVER(1001,"can not connect to server", HttpStatus.INTERNAL_SERVER_ERROR),
    INVALID_TOKEN(1002,"Invalid token", HttpStatus.BAD_REQUEST),
    ACCESS_DENIED(1003,"Access denied", HttpStatus.UNAUTHORIZED),
    USER_NOT_EXIST(1004, "User not exist", HttpStatus.NOT_FOUND),
    USER_EXISTED(1005, "User existed", HttpStatus.CONFLICT),
    INCORRECT_ACCOUNT_OR_PASSWORD(1006, "Incorrect account or password", HttpStatus.BAD_REQUEST),
    ROLE_NOT_EXIST(1007, "Role not exist", HttpStatus.NOT_FOUND),
    ROLE_EXISTED(1008, "Role existed", HttpStatus.CONFLICT),
    FOOTBALL_FIELD_NOT_EXIST(1009, "Football field not exist", HttpStatus.NOT_FOUND),
    FOOTBALL_FIELD_EXISTED(1010, "Football field name existed", HttpStatus.CONFLICT),
    USER_OF_FOOTBALL_FIELD_EXISTED(1010, "User already owns another football field", HttpStatus.CONFLICT),
    TIMESLOT_NOT_EXIST(1011, "Timeslot not exist", HttpStatus.NOT_FOUND),
    TIMESLOT_EXISTED(1012, "Timeslot existed", HttpStatus.CONFLICT),
    SERVICE_NOT_EXIST(1013, "Service not exist", HttpStatus.NOT_FOUND),
    SERVICE_EXISTED(1014, "Service existed", HttpStatus.CONFLICT),
    BOOKING_NOT_EXISTED(1015, "Booking not existed", HttpStatus.NOT_FOUND),
    TIME_SLOT_HAS_BEEN_BOOKED(1016, "This field's time slot has been booked", HttpStatus.CONFLICT),
    PITCH_NUMBER_EXCEEDS_LIMIT(1017, "Pitch number exceeds limit", HttpStatus.BAD_REQUEST),
    ;

    private final int code;
    private final String message;
    private final HttpStatusCode statusCode;


    ErrorCode(int code, String message, HttpStatusCode statusCode) {
        this.code = code;
        this.message = message;
        this.statusCode = statusCode;
    }
}
