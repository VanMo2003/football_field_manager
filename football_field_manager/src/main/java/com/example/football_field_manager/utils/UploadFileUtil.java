package com.example.football_field_manager.utils;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@Component
public class UploadFileUtil {

    @Value("${uploads.images}")
    String UPLOAD_DIR;

    public String uploadFile(MultipartFile image){
        if (image == null || image.isEmpty()) {
            throw new IllegalArgumentException("File upload cannot be empty");
        }
        try {
            Files.createDirectories(Paths.get(UPLOAD_DIR));

            String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
            String path = UPLOAD_DIR.endsWith(File.separator)
                    ? UPLOAD_DIR
                    : UPLOAD_DIR + File.separator;
            File file = new File(path + fileName);

            image.transferTo(file);
            return fileName;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
