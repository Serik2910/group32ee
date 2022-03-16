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

public class PasswordUpdate implements Service {
    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        String page = LOGIN_JSP;
        User currentUser = (User) request.getSession().getAttribute(CURRENT_USER);
        if (currentUser != null) {
            String oldPassword = request.getParameter("old_password");
            String newPassword = request.getParameter("new_password");
            String reNewPassword = request.getParameter("re_new_password");
            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance(MD5);
            } catch (NoSuchAlgorithmException e) {
                LOGGER.error(e);
            }
            md.update(oldPassword.getBytes());
            byte[] digest = md.digest();
            String oldHash = bytesToHex(digest).toUpperCase();
            page = PROFILE_JSP+"?old_password_error";
            if (currentUser.getPassword().equals(oldHash)) {
                page = PROFILE_JSP+"?password_not_same_error";
                if (newPassword.equals(reNewPassword)) {
                    md.update(newPassword.getBytes());
                    digest = md.digest();
                    String newHash = bytesToHex(digest).toUpperCase();
                    currentUser.setPassword(newHash);
                    if (DBManager.updatePassword(currentUser)) {
                        page = PROFILE_JSP+"?password_success";
                    }
                }
            }
        }
        return page;
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
