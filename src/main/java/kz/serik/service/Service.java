package kz.serik.service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public interface Service {
    String doGet(HttpServletRequest request, HttpServletResponse response);
    String doPost(HttpServletRequest request, HttpServletResponse response);
}
