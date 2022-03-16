<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kz.serik.model.Country" %>
<%@ page import="kz.serik.DB.DBManager" %>
<%@ page import="kz.serik.model.Genre" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css">
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
    <div class="container">
        <div class="row mt-5">
            <div class="col-10 mx-auto">
                <form action="/restricted/addfilm" method="post">
                    <div class="mt-3">
                        <label>
                            NAME:
                        </label>
                        <input type="text" class="form-control mt-3" placeholder="enter name" name="name" required>
                    </div>
                    <div class="mt-3">
                        <label>
                            DURATION:
                        </label>
                        <select name="duration" class="form-control mt-3" required>
                            <%
                                for (int i =1;i<400;i++){
                            %>
                            <option value="<%=i%>"><%=i+" min"%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mt-3">
                        <label>
                            COUNTRY:
                        </label>
                        <select name="country" class="form-control mt-3" required>
                            <%
                                for (Country country: DBManager.getCountries()){
                            %>
                            <option value="<%=country.getId()%>"><%=country.getName_rus()%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mt-3">
                        <label>
                            DESCRIPTION:
                        </label>
                        <textarea class="form-control mt-3" placeholder="enter description" name="description" required>
                        </textarea>
                    </div>
                    <div class="mt-3">
                        <label>
                            GENRE:
                        </label>
                        <select name="genre" class="form-control" required>
                            <%
                                for (Genre genre:DBManager.getGenres()){
                            %>
                            <option value="<%=genre.getId()%>"><%=genre.getName_rus()%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-success">Add film</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
