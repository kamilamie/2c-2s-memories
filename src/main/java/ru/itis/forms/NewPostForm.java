package ru.itis.forms;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;
import ru.itis.validators.file.File;
import ru.itis.validators.file.FileNotNull;

import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NewPostForm {

    @FileNotNull
    @File
    private MultipartFile file;

    @Size(min = 0, max = 100, message = "description message size should not exceed 100")
    private String description;

    private Double coordinateX;
    private Double coordinateY;


}
