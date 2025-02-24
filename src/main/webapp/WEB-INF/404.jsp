<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Página no encontrada</title>
    <!-- Agregar Bootstrap para diseño mejorado -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Agregar FontAwesome para íconos -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .error-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .btn-custom {
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 5px;
            transition: all 0.3s;
        }
        .btn-custom:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div class="error-container">
    <h1 class="display-4"><i class="fas fa-exclamation-triangle text-warning"></i> Página no encontrada</h1>
    <p class="lead">Lo sentimos, pero la página que buscas no existe.</p>

    <%
        String userPermisos = (String) session.getAttribute("session");
        if (userPermisos != null) {
            String[] permisos = userPermisos.split("/");
            if (permisos.length > 2 && "admin".equals(permisos[2])) {
    %>
    <a href="inicio" class="btn btn-primary btn-custom"><i class="fas fa-home"></i> Volver a la página principal</a>
    <%
    } else {
    %>
    <a href="<%= request.getContextPath() %>/" class="btn btn-secondary btn-custom"><i class="fas fa-sign-in-alt"></i> Volver al inicio de sesión</a>
    <%
        }
    } else {
    %>
    <a href="<%= request.getContextPath() %>/" class="btn btn-secondary btn-custom"><i class="fas fa-sign-in-alt"></i> Volver al inicio de sesión</a>
    <%
        }
    %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
