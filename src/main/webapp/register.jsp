<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
                <c:if test="${param.passworderror != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <fmt:message key="Message.NotSamePassword"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                </c:if>
                <c:if test="${param.emailerror != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <fmt:message key="Message.EmailExists"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                </c:if>
                <c:if test="${param.success != null}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <fmt:message key="Message.AccRegistered"/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                </c:if>
                <form action="/register" method="post">
                    <div class="mt-3">
                        <label for="email">EMAIL: </label>
                        <input type="email" class="form-control mt-3" name="email" id="email" required placeholder="User e-mail">
                    </div>
                    <div class="mt-3">
                        <label for="password"><fmt:message key="Label.Password"/>: </label>
                        <input type="password" class="form-control mt-3" name="password" id="password" required placeholder="User password">
                    </div>
                    <div class="mt-3">
                        <label for="re_password"><fmt:message key="TableHeader.Country"/>: </label>
                        <input type="password" class="form-control mt-3" name="re_password" id="re_password" required placeholder="Repeat user password">
                    </div>
                    <div class="mt-3">
                        <label for="full_name"><fmt:message key="TableHeader.FullName"/>: </label>
                        <input type="text" class="form-control mt-3" name="fullName" id="full_name" required placeholder="User full name">
                    </div>
                    <div class="mt-3">
                        <label for="role"><fmt:message key="TableHeader.Role"/>: </label>
                        <c:choose>
                            <c:when test="${CURRENT_USER.role == 'administrator' }">
                                <select name="role" class="form-control mt-3" id="role" required>
                                    <c:forEach var="role" items="${roles}">
                                        <option value="${role}">${role}</option>
                                    </c:forEach>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" id="role" name="role" value="client">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-dark"><fmt:message key="Button.Register"/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
