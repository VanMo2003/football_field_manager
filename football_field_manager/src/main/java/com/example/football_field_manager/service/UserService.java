package com.example.football_field_manager.service;

import com.example.football_field_manager.dto.request.UserCreateRequest;
import com.example.football_field_manager.dto.request.UserUpdateInfoRequest;
import com.example.football_field_manager.dto.response.UserResponse;
import com.example.football_field_manager.entity.Role;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.RoleMapper;
import com.example.football_field_manager.mapper.UserMapper;
import com.example.football_field_manager.repository.RoleRepository;
import com.example.football_field_manager.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService {
    PasswordEncoder passwordEncoder;
    UserRepository userRepository;
    UserMapper userMapper;
    RoleRepository roleRepository;
    RoleMapper roleMapper;

    @PreAuthorize("hasRole('ADMIN')")
    public List<UserResponse> getAllUsers(){
        List<UserResponse> users = userRepository.findAll().stream().map(user -> {
            UserResponse userResponse = userMapper.toUserResponse(user);
            userResponse.setRole(roleMapper.toRoleResponse(user.getRole()));
            return userResponse;
        }).toList();

        return  users;
    }

    @PostAuthorize("returnObject.username == authentication.name")
    public UserResponse getUserById(String userId){
        User user = userRepository.findById(userId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        UserResponse userResponse = userMapper.toUserResponse(user);
        userResponse.setRole(roleMapper.toRoleResponse(user.getRole()));

        return  userResponse;
    }

    public UserResponse createUser(UserCreateRequest request){
        boolean checkExist = userRepository.existsByUsername(request.getUsername());

        if (checkExist){
            throw new AppException(ErrorCode.USER_EXISTED);
        }else{
            User user = userMapper.toUser(request);
            user.setPassword(passwordEncoder.encode(request.getPassword()));

            Role role = roleRepository.findById(request.getRole()).orElseThrow(() -> new AppException(ErrorCode.ROLE_NOT_EXIST));
            user.setRole(role);

            user.setGender(request.getGender().getGender());
            user.setHometown(request.getHometown().getHometown());

            userRepository.save(user);
            UserResponse userResponse = userMapper.toUserResponse(user);
            userResponse.setRole(roleMapper.toRoleResponse(role));
            return userResponse;
        }
    }

    @PostAuthorize("returnObject.username == authentication.name")
    public UserResponse updateInfoUserById(String userId, UserUpdateInfoRequest request){
        User user = userRepository.findById(userId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        userMapper.updateInfoUser(user, request);

        UserResponse userResponse = userMapper.toUserResponse(userRepository.save(user));
        user.setGender(request.getGender().getGender());
        user.setHometown(request.getHometown().getHometown());

        return userResponse;
    }
}
