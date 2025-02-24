<%--
  Created by IntelliJ IDEA.
  User: mickV
  Date: 24/02/2025
  Time: 10:30 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Usuario</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Bootstrap JS y SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div class="container">
    <h2>Agregar Nuevo Usuario</h2>
    <form id="formUsuario">
        <label for="nombre">Nombre:</label>
        <input type="text" class="form-control" id="nombre" name="nombre" required>

        <label for="aPaterno">Apellido Paterno:</label>
        <input type="text" class="form-control" id="aPaterno" name="aPaterno" required>

        <label for="aMaterno">Apellido Materno:</label>
        <input type="text" class="form-control" id="aMaterno" name="aMaterno" required>

        <label for="correo">Correo:</label>
        <input type="email" class="form-control" id="correo" name="correo" required>

        <label for="aPaterno">Contraseña:</label>
        <input type="text" class="form-control" id="contrasena" name="contrasena" required>

        <label for="telefono">Teléfono:</label>
        <input type="text" class="form-control" id="telefono" name="telefono" required>

        <label for="edad">Edad:</label>
        <input type="number" class="form-control" id="edad" name="edad" min="18" required>

        <button type="submit" class="btn btn-dark mt-3">Registrar Usuario</button>
    </form>

    <script>
        document.getElementById("formUsuario").addEventListener("submit", async function registrarUsuario(event) {
            event.preventDefault();
            const formData = new FormData(event.target);
            Swal.fire(
                {
                    title: "Registrando usuario",
                    html: "Por favor espere",
                    showConfirmButton: false,
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                        Swal.showLoading();
                }
                }
            )

            const usuario = {
                nombre: formData.get("nombre"),
                aPaterno: formData.get("aPaterno"),
                aMaterno: formData.get("aMaterno"),
                correo: formData.get("correo"),
                telefono: formData.get("telefono"),
                contrasena: formData.get("contrasena"),
                edad: parseInt(formData.get("edad"), 10)
            };
            console.log(usuario);
            const response = await fetch("anadir-usuario", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(usuario)
            });

            const resultado = await response.json();
            if(resultado === 'success'){
                Swal.fire({
                    title: 'Usuario registrado',
                    text: 'El usuario se ha registrado correctamente',
                    icon: 'success',
                    confirmButtonText: 'Aceptar'
                }).then(() => {
                    window.location.href = 'inicio';
                });
            } else {
                Swal.fire({
                    title: 'Error',
                    text: 'Ha ocurrido un error al registrar el usuario',
                    icon: 'error',
                    confirmButtonText: 'Aceptar'
                });
            }
        });

    </script>
</div>
</body>
</html>