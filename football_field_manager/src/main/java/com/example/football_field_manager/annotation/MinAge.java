package com.example.football_field_manager.annotation;

import com.example.football_field_manager.validator.MinAgeValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;


@Documented
@Constraint(validatedBy = MinAgeValidator.class)
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface MinAge {
    int value();
    String message() default "Tuổi phải lớn hơn hoặc bằng {value}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
