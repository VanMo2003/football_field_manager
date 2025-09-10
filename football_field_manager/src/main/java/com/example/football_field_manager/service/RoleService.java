package com.example.football_field_manager.service;

import com.example.football_field_manager.dto.request.RoleRequest;
import com.example.football_field_manager.dto.response.RoleResponse;
import com.example.football_field_manager.entity.Role;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.RoleMapper;
import com.example.football_field_manager.repository.RoleRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleService {
    RoleRepository roleRepository;
    RoleMapper roleMapper;
    public RoleResponse createRole(RoleRequest request){
        boolean isExisted = roleRepository.existsById(request.getName());

        if (isExisted)
            throw new AppException(ErrorCode.ROLE_EXISTED);

        Role role = roleMapper.toRole(request);
        return roleMapper.toRoleResponse(roleRepository.save(role));
    }
}
