package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.RoleRequest;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.entity.Role;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RoleMapper {
    Role toRole(RoleRequest request);
    RoleResponse toRoleResponse(Role role);
}
