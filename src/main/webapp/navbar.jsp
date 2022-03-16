<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Optional" %>
<%@ page import="kz.serik.model.User" %>
<%@ page import="kz.serik.DB.DBManager" %>
<%@ page pageEncoding="UTF-8" %>
<%
    String siteName = "KINO.KZ";
    javax.servlet.http.HttpSession httpSession = request.getSession();
    User currentUser = (User) httpSession.getAttribute("CURRENT_USER");
    if ((request.isUserInRole("administrator") || request.isUserInRole("client"))
        && currentUser==null){
        currentUser = DBManager.getUser(request.getUserPrincipal().getName());
        httpSession.setAttribute("CURRENT_USER", currentUser);
    }
%>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="Lang" />
<nav class="navbar navbar-expand-lg navbar-dark bg-dark container">
    <div class="container-fluid">
        <a class="navbar-brand" href="/index">FILMPOISK</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/index">
                        <fmt:message key="Menu.Home"/>
                    </a>
                </li>
                <c:if test="${CURRENT_USER != null}">
                    <c:if test="${CURRENT_USER.role == 'administrator' }">
                        <li class="nav-item">
                            <a class="nav-link" href="/restricted/addfilm"><fmt:message key="Menu.AddFilm"/></a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <fmt:message key="Menu.User"/>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/register"><fmt:message key="Menu.AddUser"/></a></li>
                                <li><a class="dropdown-item" href="/restricted/delete_user"><fmt:message key="Menu.DeleteUser"/></a></li>
                            </ul>
                        </li>
                    </c:if>
                </c:if>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <fmt:message key="Menu.Lang"/>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" onclick="getURL({language:'en'});"><fmt:message key="Menu.LangEng"/></a></li>
                            <li><a class="dropdown-item" onclick="getURL({language:'kz'});"><fmt:message key="Menu.LangKaz"/></a></li>
                            <li><a class="dropdown-item" onclick="getURL({language:'ru'});"><fmt:message key="Menu.LangRus"/></a></li>
                        </ul>
                    </li>
                    <script>
                        function getURL(params) {
                            let url = new URL(window.location.href);
                            Object.keys(params).forEach(key => url.searchParams.get(key)!==null? url.searchParams.set(key, params[key]):url.searchParams.append(key, params[key]));
                            window.location.href=url.href;
                        }
                    </script>
            </ul>
            <%
                Optional<String> query = Optional.ofNullable(request.getParameter("my_query"));
                String queryStr= query.orElse("");
            %>
            "${username}"
            <form class="d-flex my-auto" action="/search" method="get">
                <input class="form-control me-2 " type="search" placeholder="Search" aria-label="Search"
                       name="my_query" value="<%=queryStr%>">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>
            <div class="d-flex align-items-center">
                <!-- Avatar -->
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownAvatar" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img
                                src="https://mdbcdn.b-cdn.net/img/new/avatars/2.webp"
                                class="rounded-circle"
                                height="25"
                                alt="Black and White Portrait of a Man"
                                loading="lazy"
                        />
                        <label for="navbarDropdownAvatar">
                            <c:choose>
                                <c:when test="${CURRENT_USER != null }">
                                    ${CURRENT_USER.fullName}
                                </c:when>
                                <c:otherwise>
                                    user
                                </c:otherwise>
                            </c:choose>
                        </label>
                    </a>

                    <ul
                            class="dropdown-menu dropdown-menu-end"
                            aria-labelledby="navbarDropdown">
                        <li>
                            <c:choose>
                                <c:when test="${CURRENT_USER != null }">
                                    <a class="dropdown-item" aria-current="page" href="/logout"><fmt:message key="Menu.SignOut"/></a>
                                </c:when>
                                <c:otherwise>
                                    <a class="dropdown-item" aria-current="page" href="/secured/login"><fmt:message key="Menu.SignIn"/></a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <c:if test="${CURRENT_USER!= null}">
                            <a class="dropdown-item" aria-current="page" href="/secured/profile"><fmt:message key="Menu.MyProfile"/></a>
                        </c:if>
                        <c:if test="${CURRENT_USER == null}">
                            <a class="dropdown-item" aria-current="page" href="/register"><fmt:message key="Menu.Register"/></a>
                        </c:if>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>
