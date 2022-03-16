package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import static kz.serik.factory.ServiceConst.*;
import static kz.serik.factory.ServiceMethods.bytesToHex;

public class Login implements Service {
    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response){
        String page = LOGIN_JSP;

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance(MD5);
        } catch (NoSuchAlgorithmException e) {
            LOGGER.error(e);
        }
        md.update(password.getBytes());
        byte[] digest = md.digest();
        String myHash = bytesToHex(digest).toUpperCase();
        User checkUser = DBManager.getUser(email);
        try {
            if (checkUser != null && myHash.equals(checkUser.getPassword())) {
                request.getSession().setAttribute(CURRENT_USER, checkUser);
                page = INDEX;
            } else {
                page = LOGIN_JSP+"?error";
            }
        }catch (Exception e){
            LOGGER.error(e);
            page = ERROR_SERVICE;
            request.setAttribute("errorMessage",
                    "Exception occurred : " + e.getMessage());
        }
        return page;
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
