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
    <form id="formEdit">
        <input type="hidden" name="id" value="">

        <div class="mb-3">
            <label>Nombre:</label>
            <input type="text" id="nombre" name="nombre" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Apellido Paterno:</label>
            <input type="text" name="aPaterno" id="aPaterno" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Apellido Materno:</label>
            <input type="text" name="aMaterno" id="aMaterno" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Correo:</label>
            <input type="email" name="correo" id="correo" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Teléfono:</label>
            <input type="text" name="telefono" id="telefono" class="form-control" required maxlength="10">
        </div>

        <div class="mb-3">
            <label>Edad:</label>
            <input type="number" name="edad" id="edad" class="form-control" required min="1" max="100">
        </div>

        <button type="submit" class="btn btn-dark" disabled>Actualizar</button>
    </form>
</div>

<script>
    function validarFormulario() {
        const form = document.getElementById('formEdit');
        const inputs = form.querySelectorAll('input');
        let formularioValido = true;

        inputs.forEach(input => {
            if (input.required && (input.value.trim() === "" || input.classList.contains('is-invalid'))) {
                formularioValido = false;
            }
        });

        document.querySelector('#formEdit button[type="submit"]').disabled = !formularioValido;
    }

    document.querySelectorAll('#formEdit input').forEach(input => {
        input.addEventListener('input', function () {
            const valor = this.value;

            if (this.name === 'correo') {
                this.classList.toggle('is-invalid', !/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(valor));
            } else if (this.name === 'telefono') {
                this.classList.toggle('is-invalid', !/^\d{10}$/.test(valor));
            } else if (this.name === 'edad') {
                this.classList.toggle('is-invalid', valor < 1 || valor > 100);
            } else {
                this.classList.toggle('is-invalid', /[{}$"',.<>[\]\\/ %&|@!?=+\-_*\^~`]/.test(valor));
            }

            validarFormulario();
        });
    });

    document.addEventListener('DOMContentLoaded', async function () {
        await fetch("getUsuario?id=<%=request.getParameter("id")%>", {
            method: 'GET',
            headers: { 'Content-Type': 'application/json' }
        })
            .then(response => response.json())
            .then(data => {
                document.getElementsByName("nombre")[0].value = data.nombre;
                document.getElementsByName("aPaterno")[0].value = data.aPaterno;
                document.getElementsByName("aMaterno")[0].value = data.aMaterno;
                document.getElementsByName("correo")[0].value = data.correo;
                document.getElementsByName("telefono")[0].value = data.telefono;
                document.getElementsByName("edad")[0].value = data.edad;
                document.getElementsByName("id")[0].value = data.id;

                validarFormulario(); // Verifica si el formulario ya es válido al cargar
            })
    });

    document.getElementById('formEdit').addEventListener('submit', async function (event) {
        event.preventDefault();
        Swal.fire({
            title: 'Actualizando usuario',
            html: 'Por favor espere',
            showConfirmButton: false,
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });

        const form = new FormData(event.target);
        const data = {
            id: form.get('id'),
            nombre: form.get('nombre'),
            aPaterno: form.get('aPaterno'),
            aMaterno: form.get('aMaterno'),
            correo: form.get('correo'),
            telefono: form.get('telefono'),
            edad: form.get('edad')
        };

        await fetch("modificar-usuario", {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                if (data === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: 'Usuario actualizado',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    setTimeout(() => {
                        window.location.href = "inicio";
                    }, 1500);
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error al actualizar',
                        showConfirmButton: false,
                        timer: 1500
                    });
                }
            });
    });
</script>
</body>
</html>
