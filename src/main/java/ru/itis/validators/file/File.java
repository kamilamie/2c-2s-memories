package ru.itis.validators.file;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = FileValidator.class)
public @interface File {
    String message() default "{File.default.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
