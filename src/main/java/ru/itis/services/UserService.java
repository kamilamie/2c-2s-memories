package ru.itis.services;

import org.springframework.security.core.Authentication;
import ru.itis.forms.ChangePasswordForm;
import ru.itis.forms.UserEditForm;
import ru.itis.forms.UserRegisterForm;
import ru.itis.models.User;

import java.util.List;
import java.util.Optional;


public interface UserService {
    Optional<User> getUserByLogin(String login);
    Optional<User> getUserById(Long id);
    /*
    List<User> searchUsers(String text);*/
    void signUp(UserRegisterForm userRegisterForm);
    Optional<User> getCurrentUser(Authentication authentication);
    boolean loginIsUnique(String login);
    boolean toggleSubscription(User user, User currentUser);
    boolean emailIsUnique(String email);
    void editProfile(UserEditForm form, User user);
    String deletePhoto(User user);

    void changePassword(ChangePasswordForm form, User currentUser);
}
