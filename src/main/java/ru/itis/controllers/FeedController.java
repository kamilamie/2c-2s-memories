package ru.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import ru.itis.models.Post;
import ru.itis.models.User;
import ru.itis.security.details.UserDetailsImpl;
import ru.itis.services.PostService;
import ru.itis.services.UserService;
import ru.itis.transfer.UserDto;

import java.util.List;

import static ru.itis.transfer.UserDto.from;

@Controller
public class FeedController {

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @GetMapping("/feed")
    public String getFeedPage(Authentication authentication, ModelMap map) {
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalAccessError::new);
        List<Post> posts = postService.getUsersFeed(currentUser);
        map.addAttribute("feedPosts", posts);
        map.addAttribute("currentUserId", currentUser.getId());
        return "feed";
    }
}
