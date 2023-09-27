package kz.serik.model;

public class Notification {
    private int id;
    private String username;
    private String text;

    public Notification() {
    }

    public Notification(int id, String username, String text) {
        this.id = id;
        this.username = username;
        this.text = text;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
