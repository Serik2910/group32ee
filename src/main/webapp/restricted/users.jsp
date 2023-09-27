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
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th><fmt:message key="TableHeader.Email"/></th>
                            <th><fmt:message key="TableHeader.FullName"/></th>
                            <th><fmt:message key="TableHeader.Role"/></th>

                            <th width="5%">DELETE</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td><c:out value="${user.email}" /></td>
                            <td><c:out value="${user.fullName}" /></td>
                            <td><c:out value="${user.role}" /></td>
                            <td><a href="/restricted/delete_user?email=${user.email}" class="btn btn-primary btn-sm">Delete</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
