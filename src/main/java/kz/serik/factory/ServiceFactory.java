package kz.serik.factory;

import kz.serik.service.*;

import static kz.serik.factory.ServiceConst.*;

import java.util.HashMap;
import java.util.Map;

public class ServiceFactory {
    private static final Map<String, Service> SERVICE_MAP = new HashMap<>();
    private static final ServiceFactory SERVICE_FACTORY = new ServiceFactory();


    static {
        SERVICE_MAP.put(ADD_FILM,new AddFilm());
        SERVICE_MAP.put(EDIT_FILM,new EditFilm());
        SERVICE_MAP.put(ERROR_SERVICE, new ErrorService());
        SERVICE_MAP.put(PASSWORD_UPDATE, new PasswordUpdate());
        SERVICE_MAP.put(LOGIN, new Login());
        SERVICE_MAP.put(LOGOUT, new LogOut());
        SERVICE_MAP.put(INDEX, new Index());
        SERVICE_MAP.put(ROOT, new Index());
        SERVICE_MAP.put(PROFILE, new Profile());
        SERVICE_MAP.put(REGISTER, new Register());

        SERVICE_MAP.put(SEARCH, new Search());
        SERVICE_MAP.put(DETAILS, new Details());
        SERVICE_MAP.put(LOAD_COMMENTS, new LoadComments());
        SERVICE_MAP.put(DELETE_COMMENTS, new DeleteComment());
        SERVICE_MAP.put(EDIT_COMMENTS, new DeleteComment());
        SERVICE_MAP.put(ADD_LIKE, new AddLike());
        SERVICE_MAP.put(ADD_COMMENTS, new AddComment());
        SERVICE_MAP.put(DELETE_FILM, new DeleteFilm());
        SERVICE_MAP.put(DELETE_USER, new DeleteUser());
    }
    public static ServiceFactory getInstance() {
        return SERVICE_FACTORY;
    }

    public Service getService(String request) {
        Service service = SERVICE_MAP.get(ERROR_SERVICE);

        for (Map.Entry<String, Service> pair : SERVICE_MAP.entrySet()) {
            if (request.equalsIgnoreCase(pair.getKey())) {
                service = SERVICE_MAP.get(pair.getKey());
            }
        }
        return service;
    }
}
