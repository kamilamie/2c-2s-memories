package ru.itis.validators.password;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.itis.security.details.UserDetailsImpl;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class OldPasswordValidator implements ConstraintValidator<OldPassword, String> {
   @Autowired
   private PasswordEncoder passwordEncoder;
   public void initialize(OldPassword constraint) {
   }

   public boolean isValid(String oldPassword, ConstraintValidatorContext context) {
      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      return auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken) &&
              (passwordEncoder.matches(oldPassword, ((UserDetailsImpl) auth.getPrincipal()).getUser().getHashPassword()));
   }
}
