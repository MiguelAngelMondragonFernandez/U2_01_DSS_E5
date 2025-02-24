<%@ page import="mx.edu.utez.model.Usuario.UsuarioDao" %><%--
  Created by IntelliJ IDEA.
  User: mickV
  Date: 21/02/2025
  Time: 11:01 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js"
            integrity="sha512-a+SUDuwNzXDvz4XrIcXHuCf089/iJAoN4lmrXJg18XnduKK6YlDHNRalv4yd1N40OKI80tFidF+rqTFKGPoWFQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <title>Title</title>
</head>
<body>
<h1>Hello Unhappy</h1>

<%
    UsuarioDao usuarioDao = new UsuarioDao();
%>

<a onclick=<%
    String id = String.valueOf(1);
    try{
        id = usuarioDao.encrypt("HelloUnhappyReoN", "HelloUnhappyReoN", id);
    }catch (Exception e){e.printStackTrace();}
    %> href="editar-usuario?id=<%= id %>">Editar</a>
</body>
</html>
