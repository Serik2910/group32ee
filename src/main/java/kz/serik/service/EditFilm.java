package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.model.Country;
import kz.serik.model.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import static kz.serik.factory.ServiceConst.*;


public class EditFilm implements Service{
    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response){
        String page = INDEX;
        try {
            request.setCharacterEncoding(UTF8);
        } catch (UnsupportedEncodingException e) {
            LOGGER.error(e);
        }
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if (user != null) {
            Long id = 0L;
            try {
                id = Long.parseLong(request.getParameter("id"));

            } catch (Exception e) {
                LOGGER.error(e);
            }
            Films film = DBManager.getFilm(id);
            if (user.getEmail().equals(film.getUser().getEmail())) {
                request.setAttribute("film", film);
                page = EDIT_FILM_JSP;
            }
        }

        return page;
    }
    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response){
        String page = INDEX;
        try {
            request.setCharacterEncoding(UTF8);
        } catch (UnsupportedEncodingException e) {
            LOGGER.error(e);
        }
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if (user != null) {
            Integer country_id = Integer.parseInt(request.getParameter("country"));
            Integer genre_id = Integer.parseInt(request.getParameter("genre"));
            String name = request.getParameter("name");
            Integer duration = Integer.parseInt(request.getParameter("duration"));
            Country country = DBManager.getCountries().stream().filter(x -> x.getId() == country_id).findFirst().orElse(null);
            String description = request.getParameter("description");
            Genre genre = DBManager.getGenres().stream().filter(x -> x.getId() == genre_id).findFirst().orElse(null);
            Long id = 0L;
            try {
                id = Long.parseLong(request.getParameter("id"));

            } catch (Exception e) {
                e.printStackTrace();
            }
            Films film = DBManager.getFilm(id);
            if (film != null && user.getEmail().equals(film.getUser().getEmail())) {
                film.setName(name);
                film.setDuration(duration);
                film.setCountry(country);
                film.setDescription(description);
                film.setGenre(genre);
                if (DBManager.saveFilm(film)) {
                    page = DETAILS+"?id=" + id;
                } else {
                    page = EDIT_FILM+"?error_db";
                }
            }
        }
        return page;
    }

}
