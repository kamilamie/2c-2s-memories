package ru.itis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.itis.models.Message;

import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message,Long> {
    @Query("from Message m where m.sender.id = :userId or m.receiver.id = :userId")
    List<Message> findAllByUser(@Param("userId") Long userId);

    @Query("from Message m where m.sender.id = :id1 and m.receiver.id = :id2 or m.sender.id = :id2 and m.receiver.id = :id1 order by m.date")
    List<Message> findAllByUsers(@Param("id1") Long id1, @Param("id2") Long id2);
}
