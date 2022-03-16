package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.model.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import static kz.serik.factory.ServiceConst.*;

public class DeleteUser implements Service {
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response){
        ArrayList<User> userArrayList;
        String email = "";
        try {
            email = request.getParameter("email");
        }catch (Exception e){
            e.printStackTrace();
        }
        User user = DBManager.getUser(email);
        if (user!=null) {
            DBManager.deleteUser(user);
        }
        userArrayList=DBManager.getUsers();
        request.setAttribute("users", userArrayList);
        return USERS_JSP;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return INDEX_JSP;
    }
}
