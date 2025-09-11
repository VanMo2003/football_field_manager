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
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class UserService {
    UserRepository userRepository;
    UserMapper userMapper;
    RoleRepository roleRepository;
    RoleMapper roleMapper;

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
            Role role = roleRepository.findById(request.getRole()).orElseThrow(() -> new AppException(ErrorCode.ROLE_NOT_EXIST));

            user.setRole(role);

            userRepository.save(user);
            UserResponse userResponse = userMapper.toUserResponse(user);
            userResponse.setRole(roleMapper.toRoleResponse(role));

            log.info("==> [1000][POST] /user");
            return userResponse;
        }
    }

    public UserResponse updateInfoUserById(String userId, UserUpdateInfoRequest request){
        User user = userRepository.findById(userId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        userMapper.updateInfoUser(user, request);

        log.info("==> [1000][PUT] /user/{userId}");
        UserResponse userResponse = userMapper.toUserResponse(userRepository.save(user));
        userResponse.setRole(roleMapper.toRoleResponse(user.getRole()));

        return userResponse;
    }
}
