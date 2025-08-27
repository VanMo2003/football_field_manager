package com.example.football_field_manager.service;

import com.example.football_field_manager.controller.UserController;
import com.example.football_field_manager.dto.request.UserRequest;
import com.example.football_field_manager.dto.response.UserResponse;
import com.example.football_field_manager.entity.User;
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
        User user = userRepository.findById(userId).orElseThrow(() -> {throw new RuntimeException("Không tìm thấy người dùng");});

        UserResponse userResponse = userMapper.toUserResponse(user);

        return  userResponse;
    }

    public UserResponse createUser(UserRequest request){
        boolean checkExist = userRepository.existsByUsername(request.getUsername());

        if (checkExist){
            log.error("==> [409][POST] /user {}", new Date());
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Username đã tồn tại");
        }else{
            User user = userMapper.toUser(request);

            userRepository.save(user);
            UserResponse userResponse = userMapper.toUserResponse(user);

            log.info("==> [1000][POST] /user {}", new Date());
            return userResponse;
        }
    }
}
