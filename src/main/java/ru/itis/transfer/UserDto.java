package ru.itis.transfer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import ru.itis.models.Post;
import ru.itis.models.User;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDto {
    private String firstName;
    private String lastName;
    private String login;
    private String city;
    private String email;
    private String photo_path;
    private List<User> followers;
    private List<User> followings;
    private Boolean isPrivate;
    private List<Post> posts;

    private static String UPLOADED_FOLDER;

    public static UserDto from(User user) {
        return UserDto.builder()
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .login(user.getLogin())
                .city(user.getCity())
                .email(user.getEmail())
                .photo_path(user.getPhoto_path())
                .followers(user.getFollowers())
                .followings(user.getFollowings())
                .isPrivate(user.getIsPrivate())
                .posts(user.getPosts())
                .build();
    }
    @Value("${my.files-url}")
    public void setUploadedFolder(String uploadedFolder) {
        UPLOADED_FOLDER = uploadedFolder;
    }
}
