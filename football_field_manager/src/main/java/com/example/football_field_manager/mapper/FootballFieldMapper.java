package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.FootballFieldRequest;
import com.example.football_field_manager.dto.request.RoleRequest;
import com.example.football_field_manager.dto.response.FootballFieldResponse;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.Role;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface FootballFieldMapper {

    FootballField toFootballField(FootballFieldRequest request);
    FootballFieldResponse toFootballFieldResponse(FootballField footballField);
    void updateFootballField(@MappingTarget FootballField footballField, FootballFieldRequest request);
}
