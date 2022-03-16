package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.factory.ServiceFactory;
import kz.serik.model.Films;
import kz.serik.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.UnsupportedEncodingException;

import static kz.serik.factory.ServiceConst.*;

public class AddFilm implements Service {

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        String page = INDEX;
        try {
            request.setCharacterEncoding(UTF8);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        if (user != null) {
            Integer country_id = Integer.parseInt(request.getParameter("country"));
            Integer genre_id = Integer.parseInt(request.getParameter("genre"));
            Films film = new Films(
                null,
                request.getParameter("name"),
                Integer.parseInt(request.getParameter("duration")),
                DBManager.getCountries().stream().filter(x -> x.getId() == country_id).findFirst().orElse(null),
                request.getParameter("description"),
                DBManager.getGenres().stream().filter(x -> x.getId() == genre_id).findFirst().orElse(null),
                user,
                0
            );
            DBManager.addFilm(film);
        }
        return page;
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        String page;
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if (user != null) {
            page = ADD_FILM_JSP;
        } else {
            page = ServiceFactory.getInstance().getService(LOGIN).doGet(request, response);
        }
        return page;
    }
}
