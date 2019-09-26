package ru.itis.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;
import ru.itis.models.Log;


public interface LogsRepository extends MongoRepository<Log,String>  {
}
