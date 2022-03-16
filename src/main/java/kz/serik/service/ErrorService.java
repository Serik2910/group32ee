package kz.serik.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static kz.serik.factory.ServiceConst.ERROR_JSP;

public class ErrorService implements Service{

    @Override
    public String doGet(HttpServletRequest request, HttpServletResponse response) {
        return ERROR_JSP;
    }

    @Override
    public String doPost(HttpServletRequest request, HttpServletResponse response) {
        return ERROR_JSP;
    }
}
