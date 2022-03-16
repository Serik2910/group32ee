package kz.serik.DB;

import kz.serik.model.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.*;
import java.util.ArrayList;
import java.util.stream.Collectors;

public final class DBManager {
    private static final Logger LOGGER = LogManager.getLogger(DBManager.class.getName());
    private static ArrayList<Films> films;
    private static ArrayList<Country> countries;
    private static ArrayList<Genre> genres;

    static {
        countries=getCountries();
        genres = getGenres();
        films = getFilms();

    }
    public static ArrayList<Country> getCountries(){
        ArrayList<Country> countries_local = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement("select * from s_country")
        ){
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                countries_local.add(
                        new Country(
                                resultSet.getInt("id"),
                                resultSet.getString("name"),
                                resultSet.getString("code")
                        )
                );
            }
        } catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        countries=countries_local;
        return countries_local;
    }
    public static ArrayList<Genre> getGenres(){
        ArrayList<Genre> genres_local = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement("select * from s_genre")
        ){
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                genres_local.add(
                        new Genre(
                                resultSet.getInt("id"),
                                resultSet.getString("name")
                        )
                );
            }
        } catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        genres=genres_local;
        return genres_local;
    }
    public static ArrayList<String> getRoles(){
        ArrayList<String> roles = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement("select distinct ur.role_name from user_roles ur")
        ){
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()) {
                roles.add(resultSet.getString("role_name"));
            }
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return roles;
    }
    public static ArrayList<Films> getFilms(){
        ArrayList<Films> films_local = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement("select f.*, u.full_name from films f " +
                "inner join users u on f.email=u.email " +
                "order by name")
        ){
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                int country_id= resultSet.getInt("country");
                int genre_id= resultSet.getInt("genre");
                Long id = resultSet.getLong("id");
                String name = resultSet.getString("name");
                int duration = resultSet.getInt("duration");
                String email = resultSet.getString("email");
                String full_name = resultSet.getString("full_name");
                Country country = countries.stream().filter(x-> x.getId()==country_id).findFirst().orElse(null);
                String  desc = resultSet.getString("description");
                Genre genre = genres.stream().filter(x->x.getId()==genre_id).findFirst().orElse(null);
                int like_amount = resultSet.getInt("like_amount");
                films_local.add(
                        new Films(
                                id,
                                name,
                                duration,
                                country,
                                desc,
                                genre,
                                new User(email,  null, full_name,null),
                                like_amount
                        )
                );
            }
        } catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        films=films_local;
        return films_local;
    }
    public static ArrayList<Films> searchFilms(String search){
        //return new ArrayList<>(films.stream().filter((a)->a.getName().toLowerCase().contains(search.toLowerCase())).collect(Collectors.toList()));
        return films.stream().filter((a) -> a.getName().toLowerCase().contains(search.toLowerCase())).collect(Collectors.toCollection(ArrayList::new));
    }
    public static boolean saveFilm(Films film)
    {
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement(
                "update films set " +
                        "name = ?, duration = ?, description = ?, " +
                        "country = ?, genre = ? "+
                        "where id = ?")
        ){
            statement.setString(1,film.getName());
            statement.setInt(2,film.getDuration());
            statement.setString(3,film.getDescription());
            statement.setInt(4,film.getCountry().getId());
            statement.setInt(5,film.getGenre().getId());
            statement.setLong(6,film.getId());
            rows = statement.executeUpdate();
        } catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }
    public static boolean deleteFilm(Long id)
    {
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try(
                PreparedStatement statement = connection.prepareStatement(
                "delete from films where id = ?"
        )) {
            statement.setLong(1,id);
            rows = statement.executeUpdate();

        } catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }
    public static boolean addFilm(Films film){
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement(
                "insert into films( name, duration, country, description, genre, email) " +
                        "values(?,?,?,?,?,?)")
        ){
            statement.setString(1, film.getName());
            statement.setInt(2,film.getDuration());
            statement.setInt(3, film.getCountry().getId());
            statement.setString(4, film.getDescription());
            statement.setInt(5, film.getGenre().getId());
            statement.setString(6, film.getUser().getEmail());
            rows = statement.executeUpdate();
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }
    public static Films getFilm(Long id){
        Films film = null;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement("select f.*, u.full_name from films f " +
                "inner join users u on f.email=u.email " +
                "where f.id=? ")
        ){
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                Integer country_id= resultSet.getInt("country");
                Integer genre_id= resultSet.getInt("genre");
                film =  new Films(
                        resultSet.getLong("id"),
                        resultSet.getString("name"),
                        resultSet.getInt("duration"),
                        countries.stream().filter(x-> x.getId().equals(country_id)).findFirst().orElse(null),
                        resultSet.getString("description"),
                        genres.stream().filter(x->x.getId().equals(genre_id)).findFirst().orElse(null),
                        new User(resultSet.getString("email"), null,  resultSet.getString("full_name"), null),
                        resultSet.getInt("like_amount")
                );
            }
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return film;
    }
    public static User getUser(String email){
        User user = null;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement(
                "select u.*, ur.role_name from users u " +
                        "inner join user_roles ur on ur.email=u.email " +
                        "where ur.email=?")
        ){
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                user = new User(
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("role_name")
                );
            }

        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return user;
    }
    public static ArrayList<User> getUsers(){
        ArrayList<User> users = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "select u.*, ur.role_name from users u " +
                                "inner join user_roles ur on ur.email=u.email ")
        ){

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                users.add( new User(
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("full_name"),
                        resultSet.getString("role_name")
                ));
            }

        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return users;
    }

    public static boolean addUser(User user){
        int rows = 0;
        boolean result=false;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (PreparedStatement statement_user = connection.prepareStatement(
                "INSERT INTO USERS(email,password, full_name)" +
                        "values(?,?,?)");
             PreparedStatement statement_role = connection.prepareStatement(
                     "INSERT INTO user_roles(email,role_name)" +
                             "values(?,?)")
        ){

            statement_user.setString(1, user.getEmail());
            statement_user.setString(2, user.getPassword());
            statement_user.setString(3, user.getFullName());
            rows = statement_user.executeUpdate();
            result = rows>0;
            statement_role.setString(1, user.getEmail());
            statement_role.setString(2, user.getRole());
            rows = statement_role.executeUpdate();
            result = result&&(rows>0);
        }catch (SQLException ex) {
            LOGGER.error(ex);
            ex.printStackTrace();
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }

        return result;
    }
    public static boolean updateUser(User user){
        int rows = 0;
        boolean result=false;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement_user = connection.prepareStatement(
                "UPDATE USERS SET full_name = ? WHERE email = ? ");
                PreparedStatement statement_role = connection.prepareStatement(
                        "UPDATE user_roles SET role_name = ? WHERE email = ? ")
        ){
            statement_user.setString(1, user.getFullName());
            statement_user.setString(2, user.getEmail());
            rows = statement_user.executeUpdate();
            result = rows>0;
            statement_role.setString(1, user.getRole());
            statement_role.setString(2, user.getEmail());
            rows = statement_role.executeUpdate();
            result = result&&(rows>0);
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return result;
    }

    public static boolean deleteUser(User user){
        int rows = 0;
        boolean result=false;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement_user = connection.prepareStatement(
                        "DELETE from users WHERE email = ? ");
                PreparedStatement statement_role = connection.prepareStatement(
                        "delete from user_roles WHERE email = ? ")
        ){
            statement_user.setString(1, user.getEmail());
            rows = statement_user.executeUpdate();
            result = rows>0;
            statement_role.setString(1, user.getEmail());
            rows = statement_role.executeUpdate();
            result = result&&(rows>0);
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return result;
    }
    public static boolean updatePassword(User user){
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement(
                "UPDATE USERS u SET u.password = ? WHERE u.email = ? ")
        ){
            statement.setString(1, user.getPassword());
            statement.setString(2, user.getEmail());
            rows = statement.executeUpdate();
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }
    public static boolean addComment(Comment comment){
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO comments(film_id, email, comment, post_date)" +
                        "values(?,?,?,NOW())")
        ){
            statement.setLong(1, comment.getFilm().getId());
            statement.setString(2, comment.getUser().getEmail());
            statement.setString(3, comment.getComment());
            rows = statement.executeUpdate();
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }

    public static boolean editComment(Comment comment){
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (

                PreparedStatement statement = connection.prepareStatement(
                        "update comments set comment=? " +
                                "where id = ?")
        ){
            statement.setString(1, comment.getComment());
            statement.setLong(2, comment.getId());
            rows = statement.executeUpdate();
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }
    public static boolean deleteComment(Long id){
        int rows = 0;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement(
                        "delete from comments " +
                                "where id = ?")
        ){
            statement.setLong(1, id);
            rows = statement.executeUpdate();
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return rows>0;
    }

    public static ArrayList<Comment> getComments(Long filmId){
        ArrayList<Comment> comments  = new ArrayList<>();
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement("select c.*, u.full_name from comments c " +
                    "inner join users u on c.email=u.email " +
                    "where c.film_id= ? "+
                    "order by c.post_date desc")
        ){
            statement.setLong(1, filmId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                comments.add(new Comment(
                        resultSet.getLong("id"),
                        new Films(filmId),
                        new User(
                                resultSet.getString("email"),
                                null,
                                resultSet.getString("full_name"),
                                null
                        ),
                        resultSet.getString("comment"),
                        resultSet.getTimestamp("post_date")
                ));
            }
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return comments;
    }
    public static Comment getComment(Long commentId){
        Comment comment  = null;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement("select c.*, u.full_name from comments c " +
                        "inner join users u on c.email=u.email " +
                        "where c.id= ? "
                )
        ){
            statement.setLong(1, commentId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                comment=new Comment(
                        resultSet.getLong("id"),
                        new Films(resultSet.getLong("film_id")),
                        new User(
                                resultSet.getString("email"),
                                null,
                                resultSet.getString("full_name"),
                                null
                        ),
                        resultSet.getString("comment"),
                        resultSet.getTimestamp("post_date")
                );
            }
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return comment;
    }


    public static int toLikeFilm(Films film, User user){
        int likes = 0;
        boolean isLiked = false;
        Connection connection = ConnectionPool.getInstance().takeConnection();
        try (
                PreparedStatement statement = connection.prepareStatement(
                "select * from likes where film_id = ? and email = ?")
        ){
            statement.setLong(1,film.getId());
            statement.setString(2, user.getEmail());
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                isLiked = true;
            }
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }
        if(isLiked) {
            try (
                    PreparedStatement statement = connection.prepareStatement(
                    "delete from likes where film_id = ? and email = ?")
            ){
                statement.setLong(1, film.getId());
                statement.setString(2, user.getEmail());
                statement.executeUpdate();
            } catch (SQLException ex) {
                LOGGER.error(ex);
            }
        }else{
            try (
                    PreparedStatement statement = connection.prepareStatement(
                    "insert into likes (film_id, email) values(?, ?) ")
            ){
                statement.setLong(1, film.getId());
                statement.setString(2, user.getEmail());
                statement.executeUpdate();
            } catch (SQLException ex) {
                LOGGER.error(ex);
            }
        }
        try(
                PreparedStatement statement = connection.prepareStatement(
                "select count(*) like_count from likes where film_id=?")){
            statement.setLong(1,film.getId());
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                likes = resultSet.getInt("like_count");
            }
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }
        try(
                PreparedStatement statement = connection.prepareStatement(
                "update films set like_amount=? where id=?")
        ){
            statement.setInt(1, likes);
            statement.setLong(2, film.getId());
            statement.executeUpdate();
        }catch (SQLException ex) {
            LOGGER.error(ex);
        }finally {
            ConnectionPool.getInstance().returnConnection(connection);
        }
        return likes;
    }
}
