package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.itis.forms.ChangePasswordForm;
import ru.itis.forms.UserEditForm;
import ru.itis.forms.UserRegisterForm;
import ru.itis.models.User;
import ru.itis.repositories.UserRepository;
import ru.itis.security.details.UserDetailsImpl;
import ru.itis.utils.FileDownloader;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private FileDownloader fileDownloader;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Value("${util.files-url}")
    private String default_photo;

    public Optional<User> getUserByLogin(String login) {
        return userRepository.findOneByLogin(login);
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findOneById(id);
    }

    public void signUp(UserRegisterForm form) {
        String hashPassword = passwordEncoder.encode(form.getPassword());
        User user = User.builder()
                .firstName(form.getFirstName())
                .login(form.getLogin())
                .hashPassword(hashPassword)
                .email(form.getEmail())
                .isPrivate(false)
                .build();
        if (form.getFile()!=null &&!form.getFile().isEmpty()) {
            user.setPhoto_path(fileDownloader.upload(form.getFile(), form.getLogin()).orElseThrow(IllegalArgumentException::new));
        } else {
            user.setPhoto_path(default_photo);
        }
        userRepository.save(user);
    }

    public Optional<User> getCurrentUser(Authentication authentication) {
        if (authentication != null) {
            Long currentUserId = ((UserDetailsImpl) authentication.getPrincipal()).getUser().getId();
            return getUserById(currentUserId);
        }
        return Optional.empty();
    }

    public boolean loginIsUnique(String login) {
        return !userRepository.findOneByLogin(login).isPresent();
    }

    public boolean toggleSubscription(User subscriptor, User subscriber) {
        if (isNotSubscribed(subscriptor, subscriber)) {
            subscriptor.getFollowers().add(subscriber);
            userRepository.save(subscriptor);
            return true;
        } else {
            subscriptor.getFollowers().remove(findById(subscriptor.getFollowers(), subscriber.getId()));
            userRepository.save(subscriptor);
            return false;
        }
    }

    private boolean isNotSubscribed(User subscriptor, User subscriber) {
        for (User follower : subscriptor.getFollowers()) {
            if (follower.getId().equals(subscriber.getId())) {
                return false;
            }
        }
        return true;
    }

    private User findById(List<User> users, Long id) {
        for (User user : users) {
            if (user.getId().equals(id)) {
                return user;
            }
        }
        return null;
    }

    public boolean emailIsUnique(String email) {
        return !userRepository.findOneByEmail(email).isPresent();
    }

    public void editProfile(UserEditForm form, User currentUser) {
        if (!form.getFirstName().equals(""))
            currentUser.setFirstName(form.getFirstName());
        else
            currentUser.setFirstName(null);

        if (!form.getLastName().equals(""))
            currentUser.setLastName(form.getLastName());
        else
            currentUser.setLastName(null);

        if (!form.getLogin().equals(""))
            currentUser.setLogin(form.getLogin());
        else
            currentUser.setLogin(null);

        if (!form.getEmail().equals(""))
            currentUser.setEmail(form.getEmail());
        else
            currentUser.setEmail(null);
        if (!form.getCity().equals(""))
            currentUser.setCity(form.getCity());
        else
            currentUser.setCity(null);

        if (!form.getFile().isEmpty()) {
            String path = fileDownloader.upload(form.getFile(), currentUser.getLogin()).orElseThrow(IllegalArgumentException::new);
            currentUser.setPhoto_path(path);
        }

        userRepository.save(currentUser);

    }

    public String deletePhoto(User user) {
        user.setPhoto_path(default_photo);
        userRepository.save(user);
        return default_photo;

    }

    public void togglePrivate(User currentUser) {
        currentUser.setIsPrivate(!currentUser.getIsPrivate());
        userRepository.save(currentUser);
    }

    public void changePassword(ChangePasswordForm form, User currentUser) {
        currentUser.setHashPassword(passwordEncoder.encode(form.getNewPassword()));
        userRepository.save(currentUser);
    }
}
