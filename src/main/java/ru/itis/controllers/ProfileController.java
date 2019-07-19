package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import ru.itis.models.User;
import ru.itis.security.details.UserDetailsImpl;
import ru.itis.services.UserService;
import ru.itis.transfer.UserDto;

import java.util.List;
import java.util.Optional;

import static ru.itis.transfer.UserDto.from;

@Controller
public class ProfileController {
    @Autowired
    private UserService userService;

    @GetMapping("/profile")
    public String getProfilePage(Authentication auth, ModelMap map) {
        map.addAttribute("user", from(userService.getCurrentUser(auth).get()));
        return "profile";
    }
    @GetMapping("/profile/{login}")
    public String getUserProfilePage(@PathVariable("login") String login, Authentication authentication, ModelMap model){
        Optional<User> userCandidate = userService.getUserByLogin(login);
        if (userCandidate.isPresent()) {
            User user = userCandidate.get();
            model.addAttribute("user", from(user));
            Optional<User> currentUserOptional = userService.getCurrentUser(authentication);
            if (currentUserOptional.isPresent()) {
                User current_user = currentUserOptional.get();
                if (user.getId().equals(current_user.getId())) return "profile";
                model.addAttribute("current_user", from(current_user));
            }
        }
        return "user-profile";
    }
}
