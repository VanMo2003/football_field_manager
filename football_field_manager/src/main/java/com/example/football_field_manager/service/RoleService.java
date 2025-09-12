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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RoleService {
    RoleRepository roleRepository;
    RoleMapper roleMapper;
    @PreAuthorize("hasRole('ADMIN')")
    public List<RoleResponse> getAllRole() {
        return roleRepository.findAll().stream().map(roleMapper::toRoleResponse).toList();
    }

    @PreAuthorize("hasRole('ADMIN')")
    public RoleResponse createRole(RoleRequest request){
        boolean isExisted = roleRepository.existsById(request.getName());

        if (isExisted)
            throw new AppException(ErrorCode.ROLE_EXISTED);

        Role role = roleMapper.toRole(request);
        return roleMapper.toRoleResponse(roleRepository.save(role));
    }

    @PreAuthorize("hasRole('ADMIN')")
    public RoleResponse updateRole(RoleRequest request){
        Role role = roleRepository.findById(request.getName()).orElseThrow(() -> new AppException(ErrorCode.ROLE_NOT_EXIST));

        roleMapper.updateRole(role, request);

        return roleMapper.toRoleResponse(roleRepository.save(role));
    }

    public void deleteRole(String name) {
        roleRepository.deleteById(name);
    }

}
