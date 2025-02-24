<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.Objects" %>
<%
    HttpSession sessionUsuario = request.getSession();
    String sessionData = (String) sessionUsuario.getAttribute("session");

    if (Objects.isNull(sessionData) || !sessionData.split("/")[2].equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/withoutSession");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Usuario</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/styles.css">
    <script>
        async function registrarUsuario(event) {
            event.preventDefault();
            const form = document.getElementById("formUsuario");
            const formData = new FormData(form);

            const usuario = {
                nombre: formData.get("nombre"),
                aPaterno: formData.get("aPaterno"),
                aMaterno: formData.get("aMaterno"),
                correo: formData.get("correo"),
                telefono: formData.get("telefono"),
                edad: parseInt(formData.get("edad"), 10)
            };

            const response = await fetch("<%= request.getContextPath() %>/agregar-usuario", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(usuario)
            });

            const resultado = await response.json();
            alert(resultado);
            if (resultado === "Usuario registrado con éxito") {
                window.location.href = "<%= request.getContextPath() %>/getUsuarios";
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Agregar Nuevo Usuario</h2>
    <form id="formUsuario" onsubmit="registrarUsuario(event)">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>

        <label for="aPaterno">Apellido Paterno:</label>
        <input type="text" id="aPaterno" name="aPaterno" required>

        <label for="aMaterno">Apellido Materno:</label>
        <input type="text" id="aMaterno" name="aMaterno" required>

        <label for="correo">Correo:</label>
        <input type="email" id="correo" name="correo" required>

        <label for="telefono">Teléfono:</label>
        <input type="text" id="telefono" name="telefono" required>

        <label for="edad">Edad:</label>
        <input type="number" id="edad" name="edad" min="18" required>

        <button type="submit">Registrar Usuario</button>
    </form>
</div>
</body>
</html>
