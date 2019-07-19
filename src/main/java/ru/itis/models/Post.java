package ru.itis.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "post")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author;

    private String photo_path;

    private String description;

    private Date date;

    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL)
    @OrderBy("date")

    private List<Comment> comments;

    private Double coordinateX;
    private Double coordinateY;

    @OneToMany(mappedBy = "post")
    private List<Like> likes;
}
