package ru.itis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.itis.models.Post;
import ru.itis.models.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface PostRepository extends JpaRepository<Post, Long> {
    Optional<Post> findById(Long id);

    @Query("select p from User u join u.followings f join f.posts p where u.id = :id order by p.date desc")
    List<Post> findFeedByUser_Id(@Param("id") Long id);
}
