package ru.itis.forms;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;
import ru.itis.validators.email.UniqueEmail;
import ru.itis.validators.file.File;
import ru.itis.validators.login.Login;

import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

@Data
@NoArgsConstructor
public class UserEditForm {

    @Size(min=2, max=20, message = "input size should be between 2 and 20")
    private String firstName;

    @Size(min=2, max=30, message = "input size should be between 2 and 20")
    private String lastName;

    @Login
    private String login;

    @Email(message = "email has incorrect format")
    @UniqueEmail
    private String email;

    private String city;

    @File
    private MultipartFile file;


}
