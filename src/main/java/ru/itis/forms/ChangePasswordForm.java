package ru.itis.forms;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.itis.validators.password.OldPassword;
import ru.itis.validators.password.Password;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChangePasswordForm {

    @OldPassword
    private String oldPassword;
    @Password
    private String newPassword;
}
