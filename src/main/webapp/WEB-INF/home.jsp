<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<<html lang="es">
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
    <button class="btn btn-dark mb-3" onclick="anadirUsuario()"> Añadir usuario</button>
    <button class="btn btn-secondary mb-3" onclick="verBitacora()"> Ver Bitacora</button>
    <button onclick="logOut()" class="btn btn-danger mb-3">Cerrar sesión</button>
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
        <!-- Usuarios cargados dinámicamente -->
        </tbody>
    </table>
</div>

<script>
    // Función para obtener y cargar usuarios en la tabla
    function anadirUsuario() {
        window.location.href = 'agregar-usuario';
    }
    function verBitacora() {
        window.location.href = 'bitacora';
    }
    async function cargarUsuarios() {
        try {
            const response = await fetch('getUsuarios', { method: 'GET' });
            const usuarios = await response.json();
            console.log(usuarios);

            const tableBody = document.getElementById('usuariosTableBody');
            tableBody.innerHTML = '';

            usuarios.forEach(usuario => {
                const fila = document.createElement('tr');
                fila.innerHTML =
                    '<td>' + usuario.nombre + '</td>' +
                    '<td>' + usuario.aPaterno + '</td>' +
                    '<td>' + usuario.aMaterno + '</td>' +
                    '<td>' + usuario.correo + '</td>' +
                    '<td>' + usuario.telefono + '</td>' +
                    '<td>' + usuario.edad + '</td>' +
                    ' <td><a href="editar-usuario?id=' + usuario.id + '" class="btn btn-dark btn-sm ml-2">Editar</a>' +
                    '<button class="btn btn-danger btn-sm" onclick="eliminarUsuario(\'' + usuario.id + '\')">Eliminar</button>' +
                    '</td>'
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
    async function eliminarUsuario(id, button) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡No podrás recuperar este usuario!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then(async (result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: 'Eliminando usuario',
                    html: 'Por favor espere',
                    showConfirmButton: false,
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading()
                    },
                });
                try {
                    const response = await fetch('eliminar-usuario?id='+id, {
                        method: 'DELETE',
                        headers: { 'Content-Type': 'application/json' }
                    });

                    const resultado = await response.json();

                    if (resultado === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Usuario eliminado',
                            text: 'El usuario se ha eliminado correctamente',
                            confirmButtonText: 'Aceptar'
                        }).then(() => {
                            cargarUsuarios();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Hubo un problema al eliminar al usuario.',
                            confirmButtonText: 'OK'
                        });
                    }

                } catch (error) {
                    console.error('Error al eliminar usuario:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Hubo un problema al eliminar al usuario.',
                        confirmButtonText: 'OK'
                    });
                }
            }
        });
    }

   async function logOut(){
        await fetch('signOut',
            {
                method: 'POST',
                headers: {
                    'Content-type': 'application/json'
                },
                body: null
            }).then(
                window.location.href = 'login'
        )
    }

    // Cargar usuarios al cargar la página
    document.addEventListener('DOMContentLoaded', cargarUsuarios);
</script>

</body>
</html>
