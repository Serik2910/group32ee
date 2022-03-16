package kz.serik.model;

import java.io.Serializable;

public class Films implements Serializable {
    private Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private String name;
    private int duration;
    private Country country;
    private String description;
    private Genre genre;
    private User user;
    private int like_amount;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getLike_amount() {
        return like_amount;
    }

    public void setLike_amount(int like_amount) {
        this.like_amount = like_amount;
    }

    public Films(Long id, String name, int duration, Country country,
                 String description, Genre genre, User user, int like_amount) {
        this.id = id;
        this.name = name;
        this.duration = duration;
        this.country = country;
        this.description = description;
        this.genre = genre;
        this.user = user;
        this.like_amount = like_amount;
    }
    public Films(){}
    public Films(Long id){
        this.id = id;
    }
    //
//    {
//        this.name = "name";
//        this.duration = 0;
//        this.country = "country";
//        this.description = "description";
//        this.genre = "genre";
//    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Genre getGenre() {
        return genre;
    }

    public void setGenre(Genre genre) {
        this.genre = genre;
    }
}
