<%@ page import="mx.edu.utez.model.Usuario.UsuarioDao" %><%--
  Created by IntelliJ IDEA.
  User: mickV
  Date: 21/02/2025
  Time: 11:01 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Title</title>
</head>
<body>
<h1>Hello Unhappy</h1>

<div class="row p-5" id="tabla">
    <td class="col-2">Nombre</td>
    <td class="col-2">Apellido Paterno</td>
    <td class="col-2">Apellido Materno</td>
    <td class="col-2">Correo</td>
    <td class="col-2">Telefono</td>
    <td class="col-2">Edad</td>
    <td class="col-2">Acciones</td>
</div>


<script>
    document.addEventListener('DOMContentLoaded', async ()=>{
        await fetch('getUsuarios',  {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(
            response => response.json()
        ).then(
            data => {
                console.log(data);
                data.forEach((usuario) => {
                    const fila = document.getElementById('tabla');
                    const nombre = usuario.nombre;
                    const aPaterno = usuario.aPaterno;
                    const aMaterno = usuario.aMaterno;
                    const correo = usuario.correo;
                    const telefono = usuario.telefono;
                    const edad = usuario.edad;
                    const id = usuario.id;
                    fila.innerHTML += '<div class="row p-2">'+
                        '<td class="col-2">'+nombre+'</td>'+
                        '<td class="col-2">'+aPaterno+'</td>'+
                        '<td class="col-2">'+aMaterno+'</td>'+
                        '<td class="col-2">'+correo+'</td>'+
                        '<td class="col-2">'+telefono+'</td>'+
                        '<td class="col-2">'+edad+'</td>'+
                        '<td class="col-2">'+
                        '<a href="editar-usuario?id='+id+'" class="btn btn-primary">Editar</a>'+
                        '<button class="btn btn-danger" onclick="eliminarUsuario(\''+id+'\')">Eliminar</button>'+
                        '</td>'+'</div>';
                });
            }
        );
    });

    function eliminarUsuario(id) {
        const newId = ""+id;
        // Confirmación de eliminación con SweetAlert
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡No podrás recuperar este usuario!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Realizamos la solicitud para eliminar el usuario
                fetch('eliminar-usuario?id=' + newId, {
                    method: 'DELETE' +
                        '', // Enviar la solicitud DELETE
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(response => {
                    if (response.ok) {
                        Swal.fire(
                            'Eliminado!',
                            'El usuario ha sido eliminado.',
                            'success'
                        ).then(() => {
                            // Recargar la página o actualizar la lista de usuarios
                            location.reload(); // Recarga la página para mostrar los cambios
                        });
                    } else {
                        Swal.fire(
                            'Error!',
                            'Hubo un problema al eliminar al usuario.',
                            'error'
                        );
                    }
                }).catch(error => {
                    Swal.fire(
                        'Error!',
                        'Hubo un error en la conexión.',
                        'error'
                    );
                });
            }
        });
    }
</script>
</body>
</html>
