package ru.itis.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.itis.forms.UserRegisterForm;

import javax.persistence.*;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "my_user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String firstName;
    private String lastName;

    private String login;
    private String hashPassword;
    @Column(columnDefinition = "boolean default false")
    private Boolean isPrivate;

    private String city;
    private String email;
    private String photo_path;

    @OneToMany(mappedBy = "author")
    @OrderBy("date DESC")
    private List<Post> posts;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name="subscriptions",
            joinColumns = @JoinColumn(name="subscriptor_id"),
            inverseJoinColumns = @JoinColumn(name="subscriber_id")
    )
    private List<User> followers;

    @ManyToMany(mappedBy = "followers")
    private List<User> followings;

    public String toString(){
        return "login: "+login;
    }

}
