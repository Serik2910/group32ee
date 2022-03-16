
<%@ page import="kz.serik.model.Films" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css">
<%--    <script type="text/javascript" src="/tinymce/jquery-3.6.0.min.js"></script>--%>
    <style>
        img{
            max-width: 100%;
        }
    </style>
</head>

<%@include file="navbar.jsp"%>
<body onload="LoadComments('<%=currentUser!=null?currentUser.getEmail():null%>')">
    <div class="container mb-5">
        <div class="row mt-2">
            <div class="col-10 mx-auto">
                <%
                    Films film = (Films)request.getAttribute("film");
                    if(film != null){
                %>
                <div class="card mt-3">
                    <div class="card-header">
                        <%--                        <%= f.getGenre()%>--%>
                        <c:out value="${film.genre.name}, ${film.country.name}" />
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">${film.name}</h5>
                        <p class="card-text">${film.description}</p>
<%--                        <a href="/details?id=${film.id}" class="btn btn-primary btn-sm">Details</a>--%>
                    </div>
                    <div class="card-footer text-muted">
                        Duration: ${film.duration} min, posted by: ${film.user.fullName}
                        <div>
                            <%
                                if(currentUser!=null){
                            %>
                            <a href="JavaScript:void(0)" style="text-decoration:none;" onclick="toLike(${film.id})">
                                &#x2764;
                            </a>
                            <script type = "text/javascript">
                                async function toLike(filmId){
                                    // alert(filmId);
                                    const param = new URLSearchParams();
                                    param.append('film_id', filmId);
                                    const res = await fetch("/secured/add_like",{
                                        method: 'POST',
                                        body: param
                                    });
                                    document.getElementById("likeAmount").innerHTML=await res.json();
                                }
                            </script>
                            <%
                                }
                            %>
                            <span id = "likeAmount">
                                ${film.like_amount}
                            </span>
                            likes
                        </div>
                    </div>

                </div>
                <div class="mt-3">
                    <%
                        if(currentUser!=null && currentUser.getEmail().equals(film.getUser().getEmail())){
                    %>
                    <a href="/restricted/edit_film?id=<%=film.getId()%>" class="btn btn-primary btn-sm">Edit film</a>
                    <a href="/restricted/delete_film?id=<%=film.getId()%>" class="btn btn-danger btn-sm">Delete film</a>
                    <%
                        }
                    %>
                </div>
                <div class="mt-3">
                    <%
                        if(currentUser!=null){
                    %>
                    <textarea  id="commentArea" class="form-control"></textarea>
                    <button class="btn btn-success btn-sm mt-3" onclick="toAddComment(<%=film.getId()%>,'<%=currentUser.getEmail()%>')">Add Comment</button>
                    <div id="buttonsArea"></div>
                    <script type="text/javascript">
                        async function toAddComment(filmId, user_email){
                            var commentArea = document.getElementById("commentArea");
                            const params = new URLSearchParams();
                            params.append('id', filmId);
                            params.append('comment', commentArea.value);
                            const res = await fetch("/secured/add_comments",{
                                method:'POST',
                                body: params
                            });
                            commentArea.value = "";
                            LoadComments(user_email);
                        }
                    </script>
                    <script type="text/javascript">
                        async function toEditComment(commId, user_email){
                            var commentArea = document.getElementById("commentArea");
                            var buttonsArea = document.getElementById("buttonsArea");
                            const params = new URLSearchParams();
                            params.append('id', commId);
                            params.append('comment', commentArea.value);
                            const res = await fetch("/secured/edit_comments",{
                                method:'POST',
                                body: params
                            });
                            commentArea.value = "";
                            buttonsArea.innerHTML = "";
                            LoadComments(user_email);
                            // alert("Ok");
                        }
                    </script>
                    <script type="text/javascript">
                        async function toDeleteComment(commId, user_email){
                            console.log(commId+","+ user_email);
                            var commentArea = document.getElementById("commentArea");
                            var buttonsArea = document.getElementById("buttonsArea");
                            const params = new URLSearchParams();
                            params.append('id', commId);
                            const res = await fetch("/secured/delete_comments",{
                                method:'POST',
                                body: params
                            });
                            commentArea.value = "";
                            buttonsArea.innerHTML = ""
                            LoadComments(user_email);
                            // alert("Ok");
                        }
                    </script>
                    <script type="text/javascript">
                        async function toCreateElements(commId, comment, user_email) {
                            let commentArea = document.getElementById("commentArea");
                            commentArea.value=comment;

                            let buttonsArea = document.getElementById("buttonsArea");
                            let htmlCode = "";
                            htmlCode += "<button class=\"btn btn-success btn-sm mt-3\" onclick=\"toEditComment("+commId+",'"+user_email+"')\">Edit Comment</button>";
                            htmlCode += "<button class=\"btn btn-danger btn-sm mt-3\" onclick=\"toDeleteComment("+commId+",'"+user_email+"')\">Delete Comment</button>";
                            buttonsArea.innerHTML=htmlCode;
                        }
                    </script>
                    <%
                    }else{
                    %>
                    <p>
                        Please, <a href="/secured/login" style="text-decoration: none; font-weight: bold">sign in</a> to leave comment
                    </p>
                    <%
                        }
                    %>
                </div>
                <div class="mt-3" id="comment">

                </div>
                <script type="text/javascript">
                    async function LoadComments(user_email) {
                        const res = await fetch("/load_comments?id=" +${film.id});
                        const comms = await res.json();
                        let htmlCode = "";
                        for (i = 0; i < comms.length; i++) {
                            htmlCode += "<div class=\"list-group\">";
                            if(comms[i].user.email === user_email) {
                                htmlCode += "<a href=\"Javascript:toCreateElements("+comms[i].id+",'"+comms[i].comment+"','"+user_email+"')\" class=\"list-group-item list-group-item-action \">";
                            }
                            else{
                                htmlCode += "<a href=\"Javascript:void(0)\" class=\"list-group-item list-group-item-action \">";
                            }
                            htmlCode += "<div class=\"d-flex w-100 justify-content-between\">";
                            htmlCode += "<h5 class=\"mb-1\">" + comms[i].user.fullName + "</h5>";
                            htmlCode += "<small>" + comms[i].postDate + "</small>";
                            htmlCode += "</div>";
                            htmlCode += "<p class=\"mb-1\">" + comms[i].comment + "</p>";
                            htmlCode += "</a></div>";
                        }
                        document.getElementById("comment").innerHTML = htmlCode;
                    }
                </script>


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
<script src="/bs/js/bootstrap.bundle.min.js"></script>
</body>
</html>
