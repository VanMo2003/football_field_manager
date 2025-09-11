package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.UserCreateRequest;
import com.example.football_field_manager.dto.request.UserUpdateInfoRequest;
import com.example.football_field_manager.dto.response.UserResponse;
import com.example.football_field_manager.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "role", ignore = true)
    User toUser(UserCreateRequest request);

    @Mapping(target = "role", ignore = true)
    UserResponse toUserResponse(User user);
    void updateInfoUser(@MappingTarget User user, UserUpdateInfoRequest request);
}
