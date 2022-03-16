<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css">
    <script src="/bs/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@include file="navbar.jsp"%>
    <div class="container">
        <div class="row mt-5">
            <div class="col-6 mx-auto">
                <%
                    String error = request.getParameter("error");

                    if (error!=null){
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    Incorrect email or password, try again
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <%
                    }
                %>
                <form action="/j_security_check" method="post">
                    <div class="mt-3">
                        <label for="email">EMAIL: </label>
                        <input type="email" class="form-control mt-3" name="j_username" id="email" required>
                    </div>
                    <div class="mt-3">
                        <label for="password">PASSWORD: </label>
                        <input type="password" class="form-control mt-3" name="j_password" id="password" required>
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-dark">SIGN IN</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
