package com.example.football_field_manager.service;

import com.example.football_field_manager.dto.request.ServiceRequest;
import com.example.football_field_manager.dto.response.ServiceResponse;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.Service;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.ServiceMapper;
import com.example.football_field_manager.repository.FootballFieldRepository;
import com.example.football_field_manager.repository.ServiceRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.Optional;

@org.springframework.stereotype.Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ServiceService {
    ServiceRepository serviceRepository;
    ServiceMapper serviceMapper;
    FootballFieldRepository footballFieldRepository;
    public ServiceResponse createService(ServiceRequest request){
        FootballField footballField = footballFieldRepository.findById(request.getFootballFieldId()).orElseThrow(() -> new AppException(ErrorCode.FOOTBALL_FIELD_NOT_EXIST));

        Optional<Service> serviceFind = serviceRepository.findServiceFootballFieldByName(request.getName(), request.getFootballFieldId());

        if (serviceFind.isPresent()) throw new AppException(ErrorCode.SERVICE_EXISTED);

        Service service = serviceMapper.toService(request);
        service.setFootballField(footballField);
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
