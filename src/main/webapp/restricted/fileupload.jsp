<%@ page import="static kz.serik.factory.ServiceConst.UPLOAD_FILE" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: s.tyulemisov
  Date: 30.12.2021
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload</title>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css">
    <script src="/bs/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@include file="../navbar.jsp"%>
    <div class="container">
        <div class="mt-5">
            <%
                String error = request.getParameter("error");
                if (error!=null){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Exception in uploading file.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                }
            %>
            <%
                List<FileItem> fileItemsList= (List<FileItem>) request.getAttribute("fileList");
                if(fileItemsList!=null && !fileItemsList.isEmpty()){
                    Iterator<FileItem> fileItemsIterator = fileItemsList.iterator();
                    while(fileItemsIterator.hasNext()){
                        FileItem fileItem = fileItemsIterator.next();
                        System.out.println("FieldName="+fileItem.getFieldName());
                        System.out.println("FileName="+fileItem.getName());
                        System.out.println("ContentType="+fileItem.getContentType());
                        System.out.println("Size in bytes="+fileItem.getSize());
                        if(fileItem.getName() != ""){
                            File file = new File(request.getServletContext().getAttribute("FILES_DIR")+File.separator+fileItem.getName());
                            System.out.println("Absolute Path at server="+file.getAbsolutePath());
                            fileItem.write(file);

            %>
            <div class="mt-1">
                <a href="/upload_file?fileName=<%=fileItem.getName()%>">Download <%=fileItem.getName()%></a>
            </div>
            <%
                        }
                        if(fileItem.getName() == ""){
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Выберите файл
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
        <div class="mt-5">
            <p class="text-success">Click on the "Choose File" button to upload a file:</p>
            <form action="/upload_file" method="post" enctype="multipart/form-data">
                <input class="form-control mt-3" type="file" id="myFile" name="filename">
                <input type="submit">
            </form>
        </div>




    </div>

</body>
</html>
