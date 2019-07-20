package ru.itis.validators.password;

import ru.itis.validators.email.UniqueEmailValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = OldPasswordValidator.class)
public @interface OldPassword {
    String message() default "{OldPassword.default.message}";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
