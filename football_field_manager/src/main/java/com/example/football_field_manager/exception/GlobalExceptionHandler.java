package com.example.football_field_manager.exception;

import com.example.football_field_manager.dto.response.ApiResponse;
import com.nimbusds.jose.JOSEException;
import jakarta.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.TransactionSystemException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.text.ParseException;

@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(value = Exception.class)
    ResponseEntity<ApiResponse> handlingRuntimeException(Exception exception){
        log.error("Exception : " + exception.getMessage());

        ApiResponse apiResponse = new ApiResponse();

        apiResponse.setCode(ErrorCode.UNCATEGORIZED_EXCEPTION.getCode());
        apiResponse.setMessage(ErrorCode.UNCATEGORIZED_EXCEPTION.getMessage());

        return ResponseEntity.badRequest().body(apiResponse);
    }

    @ExceptionHandler(value = { ParseException.class, JOSEException.class })
    ResponseEntity<ApiResponse> handleJwtException(Exception exception){
        log.error("JWT Exception: " + exception.getMessage());

        ApiResponse apiResponse = new ApiResponse();
        apiResponse.setCode(ErrorCode.INVALID_TOKEN.getCode());
        apiResponse.setMessage("Invalid or malformed JWT token");

        return ResponseEntity.badRequest().body(apiResponse);
    }

    @ExceptionHandler(value = AppException.class)
    ResponseEntity<ApiResponse> handlingAppException(AppException exception) {
        log.error("AppException : " + exception.getMessage());
        ErrorCode errorCode = exception.getErrorCode();
        ApiResponse apiResponse = new ApiResponse();

        apiResponse.setCode(errorCode.getCode());
        apiResponse.setMessage(errorCode.getMessage());

        return ResponseEntity.status(errorCode.getStatusCode()).body(apiResponse);
    }

    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    ResponseEntity<ApiResponse> handlingMethodArgumentNotValidException(MethodArgumentNotValidException exception){
        log.error("MethodArgumentNotValidException : " + exception.getMessage());
        ApiResponse apiResponse = new ApiResponse();

        apiResponse.setCode(422);
        apiResponse.setMessage(exception.getFieldError().getDefaultMessage());

        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body(apiResponse);
    }

    @ExceptionHandler(value = TransactionSystemException.class)
    ResponseEntity<ApiResponse> handlingTransactionSystemException(TransactionSystemException exception){
        log.error("TransactionSystemException : " + exception.getMessage());
        Throwable cause = exception.getRootCause();
        ApiResponse apiResponse = new ApiResponse();

        if (cause instanceof ConstraintViolationException constraintViolationException) {
            String message = constraintViolationException.getConstraintViolations()
                    .stream()
                    .map(cv -> cv.getMessage())
                    .findFirst()
                    .orElse("Validation error");

            apiResponse.setCode(422);
            apiResponse.setMessage(message);

            return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY).body(apiResponse);
        }

        apiResponse.setCode(ErrorCode.UNCATEGORIZED_EXCEPTION.getCode());
        apiResponse.setMessage(ErrorCode.UNCATEGORIZED_EXCEPTION.getMessage());
        return ResponseEntity.badRequest().body(apiResponse);
    }
}
