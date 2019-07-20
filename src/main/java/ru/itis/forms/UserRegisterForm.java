package ru.itis.forms;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;
import ru.itis.validators.file.File;
import ru.itis.validators.login.Login;
import ru.itis.validators.password.Password;
import ru.itis.validators.email.UniqueEmail;

import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

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
