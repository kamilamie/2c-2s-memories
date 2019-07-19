package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.itis.forms.UserRegisterForm;
import ru.itis.models.User;
import ru.itis.repositories.UserRepository;
import ru.itis.utils.FileDownloader;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private FileDownloader fileDownloader;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

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
        }
        userRepository.save(user);
    }

    public boolean loginIsUnique(String login) {
        return !userRepository.findOneByLogin(login).isPresent();
    }

    public boolean emailIsUnique(String email) {
        return !userRepository.findOneByEmail(email).isPresent();
    }
}
