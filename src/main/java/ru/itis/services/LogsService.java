package ru.itis.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.itis.models.Log;
import ru.itis.repositories.LogsRepository;

import java.util.List;

@Service
public class LogsService {

    @Autowired
    private LogsRepository logsRepository;

    public void save(Log log) {
        logsRepository.save(log);
    }

    public List<Log> findAll() {
        return logsRepository.findAll();
    }
}
