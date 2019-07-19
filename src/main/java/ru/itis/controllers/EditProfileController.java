package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import ru.itis.models.User;
import ru.itis.services.UserService;

import static ru.itis.transfer.UserEditDto.from;

@Controller
public class EditProfileController {
    @Autowired
    private UserService userService;

    @GetMapping("/editProfile")
    public String getEditPage(Authentication authentication, ModelMap model){
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalAccessError::new);
        model.addAttribute("user", from(currentUser));
        return "edit-profile";
    }
}
