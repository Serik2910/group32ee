package kz.serik.service;

import com.google.gson.Gson;

import kz.serik.DB.DBManager;
import kz.serik.model.*;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import static kz.serik.factory.ServiceConst.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;


public class LoadComments implements Service{
    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response)  {
        String result = "[]";
        long id = 0L;
        try {
            id = Long.parseLong(request.getParameter("id"));

        } catch (Exception e) {
            LOGGER.error(e);
        }
        Films film = DBManager.getFilm(id);
        if (film != null) {
            ArrayList<Comment> comments = DBManager.getComments(film.getId());
            Gson gson = new Gson();
            result = gson.toJson(comments);
        }
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.print(result);
        } catch (IOException e) {
            LOGGER.error(e);
        }
        return "";
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
