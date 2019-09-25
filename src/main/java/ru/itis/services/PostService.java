package ru.itis.services;

import com.drew.lang.GeoLocation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.itis.forms.NewPostForm;
import ru.itis.models.Post;
import ru.itis.models.User;
import ru.itis.repositories.PostRepository;
import ru.itis.utils.FileDownloader;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class PostService {
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private FileDownloader fileDownloader;

    public void addPost(NewPostForm postForm, User currentUser) {
        String photoPath = fileDownloader.upload(postForm.getFile(),
                currentUser.getLogin()
                        + "/posts").orElseThrow(IllegalArgumentException::new);
        Post post = Post.builder()
                .photo_path(photoPath)
                .author(currentUser)
                .description(postForm.getDescription())
                .date(new Date())
                .build();
        postRepository.save(post);
    }

    public Optional<Post> getPostById(Long id) {
        return postRepository.findById(id);
    }

    public void deletePost(Post post) {
        postRepository.delete(post);
    }

    public List<Post> getUsersFeed(User currentUser) {
        return postRepository.findFeedByUser_Id(currentUser.getId());
    }
}
