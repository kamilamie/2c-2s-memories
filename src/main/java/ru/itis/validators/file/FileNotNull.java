package ru.itis.validators.file;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = FileNotNullValidator.class)
public @interface FileNotNull {
    String message() default "{NotNull.default.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
