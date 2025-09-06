package com.example.football_field_manager.constant;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum Gender {
    NAM("Nam"),
    NU("Nữ");

    private final String gender;

    Gender(String gender) {
        this.gender = gender;
    }

    @JsonValue
    public String getGender() {
        return gender;
    }

    @JsonCreator
    public static Gender fromValue(String value) {
        for (Gender g : values()) {
            if (g.gender.equalsIgnoreCase(value)) {
                return g;
            }
        }
        throw new IllegalArgumentException("Giới tính không hợp lệ không hợp lệ: " + value);
    }
}
