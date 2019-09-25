package ru.itis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.itis.models.Comment;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
}
