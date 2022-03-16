package kz.serik.model;

import java.sql.Timestamp;

public class Comment {
    private Long id;
    private Films film;
    private User user;
    private String comment;
    private Timestamp postDate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Films getFilm() {
        return film;
    }

    public void setFilm(Films film) {
        this.film = film;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }

    public Comment() {
    }

    public Comment(Long id, Films film, User user, String comment, Timestamp postDate) {
        this.id = id;
        this.film = film;
        this.user = user;
        this.comment = comment;
        this.postDate = postDate;
    }
}
