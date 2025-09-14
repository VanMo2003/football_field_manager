package com.example.football_field_manager.service;

import com.example.football_field_manager.dto.request.ServiceRequest;
import com.example.football_field_manager.dto.response.ServiceResponse;
import com.example.football_field_manager.entity.Service;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.ServiceMapper;
import com.example.football_field_manager.repository.ServiceRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@org.springframework.stereotype.Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ServiceService {
    ServiceRepository serviceRepository;
    ServiceMapper serviceMapper;

    public ServiceResponse createService(ServiceRequest request){
        Service service = serviceMapper.toService(request);

        serviceRepository.save(service);
        ServiceResponse serviceResponse = serviceMapper.toServiceResponse(service);

        return serviceResponse;
    }

    public ServiceResponse updateService(Long id, ServiceRequest request){
        Service service = serviceRepository.findById(id).orElseThrow(() -> new AppException(ErrorCode.SERVICE_NOT_EXIST));

        serviceMapper.updateService(service, request);

        serviceRepository.save(service);
        ServiceResponse serviceResponse = serviceMapper.toServiceResponse(service);

        return serviceResponse;
    }

    public void deleteService(Long id){
        serviceRepository.deleteById(id);
    }
}
