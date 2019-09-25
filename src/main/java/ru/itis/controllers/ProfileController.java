package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import ru.itis.forms.NewPostForm;
import ru.itis.models.User;
import ru.itis.services.PostService;
import ru.itis.services.UserService;

import javax.validation.Valid;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import static ru.itis.transfer.UserDto.from;

@Controller
public class ProfileController {
    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

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
                model.addAttribute("currentUserId", current_user.getId());
                model.addAttribute("currUserFollowings", current_user.getFollowings());
            }
        }
        return "user-profile";
    }
    @PostMapping("/profile")
    public String addNewPost(@Valid NewPostForm form, BindingResult bindingResult, Authentication authentication, ModelMap model){
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalArgumentException::new);
        model.addAttribute("user", from(currentUser));
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = bindingResult.getFieldErrors().stream()
                    .collect( Collectors.toMap(FieldError::getField,
                            FieldError::getDefaultMessage, (e1, e2) -> e1));
            model.addAttribute("errors", errors);
            System.out.println(errors.size());
            return "profile";
        }
        postService.addPost(form, currentUser);
        return "redirect:/profile";
    }
}
