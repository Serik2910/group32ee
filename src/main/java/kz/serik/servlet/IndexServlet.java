package kz.serik.servlet;

import kz.serik.factory.ServiceFactory;

import kz.serik.service.Service;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.io.IOException;
import java.util.Locale;

import static kz.serik.factory.ServiceConst.ERROR_SERVICE;
import static kz.serik.factory.ServiceConst.*;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class IndexServlet extends HttpServlet {
    public void init(ServletConfig config) throws
            ServletException {
        super.init(config);
        getServletContext().setAttribute("Lang", new Locale("en", "US"));
    }

    public void destroy() {}

    protected void processRequest(HttpServletRequest
                                          request, HttpServletResponse response)
            throws ServletException, java.io.IOException {
        String page;
        ServiceFactory serviceFactory =
                ServiceFactory.getInstance();
        try {
            Service service= serviceFactory.getService(request.getRequestURI());
            switch (request.getMethod()) {
                case POST:
                    page = service.doPost(request, response);
                    break;
                default:
                    page = service.doGet(request, response);
            }
        }
        catch (Exception e) {
            Logger logger = LogManager.getLogger();
            logger.debug(
                    "IndexServlet:exception : " +
                            e.getMessage());
            request.setAttribute("errorMessage",
                    "Exception occurred : " + e.getMessage());
            page = serviceFactory.getService(ERROR_SERVICE).doGet(request, response);
        }
        if (!page.equals("")) {
            dispatch(request, response, page);
        }
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    public String getServletInfo() {
        return "Front Controller Pattern" +
                " Servlet Front Strategy Example";
    }

    protected void dispatch(HttpServletRequest request,
                            HttpServletResponse response,
                            String page)
            throws  javax.servlet.ServletException,
            java.io.IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }
}
