package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.itis.forms.UserRegisterForm;
import ru.itis.models.User;
import ru.itis.repositories.UserRepository;
import ru.itis.security.details.UserDetailsImpl;
import ru.itis.utils.FileDownloader;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private FileDownloader fileDownloader;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Value("${util.files-url}")
    private String default_photo;

    @Override
    public Optional<User> getUserByLogin(String login) {
        return userRepository.findOneByLogin(login);
    }

    @Override
    public Optional<User> getUserById(Long id) {
        return userRepository.findOneById(id);
    }

    @Override
    public void signUp(UserRegisterForm form) {
        String hashPassword = passwordEncoder.encode(form.getPassword());
        User user = User.builder()
                .firstName(form.getFirstName())
                .login(form.getLogin())
                .hashPassword(hashPassword)
                .email(form.getEmail())
                .build();
        if (!form.getFile().isEmpty()) {
            user.setPhoto_path(fileDownloader.upload(form.getFile(), form.getLogin()).orElseThrow(IllegalArgumentException::new));
        } else {
            user.setPhoto_path(default_photo);
        }
        userRepository.save(user);
    }

    @Override
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

    public boolean emailIsUnique(String email) {
        return !userRepository.findOneByEmail(email).isPresent();
    }
}