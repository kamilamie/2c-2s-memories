package ru.itis.transfer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.itis.models.User;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserEditDto {
    private String firstName;
    private String lastName;
    private String login;
    private String email;
    private String city;
    private String photo_path;
    private Boolean isPrivate;

    public static UserEditDto from(User user) {
        return UserEditDto.builder()
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .login(user.getLogin())
                .email(user.getEmail())
                .city(user.getCity())
                .photo_path(user.getPhoto_path())
                .isPrivate(user.getIsPrivate())
                .build();
    }
}
