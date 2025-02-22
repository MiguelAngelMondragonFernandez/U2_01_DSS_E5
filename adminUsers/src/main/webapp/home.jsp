<%--
  Created by IntelliJ IDEA.
  User: mickV
  Date: 21/02/2025
  Time: 11:01 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Hello Unhappy</h1>
<script>
    window.onload = ()=>{
        comprobarSesion();
    }
    async function comprobarSesion(){
        const session = await fetch('getPermisos', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(response => response.json()).then((data)=>{
            data === "fail" ? window.location.href = "403.jsp" : null;
        });
    };
</script>
</body>
</html>
