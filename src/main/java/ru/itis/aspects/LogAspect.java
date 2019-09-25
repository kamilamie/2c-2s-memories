package ru.itis.aspects;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;


import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;


@Aspect
@Configuration
public class LogAspect {

    private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);


    @After("execution (* *..UserService.getUserByLogin(..))")
    public void logLoadUserByName(JoinPoint joinPoint) {
        logger.info("\nLOG.INFO: got user successfully: " + Arrays.toString(joinPoint.getArgs()));
    }

    @After("execution (* *..UserService.signUp(..))")
    public void logRegisterUser(JoinPoint joinPoint) {
        logger.info("\nLOG.INFO: registered successfully: " + Arrays.toString(joinPoint.getArgs()));
    }

    @Before("execution (* *..PostService.addPost(..))")
    public void logAddPostStart(JoinPoint joinPoint) {
        logger.info("\nLOG.INFO: try to add post: " + Arrays.toString(joinPoint.getArgs()));
    }
    @After("execution (* *..PostService.addPost(..))")
    public void logAddPostEnd(JoinPoint joinPoint) {
        logger.info("\nLOG.INFO: new post added  successfully: " + Arrays.toString(joinPoint.getArgs()));
    }

    @After("execution (* *..PostService.deletePost(..))")
    public void logDeletePost(JoinPoint joinPoint) {
        logger.info("\nLOG.INFO: post deleted successfully: " + Arrays.toString(joinPoint.getArgs()));
    }

    @After("execution (* *..UserService.changePassword(..))")
    public void logChangePassword(JoinPoint joinPoint) {
        logger.info("LOG.INFO: password changed successfully: " + Arrays.toString(joinPoint.getArgs()));
    }
}