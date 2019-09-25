package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.itis.models.Like;
import ru.itis.models.Post;
import ru.itis.models.User;
import ru.itis.repositories.LikeRepository;

import java.util.Optional;

@Service
public class LikeService {
    @Autowired
    private LikeRepository likeRepository;

    public boolean toggle(Post post, User currentUser) {
        Optional<Like> like = likeRepository.findOneByPost_IdAndUser_Id(post.getId(), currentUser.getId());
        if (like.isPresent()) {
            likeRepository.delete(like.get());
            return false;
        } else {
            Like newLike = Like.builder()
                    .post(post)
                    .user(currentUser)
                    .build();
            likeRepository.save(newLike);
            return true;
        }
    }
}
