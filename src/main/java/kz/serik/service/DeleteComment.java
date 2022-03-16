package kz.serik.service;

import kz.serik.DB.DBManager;
import kz.serik.model.Comment;
import kz.serik.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import static kz.serik.factory.ServiceConst.*;

public class DeleteComment implements Service {
    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding(UTF8);
        } catch (UnsupportedEncodingException e) {
            LOGGER.error(e);
        }
        User user = (User) request.getSession().getAttribute(CURRENT_USER);
        if (user != null) {
            Long id = 0L;
            try {
                id = Long.parseLong(request.getParameter("id"));

            } catch (Exception e) {
                LOGGER.error(e);
            }
            Comment comment = DBManager.getComment(id);
            if (comment != null) {
                DBManager.deleteComment(id);
            }
        }
        return "";
    }

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
