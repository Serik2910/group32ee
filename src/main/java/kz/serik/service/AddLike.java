package kz.serik.service;


import kz.serik.DB.DBManager;
import kz.serik.model.Films;
import kz.serik.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import static kz.serik.factory.ServiceConst.*;

public class AddLike implements Service {
    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response)  {

        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        int likes = 0;
        if (user != null) {
            Long id = 0L;
            try {
                id = Long.parseLong(request.getParameter("film_id"));
            } catch (Exception e) {
                e.printStackTrace();
            }
            Films film = DBManager.getFilm(id);
            if (film != null) {
                likes = DBManager.toLikeFilm(film, user);
            }
            PrintWriter writer;
            try {
                writer = response.getWriter();
                writer.print(likes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        return INDEX_JSP;
    }
}
