package com.example.football_field_manager.service;

import com.example.football_field_manager.dto.request.UserCreateRequest;
import com.example.football_field_manager.dto.request.UserUpdateInfoRequest;
import com.example.football_field_manager.dto.response.UserResponse;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.UserMapper;
import com.example.football_field_manager.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Date;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService {
    private static final Logger log = LoggerFactory.getLogger(UserService.class);
    UserRepository userRepository;
    UserMapper userMapper;

    public UserResponse getUserById(String userId){
        User user = userRepository.findById(userId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        UserResponse userResponse = userMapper.toUserResponse(user);

        return  userResponse;
    }

    public UserResponse createUser(UserCreateRequest request){
        boolean checkExist = userRepository.existsByUsername(request.getUsername());

        if (checkExist){
            throw new AppException(ErrorCode.USER_EXISTED);
        }else{
            User user = userMapper.toUser(request);

            userRepository.save(user);
            UserResponse userResponse = userMapper.toUserResponse(user);

            log.info("==> [1000][POST] /user {}", new Date());
            return userResponse;
        }
    }

    public UserResponse updateInfoUserById(String userId, UserUpdateInfoRequest request){
        User user = userRepository.findById(userId).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        userMapper.updateInfoUser(user, request);

        log.info("==> [1000][PUT] /user/{userId} {}", new Date());
        UserResponse userResponse = userMapper.toUserResponse(userRepository.save(user));

        return userResponse;
    }
}
