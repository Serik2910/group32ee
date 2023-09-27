<%@ page import="java.util.ArrayList" %>
<%@ page import="kz.serik.model.Films" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css">
    <script src="/bs/js/bootstrap.bundle.min.js"></script>
    <script src="tinymce/tinymce.min.js" referrerpolicy="origin"></script>
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
<%@include file="navbar.jsp"%>
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th><fmt:message key="TableHeader.Id"/></th>
                            <th><fmt:message key="TableHeader.FilmName"/></th>
                            <th><fmt:message key="TableHeader.Duration"/></th>
                            <th><fmt:message key="TableHeader.Country"/></th>
                            <th><fmt:message key="TableHeader.Description"/></th>
                            <th><fmt:message key="TableHeader.Genre"/></th>
                            <th><fmt:message key="TableHeader.User"/></th>
                            <th><fmt:message key="TableHeader.Like"/></th>
                            <th width="5%"><fmt:message key="TableHeader.Details"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Films> films = (ArrayList<Films>) request.getAttribute("kinolar");
                            if(films!=null){
                                for (Films f: films){
                        %>
                        <tr>
                            <td><%= f.getId()%></td>
                            <td><%= f.getName()%></td>
                            <td><%= f.getDuration()%></td>
                            <td><fmt:message key="<%=f.getCountry().getCode()%>"/></td>
                            <td><%= f.getDescription()%></td>
                            <td><fmt:message key="<%=f.getGenre().getName()%>"/></td>
                            <td><%= f.getUser().getFullName()%></td>
                            <td><%= f.getLike_amount()%></td>
                            <td><a href="/details?id=<%=f.getId()%>" class="btn btn-primary btn-sm"><fmt:message key="TableHeader.Details"/></a></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
