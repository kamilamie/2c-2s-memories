package ru.itis.validators.email;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueEmailValidator.class)
public @interface UniqueEmail {
    String message() default "{UniqueEmail.default.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
