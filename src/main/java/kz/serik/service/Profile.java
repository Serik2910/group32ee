package kz.serik.service;


import kz.serik.DB.DBManager;
import kz.serik.factory.ServiceFactory;
import kz.serik.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static kz.serik.factory.ServiceConst.*;

public class Profile implements Service {
    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response){
        String page = INDEX_JSP;
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if (user != null) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            user.setFullName(fullName);
            user.setEmail(email);
            page = PROFILE_JSP;
            request.setAttribute("update", "error");
            if (DBManager.updateUser(user)) {
                request.setAttribute("update", "success");
            }
        }
        return page;
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        String page = PROFILE_JSP;
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if (user == null) {
            page = LOGIN;
        }
        return page;
    }
}
