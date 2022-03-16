package kz.serik.service;


import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static kz.serik.factory.ServiceConst.*;

public class LogOut implements Service {
    private final Logger LOGGER = LogManager.getLogger(this.getClass().getName());
    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute(CURRENT_USER);
        try {
            request.logout();
        } catch (ServletException e) {
            LOGGER.error(e);
        }
        return INDEX;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return INDEX;
    }
}
