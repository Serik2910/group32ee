package kz.serik.service;
import kz.serik.DB.DBManager;
import kz.serik.factory.ServiceConst;
import kz.serik.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import static kz.serik.factory.ServiceConst.*;
import static kz.serik.factory.ServiceMethods.bytesToHex;


public class Register implements Service {

    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        String page;
        request.setAttribute("roles", DBManager.getRoles());

        page = REGISTER_JSP+"?passworderror";
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String re_password = request.getParameter("re_password");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance(MD5);
        } catch (NoSuchAlgorithmException e) {
            LOGGER.error(e);
        }
        md.update(password.getBytes());
        byte[] digest = md.digest();
        String myHash = bytesToHex(digest).toUpperCase();
        if (password.trim().equals(re_password.trim())) {
            page = REGISTER_JSP+"?emailerror";
            User checkUser = DBManager.getUser(email);
            if (checkUser == null) {
                User user = new User(
                        email,
                        myHash,
                        fullName,
                        role
                );
                if (DBManager.addUser(user)) {
                    page = REGISTER_JSP+"?success";
                }
            }
        }
        return page;
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if(user.getRole().equals(ADMINISTRATOR)){
            request.setAttribute("roles",DBManager.getRoles());
        }
        return REGISTER_JSP;
    }
}
