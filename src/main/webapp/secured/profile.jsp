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
<%@include file="../navbar.jsp"%>
    <div class="container">
    <c:if test="${CURRENT_USER != null}">
        <div class="row mt-5">
            <div class="col-6 mx-auto">
                <h3>${CURRENT_USER.fullName}</h3>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-6 mx-auto">
                <c:if test="${param.update_success != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        Profile updated
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${param.update_error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        Profile update error
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <form action="/secured/profile" method="post">
                    <div class="mt-3">
                        <label for="email">
                            EMAIL:
                        </label>
                        <input type="text" class="form-control mt-3 bg-light" id="email" readonly value="${CURRENT_USER.email}">
                    </div>
                    <div class="mt-3">
                        <label for="full_name">
                            FULL NAME:
                        </label>
                        <input type="text" class="form-control mt-3 " name="fullName" id="full_name"  value="${CURRENT_USER.fullName}">
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-success">
                            UPDATE PROFILE
                        </button>

                    </div>
                </form>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-6 mx-auto">
                <c:if test="${param.password_success != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        Password updated
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${param.password_error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        Password update error
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <form action="/secured/password_update" method="post">
                    <div class="mt-3">
                        <label for="old_password">
                            OLD PASSWORD:
                        </label>
                        <input type="password" class="form-control mt-3" id="old_password" name="old_password">
                    </div>
                    <div class="mt-3">
                        <label for="new_password">
                            NEW PASSWORD:
                        </label>
                        <input type="password" class="form-control mt-3" id="new_password" name="new_password">
                    </div>
                    <div class="mt-3">
                        <label for="re_new_password">
                            RETYPE PASSWORD:
                        </label>
                        <input type="password" class="form-control mt-3" name="re_new_password" id="re_new_password">
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-success">
                            UPDATE PASSWORD
                        </button>

                    </div>
                </form>
            </div>
        </div>
    </c:if>
    </div>

</body>
</html>
