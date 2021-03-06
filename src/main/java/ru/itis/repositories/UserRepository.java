package ru.itis.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.itis.models.User;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findOneByLogin(String login);
    Optional<User> findOneByEmail(String email);
    Optional<User> findOneById(Long id);
}
