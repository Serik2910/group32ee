package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.model.Films;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import static kz.serik.factory.ServiceConst.INDEX_JSP;

public class Index implements Service {
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response){
        String page = INDEX_JSP;
        ArrayList<Films> films = DBManager.getFilms();
        request.setAttribute("kinolar", films);
        return page;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return doGet(request, response);
    }
}
