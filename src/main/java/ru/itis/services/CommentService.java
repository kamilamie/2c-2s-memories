package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.itis.models.Comment;
import ru.itis.repositories.CommentRepository;

import java.util.List;
import java.util.Optional;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public void deleteComment(Comment comment) {
        commentRepository.delete(comment);
    }
    public Optional<Comment> getCommentById(Long commentId) {
        return commentRepository.findById(commentId);
    }

    public void addComment(Comment comment) {
        commentRepository.save(comment);
    }
}
