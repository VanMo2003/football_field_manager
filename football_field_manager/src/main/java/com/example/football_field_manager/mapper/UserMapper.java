package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.UserRequest;
import com.example.football_field_manager.dto.response.UserResponse;
import com.example.football_field_manager.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {
    User toUser(UserRequest request);

    UserResponse toUserResponse(User user);
}
