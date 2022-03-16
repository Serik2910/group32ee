package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.model.Films;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

import static kz.serik.factory.ServiceConst.*;

public class Search implements Service {
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response){

        String par = request.getParameter("my_query");
        ArrayList<Films> films = DBManager.searchFilms(par);
        request.setAttribute("foundFilms", films);
        return SEARCH_JSP;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
