package ru.itis.forms;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;
import ru.itis.models.Post;
import ru.itis.models.User;
import ru.itis.validators.File;
import ru.itis.validators.Login;
import ru.itis.validators.Password;
import ru.itis.validators.UniqueEmail;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.util.List;

@Data
@NoArgsConstructor
public class UserRegisterForm {


    @Size(min=2, max=20, message = "input size should be between 2 and 20")
    private String firstName;

    @Login
    private String login;

    @Password
    private String password;

    @Email(message = "email has incorrect format")
    @UniqueEmail
    private String email;

    @File
    private MultipartFile file;
}
