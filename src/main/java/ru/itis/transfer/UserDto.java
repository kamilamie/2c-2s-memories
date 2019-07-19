package ru.itis.transfer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import ru.itis.models.User;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDto {
    private Long id;
    private String firstName;
    private String lastName;
    private String login;
    private String city;
    private String email;
    private String photo_path;
    private List<User> followers;
    private List<User> followings;

    private static String UPLOADED_FOLDER;

    public static UserDto from(User user) {
        return UserDto.builder()
                .id(user.getId())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .login(user.getLogin())
                .city(user.getCity())
                .email(user.getEmail())
                .photo_path(user.getPhoto_path())
                .followers(user.getFollowers())
                .followings(user.getFollowings())
                .build();
    }
    @Value("${my.files-url}")
    public void setUploadedFolder(String uploadedFolder) {
        UPLOADED_FOLDER = uploadedFolder;
    }
}
