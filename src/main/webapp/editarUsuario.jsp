<%@ page import="mx.edu.utez.model.Usuario.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Editar Usuarios</title>
</head>
<body>
<div class="container mt-5">
    <h2>Editar Usuario</h2>
    <form action="${pageContext.request.contextPath}/editar-usuario" method="post">
        <% Usuario usuario = (Usuario) request.getAttribute("usuario"); %>
        <input type="hidden" name="id" value="<%= usuario.getId() %>">

        <div class="mb-3">
            <label>Nombre:</label>
            <input type="text" name="nombre" class="form-control" value="<%= usuario.getNombre() %>" required>
        </div>

        <div class="mb-3">
            <label>Apellido Paterno:</label>
            <input type="text" name="aPaterno" class="form-control" value="<%= usuario.getaPaterno() %>" required>
        </div>

        <div class="mb-3">
            <label>Apellido Materno:</label>
            <input type="text" name="aMaterno" class="form-control" value="<%= usuario.getaMaterno() %>" required>
        </div>

        <div class="mb-3">
            <label>Correo:</label>
            <input type="email" name="correo" class="form-control" value="<%= usuario.getCorreo() %>" required>
        </div>

        <div class="mb-3">
            <label>Telefono:</label>
            <input type="text" name="telefono" class="form-control" value="<%= usuario.getTelefono() %>" required maxlength="10">
        </div>

        <div class="mb-3">
            <label>Edad:</label>
            <input type="number" name="edad" class="form-control" value="<%= usuario.getEdad() %>" required min="1" max="100">
        </div>

        <button type="submit" class="btn btn-primary">Actualizar</button>
    </form>
</div>
</body>
</html>
