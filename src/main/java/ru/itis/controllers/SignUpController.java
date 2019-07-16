package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import ru.itis.forms.UserForm;
import ru.itis.services.SignUpService;

@Controller
public class SignUpController {
    @Autowired
    private SignUpService signUpService;

    @GetMapping
    public String getSignUpPage() {
        return "signUp";
    }

    @PostMapping("/signUp")
    public String signUp(UserForm userForm) {
        signUpService.signUp(userForm);
        return "redirect:/login";
    }
}
