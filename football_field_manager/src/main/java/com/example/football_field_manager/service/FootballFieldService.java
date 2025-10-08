package com.example.football_field_manager.service;

import com.example.football_field_manager.dto.request.FootballFieldRequest;
import com.example.football_field_manager.dto.request.UpdateFootballFieldRequest;
import com.example.football_field_manager.dto.response.FootballFieldResponse;
import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.mapper.FootballFieldMapper;
import com.example.football_field_manager.mapper.UserMapper;
import com.example.football_field_manager.repository.FootballFieldRepository;
import com.example.football_field_manager.repository.UserRepository;
import com.example.football_field_manager.utils.UploadFileUtil;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class FootballFieldService {
    FootballFieldRepository footballFieldRepository;
    FootballFieldMapper footballFieldMapper;
    UserRepository userRepository;
    UploadFileUtil uploadFileUtil;

    @PreAuthorize("hasAnyRole('ADMIN','USER')")
    public List<FootballFieldResponse> getAllFootballField(){
        List<FootballField> footballFields = footballFieldRepository.findAll();

        return footballFields.stream().map(footballFieldMapper::toFootballFieldResponse).toList();
    }

    @PreAuthorize("hasRole('MANEGE')")
    public FootballFieldResponse createFootballField(FootballFieldRequest request, MultipartFile image){
        Optional<FootballField> footballFieldFind = footballFieldRepository.findByName(request.getName());

        if (footballFieldFind.isPresent()) throw new AppException(ErrorCode.FOOTBALL_FIELD_EXISTED);

        FootballField footballField = footballFieldMapper.toFootballField(request);

        User user = userRepository.findById(request.getUserId()).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXIST));

        if (footballFieldRepository.findByUser(user).isPresent()) throw new AppException(ErrorCode.USER_OF_FOOTBALL_FIELD_EXISTED);

        footballField.setUser(user);

        String imageUrl = uploadFileUtil.uploadFile(image);
        footballField.setDefaultImageUrl(imageUrl);

        FootballFieldResponse footballFieldResponse = footballFieldMapper.toFootballFieldResponse(footballField);

        footballFieldRepository.save(footballField);

        return footballFieldResponse;
    }

    @PreAuthorize("@FootballFieldSecurity.isOwner(#id, authentication.name)")
    public FootballFieldResponse updateFootballField(Long id, UpdateFootballFieldRequest request){
        FootballField footballField = footballFieldRepository.findById(id).orElseThrow(() -> new AppException(ErrorCode.FOOTBALL_FIELD_NOT_EXIST));

        footballFieldMapper.updateFootballField(footballField, request);

        FootballFieldResponse footballFieldResponse = footballFieldMapper.toFootballFieldResponse(footballField);

        footballFieldRepository.save(footballField);

        return footballFieldResponse;
    }

    @PreAuthorize("hasRole('ADMIN')")
    public void deleteFootballFieldById(Long id){
        footballFieldRepository.deleteById(id);
    }
}
