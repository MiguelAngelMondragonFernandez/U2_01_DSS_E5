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

    <!-- Controles de paginación -->
    <div class="d-flex justify-content-between align-items-center">
        <span id="paginationInfo"></span>
        <nav>
            <ul class="pagination">
                <li class="page-item">
                    <button class="page-link" onclick="cambiarPagina(-1)" id="prevBtn" disabled>Anterior</button>
                </li>
                <li class="page-item">
                    <button class="page-link" onclick="cambiarPagina(1)" id="nextBtn">Siguiente</button>
                </li>
            </ul>
        </nav>
    </div>
</div>

<script>
    let registros = [];
    let paginaActual = 1;
    const registrosPorPagina = 5;

    async function cargarRegistros() {
        try {
            const response = await fetch('getBitacora', { method: 'GET' });
            registros = await response.json();
            paginaActual = 1;
            mostrarPagina();
        } catch (error) {
            console.error('Error al cargar los registros:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se pudo cargar la lista de usuarios.',
                confirmButtonText: 'OK'
            });
        }
    }

    function mostrarPagina() {
        const tableBody = document.getElementById('usuariosTableBody');
        tableBody.innerHTML = '';

        const inicio = (paginaActual - 1) * registrosPorPagina;
        const fin = inicio + registrosPorPagina;
        const registrosPagina = registros.slice(inicio, fin);

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

        actualizarPaginacion();
    }

    function cambiarPagina(direccion) {
        paginaActual += direccion;
        mostrarPagina();
    }

    function actualizarPaginacion() {
        document.getElementById('prevBtn').disabled = paginaActual === 1;
        document.getElementById('nextBtn').disabled = paginaActual * registrosPorPagina >= registros.length;

        document.getElementById('paginationInfo').textContent =
            `Página ${paginaActual} de ${Math.ceil(registros.length / registrosPorPagina)}`;
    }

    document.addEventListener('DOMContentLoaded', cargarRegistros);
</script>

</body>
</html>
