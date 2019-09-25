package ru.itis.controllers;

import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import ru.itis.forms.NewPostForm;
import ru.itis.forms.UserRegisterForm;
import ru.itis.models.Comment;
import ru.itis.models.Post;
import ru.itis.models.User;
import ru.itis.models.UserVk;
import ru.itis.services.CommentService;
import ru.itis.services.LikeService;
import ru.itis.services.PostService;
import ru.itis.services.UserService;
import ru.itis.transfer.CommentDto;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.SQLOutput;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
public class AjaxController {
    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private LikeService likeService;

    @Autowired
    private CommentService commentService;

    @PostMapping("/ajax/follow")
    public ResponseEntity<Object> follow(@RequestParam("login") String login, Authentication authentication) {
        User subscriptor = userService.getUserByLogin(login).orElseThrow(IllegalArgumentException::new);
        User currentUser = userService.getCurrentUser(authentication).orElse(null);
        boolean followed = userService.toggleSubscription(subscriptor, currentUser);
        return ResponseEntity.ok(followed);
    }

    @PostMapping("/ajax/deletePhoto")
    public ResponseEntity<Object> deletePhoto(Authentication authentication) {
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalArgumentException::new);
        String photo_path = userService.deletePhoto(currentUser);
        return ResponseEntity.ok(photo_path);
    }

    @PostMapping("/ajax/togglePrivate")
    public ResponseEntity<Object> togglePrivate(Authentication authentication) {
        User currentUser = userService.getCurrentUser(authentication).orElseThrow(IllegalArgumentException::new);
        userService.togglePrivate(currentUser);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ajax/like")
    public ResponseEntity<Object> likePost(@RequestParam("postId") Long postId, Authentication authentication) {
        User currentUser = userService.getCurrentUser(authentication).orElse(null);
        boolean isLiked = false;
        Post post = postService.getPostById(postId).orElseThrow(IllegalArgumentException::new);
        isLiked = likeService.toggle(post, currentUser);
        return ResponseEntity.ok(isLiked);
    }

    @PostMapping("/ajax/deletePost")
    public ResponseEntity<Object> deletePost(@RequestParam("id") Long id) {
        Post post = postService.getPostById(id).orElseThrow(IllegalArgumentException::new);
        postService.deletePost(post);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ajax/deleteComment")
    public ResponseEntity<Object> deleteComment(@RequestParam("commentId") Long commentId) {
        Comment comment = commentService.getCommentById(commentId).orElseThrow(IllegalArgumentException::new);
        commentService.deleteComment(comment);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ajax/addComment")
    public ResponseEntity<Object> addComment(@RequestParam("postId") Long postId, @RequestParam("text") String commentText, Authentication authentication) {
        User author = userService.getCurrentUser(authentication).orElse(null);
        Post post = postService.getPostById(postId).orElseThrow(IllegalArgumentException::new);
        Comment comment = Comment.builder()
                .author(author)
                .post(post)
                .date(new Date())
                .text(commentText)
                .build();
        commentService.addComment(comment);
        return ResponseEntity.ok(CommentDto.from(comment));
    }

    @PostMapping("/ajax/signUp_vk")
    public ResponseEntity<Object> signUpVk(@Valid @RequestBody UserVk user, HttpServletRequest request) throws IOException {
        if (userService.loginIsUnique(user.getScreen_name())) {
            UserRegisterForm userRegisterForm = UserRegisterForm.builder()
                    .firstName(user.getFirst_name())
                    .login(user.getScreen_name())
                    .email("vk.com/" + user.getScreen_name())
                    .password(user.getId())
                    .build();
            userService.signUp(userRegisterForm);
            try {
                request.login(userRegisterForm.getLogin(), userRegisterForm.getPassword());
            } catch (ServletException e) {
                System.out.println("login error");
            }
            return ResponseEntity.ok(userRegisterForm);
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/ajax/login_vk")
    public ResponseEntity<Object> loginVk(@Valid @RequestBody UserVk user, HttpServletRequest request) throws IOException {
        if (userService.getUserByLogin(user.getScreen_name()).isPresent()) {
            try {
                request.login(user.getScreen_name(), user.getId());
            } catch (ServletException e) {
                System.out.println("login error");
            }
            return ResponseEntity.ok(user);
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
}
