<%@ page import="mx.edu.utez.model.Usuario.UsuarioDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuarios</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Bootstrap JS y SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Lista de Usuarios</h2>

    <table class="table table-bordered text-center">
        <thead class="table-dark">
        <tr>
            <th>Nombre</th>
            <th>Apellido Paterno</th>
            <th>Apellido Materno</th>
            <th>Correo</th>
            <th>Teléfono</th>
            <th>Edad</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody id="usuariosTableBody">
        <!-- Aquí se insertarán los usuarios dinámicamente -->
        </tbody>
    </table>
</div>

<script>
    document.addEventListener('DOMContentLoaded', async () => {
        try {
            const response = await fetch('getUsuarios', {
                method: 'GET',
                headers: { 'Content-Type': 'application/json' }
            });

            const usuarios = await response.json();
            console.log(usuarios);

            const tableBody = document.getElementById('usuariosTableBody');
            tableBody.innerHTML = '';

            usuarios.forEach(usuario => {
                const fila = document.createElement('tr');
                fila.innerHTML = `
                    <td>${usuario.nombre}</td>
                    <td>${usuario.aPaterno}</td>
                    <td>${usuario.aMaterno}</td>
                    <td>${usuario.correo}</td>
                    <td>${usuario.telefono}</td>
                    <td>${usuario.edad}</td>
                    <td>
                        <a href="editarUsuario.jsp?id=${usuario.id}" class="btn btn-primary btn-sm">Editar</a>
                        <button class="btn btn-danger btn-sm" onclick="eliminarUsuario(${usuario.id})">Eliminar</button>
                    </td>
                `;
                tableBody.appendChild(fila);
            });
        } catch (error) {
            console.error('Error al cargar los usuarios:', error);
        }
    });

    function eliminarUsuario(id) {
        Swal.fire({
            title: "¿Estás seguro?",
            text: "Esta acción no se puede deshacer.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Sí, eliminar"
        }).then((result) => {
            if (result.isConfirmed) {
                fetch(`eliminarUsuario?id=${id}`, { method: "DELETE" })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            Swal.fire("Eliminado", "El usuario ha sido eliminado.", "success");
                            location.reload();
                        } else {
                            Swal.fire("Error", "No se pudo eliminar el usuario.", "error");
                        }
                    })
                    .catch(error => console.error('Error al eliminar usuario:', error));
            }
        });
    }
</script>
</body>
</html>
