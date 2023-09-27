
<%@ page import="java.lang.reflect.Field" %>

<%@ page import="java.util.ArrayList" %>

<%@ page import="java.util.Locale" %>
<%@ page import="kz.serik.model.Country" %>
<%@ page import="kz.serik.model.Films" %>
<%@ page import="kz.serik.model.Genre" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css">
    <style>
        img{
            max-width: 100%;
        }
    </style>
    <script src="/bs/js/bootstrap.bundle.min.js"></script>
    <script src="../tinymce/jquery-3.6.0.min.js"></script>
    <script src="../tinymce/tinymce.min.js" referrerpolicy="origin"></script>
    <script>
        tinymce.init(
            {
                selector:'textarea ',
                plugins:'preview image link media'
            }
        );
    </script>
</head>
<body>
<%@include file="../navbar.jsp"%>
    <div class="container mb-5">
        <div class="row mt-2">
            <%
                String error = request.getParameter("error_db");
                if (error!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Error on write to database
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                }
            %>
            <div class="col-10 mx-auto">
                <%
                    Films film = (Films)request.getAttribute("film");
                    if(film != null){
                %>
                <form action="/editfilm" method="post">
                    <input type="hidden" id="id" name="id" value="<%=film.getId()%>">
                    <div class="mt-3">
                        <label>
                            <fmt:message key="TableHeader.FilmName"/>:
                        </label>
                        <input type="text" class="form-control mt-3" placeholder="enter name" name="name" required value="<%=film.getName()%>">
                    </div>
                    <div class="mt-3">
                        <label>
                            <fmt:message key="TableHeader.Duration"/>:
                        </label>
                        <select name="duration" class="form-control mt-3" required>
                            <%
                                for (int i =1;i<400;i++){
                            %>
                            <option value="<%=i%>" <%= film.getDuration()==i?"selected":""%>><%=i+" min"%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mt-3">
                        <label>
                            <fmt:message key="TableHeader.Country"/>:
                        </label>
                        <select name="country" class="form-control mt-3" required>
                            <%
                                for (Country country: DBManager.getCountries()){
                            %>
                            <option value="<%=country.getId()%>" <%=country.getId()==film.getCountry().getId()?"selected":""%>><fmt:message key="<%=country.getCode()%>"/></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mt-3">
                        <label class="mb-3">
                            <fmt:message key="TableHeader.Description"/>:
                        </label>
                        <textarea class="form-control mt-3" placeholder="enter description" name="description" required>
                            ${film.description}
                        </textarea>
                    </div>
                    <div class="mt-3">
                        <label>
                            <fmt:message key="TableHeader.Genre"/>:
                        </label>
                        <select name="genre" class="form-control mt-3" required>
                            <%
                                for (Genre genre:DBManager.getGenres()){
                            %>
                            <option value="<%=genre.getId()%>" <%=genre.getId()==film.getGenre().getId()?
                                    "selected":""%>><fmt:message key="<%=genre.getName()%>"/></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mt-3">
                        <%
                            if(currentUser!=null && currentUser.getEmail().equals(film.getUser().getEmail())){
                        %>
                        <button class="btn btn-success"><fmt:message key="Button.SaveFilm"/></button>
                        <%
                            }
                        %>
                    </div>
                </form>

                <%
                    }else {
                %>
                <h1 class="text-center">404 not found</h1>
                <%
                    }
                %>

            </div>
        </div>
    </div>

</body>
</html>
