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
                <h1>Error page</h1>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%=request.getAttribute("errorMessage")!=null?(String) request.getAttribute("errorMessage"):request.getParameter("errorMessage")%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
