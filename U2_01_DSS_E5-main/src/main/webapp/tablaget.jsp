<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Lista de Usuarios</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Email</th>
            <th>Edad</th>
            <th>Rol</th>
        </tr>
        </thead>
        <tbody id="usuariosTableBody">
        <!-- Los usuarios se mostrarán aquí -->
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Función para cargar los usuarios desde el backend
    async function cargarUsuarios() {
        try {
            const response = await fetch('/usuarios'); // Llama al endpoint que devuelve los usuarios
            const usuarios = await response.json();

            // Limpiar el cuerpo de la tabla antes de agregar nuevos datos
            const tableBody = document.getElementById('usuariosTableBody');
            tableBody.innerHTML = '';

            // Agregar los usuarios a la tabla
            usuarios.forEach(usuario => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${usuario.id}</td>
                    <td>${usuario.nombre}</td>
                    <td>${usuario.correo}</td>
                    <td>${usuario.edad}</td>
                    <td>${usuario.rol ? usuario.rol : 'Usuario Estándar'}</td> <!-- Aquí se muestra el rol -->
                `;
                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error('Error al cargar los usuarios:', error);
        }
    }

    // Llamamos a la función al cargar la página
    window.onload = cargarUsuarios;
</script>
</body>
</html>
