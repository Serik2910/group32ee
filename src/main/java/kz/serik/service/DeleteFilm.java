package kz.serik.service;


import kz.serik.DB.DBManager;
import kz.serik.model.Films;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static kz.serik.factory.ServiceConst.*;

public class DeleteFilm implements Service {
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response){
        Long id = 0L;
        try {
            id = Long.parseLong(request.getParameter("id"));
        }catch (Exception e){
            e.printStackTrace();
        }
        Films film = DBManager.getFilm(id);
        if (film!=null) {
            DBManager.deleteFilm(id);
        }
        return INDEX;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
