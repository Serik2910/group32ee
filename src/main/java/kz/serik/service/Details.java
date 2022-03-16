package kz.serik.service;


import kz.serik.DB.DBManager;
import kz.serik.model.Comment;
import kz.serik.model.Films;
import static kz.serik.factory.ServiceConst.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;


public class Details implements Service {
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response)  {
        String page = INDEX_JSP;
        Long id = 0L;
        try {
            id = Long.parseLong(request.getParameter("id"));

        } catch (Exception e) {
            e.printStackTrace();
        }
        Films film = DBManager.getFilm(id);
        if (film != null) {
            ArrayList<Comment> comments = DBManager.getComments(film.getId());
            request.setAttribute("comments", comments);
            request.setAttribute("film", film);
            page = DETAILS_JSP;
        }
        return page;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return INDEX_JSP;
    }
}
