package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import ru.itis.models.User;
import ru.itis.services.UserService;

@RestController
public class AjaxController {
    @Autowired
    private UserService userService;

    @PostMapping("/ajax/follow")
    public ResponseEntity<Object> follow(@RequestParam("login") String login, Authentication authentication) {
        User subscriptor = userService.getUserByLogin(login).orElseThrow(IllegalArgumentException::new);
        User currentUser = userService.getCurrentUser(authentication).orElse(null);
        boolean followed = userService.toggleSubscription(subscriptor, currentUser);
        return ResponseEntity.ok(followed);
    }
}
