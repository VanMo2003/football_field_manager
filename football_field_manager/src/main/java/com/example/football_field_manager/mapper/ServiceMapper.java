package com.example.football_field_manager.mapper;

import com.example.football_field_manager.dto.request.ServiceRequest;
import com.example.football_field_manager.dto.response.ServiceResponse;
import com.example.football_field_manager.entity.Service;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ServiceMapper {
    Service toService(ServiceRequest request);
    ServiceResponse toServiceResponse(Service service);
}
