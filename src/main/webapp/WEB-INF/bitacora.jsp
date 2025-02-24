<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Usuarios</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Lista de Usuarios</h2>

    <table class="table table-bordered text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>ID Usuario</th>
            <th>Operación</th>
            <th>Estado de la operación</th>
            <th>Fecha cuando se realizó</th>
        </tr>
        </thead>
        <tbody id="usuariosTableBody">
        <!-- Usuarios cargados dinámicamente -->
        </tbody>
    </table>
</div>

<script>
    // Función para obtener y cargar usuarios en la tabla
    async function cargarRegistros() {
        try {
            const response = await fetch('getBitacora', { method: 'GET' });
            const registros = await response.json();

            const tableBody = document.getElementById('usuariosTableBody');
            tableBody.innerHTML = '';

            registros.forEach(registros => {
                const fila = document.createElement('tr');
                fila.innerHTML =
                    '<td>' + registros.id + '</td>' +
                    '<td>' + registros.idUsuario + '</td>' +
                    '<td>' + registros.accion + '</td>' +
                    '<td>' + registros.estado + '</td>' +
                    '<td>' + registros.fecha + '</td>'
                ;
                tableBody.appendChild(fila);
            });

        } catch (error) {
            console.error('Error al cargar los usuarios:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se pudo cargar la lista de usuarios.',
                confirmButtonText: 'OK'
            });
        }
    }

    // Función para eliminar usuario con confirmación

    // Cargar usuarios al cargar la página
    document.addEventListener('DOMContentLoaded', cargarRegistros);
</script>

</body>
</html>
