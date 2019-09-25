package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import ru.itis.forms.ChangePasswordForm;
import ru.itis.forms.UserEditForm;
import ru.itis.models.User;
import ru.itis.services.UserService;

import javax.validation.Valid;
import java.util.Map;
import java.util.stream.Collectors;

import static ru.itis.transfer.UserEditDto.from;

@Controller
public class EditProfileController {
    @Autowired
    private UserService userService;

    @GetMapping("/editProfile")
    public String getEditPage(Authentication authentication, ModelMap model) {
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalAccessError::new);
        model.addAttribute("user", from(currentUser));
        return "edit-profile";
    }

    @PostMapping("/editProfile")
    public String edit(@Valid UserEditForm form, BindingResult bindingResult, Authentication authentication, ModelMap model) {
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalAccessError::new);
        model.addAttribute("user", currentUser);
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = bindingResult.getFieldErrors().stream()
                    .collect( Collectors.toMap(FieldError::getField,
                            FieldError::getDefaultMessage, (e1, e2) -> e1));
            model.addAttribute("errors", errors);
            return "edit-profile";
        }
        userService.editProfile(form, currentUser);
        return "redirect:/profile";

    }

    @PostMapping("/editProfile/password")
    public String changePassword(@Valid ChangePasswordForm form, BindingResult bindingResult, Authentication authentication, ModelMap model){
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalArgumentException::new);
        model.addAttribute("user", currentUser);
        System.out.println(bindingResult.getFieldErrors().toString());
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = bindingResult.getFieldErrors().stream()
                    .collect( Collectors.toMap(FieldError::getField,
                            FieldError::getDefaultMessage, (e1, e2) -> e1));
            System.out.println(errors);
            model.addAttribute("errors", errors);
            return "edit-profile";
        }
        userService.changePassword(form, currentUser);
        return "redirect:/profile";
    }
}

