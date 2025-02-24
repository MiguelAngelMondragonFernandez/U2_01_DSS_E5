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
<div class="container mt-5">
    <h2>Agregar Nuevo Usuario</h2>
    <form id="formUsuario">

        <div class="mb-3">
            <label for="nombre">Nombre:</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
            <div class="invalid-feedback">El nombre no debe contener caracteres especiales.</div>
        </div>

        <div class="mb-3">
            <label for="aPaterno">Apellido Paterno:</label>
            <input type="text" class="form-control" id="aPaterno" name="aPaterno" required>
            <div class="invalid-feedback">El apellido no debe contener caracteres especiales.</div>
        </div>

        <div class="mb-3">
            <label for="aMaterno">Apellido Materno:</label>
            <input type="text" class="form-control" id="aMaterno" name="aMaterno" required>
            <div class="invalid-feedback">El apellido no debe contener caracteres especiales.</div>
        </div>

        <div class="mb-3">
            <label for="correo">Correo:</label>
            <input type="email" class="form-control" id="correo" name="correo" required>
            <div class="invalid-feedback">Introduce un correo válido.</div>
        </div>

        <div class="mb-3">
            <label for="contrasena">Contraseña:</label>
            <input type="password" class="form-control" id="contrasena" name="contrasena" required>
            <div class="invalid-feedback">La contraseña debe tener al menos 6 caracteres.</div>
        </div>

        <div class="mb-3">
            <label for="telefono">Teléfono:</label>
            <input type="text" class="form-control" id="telefono" name="telefono" required maxlength="10">
            <div class="invalid-feedback">El teléfono debe contener exactamente 10 dígitos numéricos.</div>
        </div>

        <div class="mb-3">
            <label for="edad">Edad:</label>
            <input type="number" class="form-control" id="edad" name="edad" required min="18">
            <div class="invalid-feedback">La edad debe ser 18 o mayor.</div>
        </div>

        <button type="submit" class="btn btn-dark mt-3" disabled>Registrar Usuario</button>
    </form>
</div>

<script>
    function validarFormulario() {
        const form = document.getElementById("formUsuario");
        const inputs = form.querySelectorAll("input");
        let esValido = true;

        inputs.forEach(input => {
            if (input.required && (input.value.trim() === "" || input.classList.contains("is-invalid"))) {
                esValido = false;
            }
        });

        document.querySelector("#formUsuario button").disabled = !esValido;
    }

    document.querySelectorAll("#formUsuario input").forEach(input => {
        input.addEventListener("input", function () {
            const valor = this.value.trim();

            if (this.name === "correo") {
                this.classList.toggle("is-invalid", !/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(valor));
            } else if (this.name === "contrasena") {
                this.classList.toggle("is-invalid", valor.length < 6);
            } else if (this.name === "telefono") {
                this.classList.toggle("is-invalid", !/^\d{10}$/.test(valor));
            } else if (this.name === "edad") {
                this.classList.toggle("is-invalid", valor < 18);
            } else {
                this.classList.toggle("is-invalid", /[{}$"',.<>[\]\\/ %&|@!?=+\-_*\^~`]/.test(valor));
            }

            validarFormulario();
        });
    });

    document.getElementById("formUsuario").addEventListener("submit", async function (event) {
        event.preventDefault();

        Swal.fire({
            title: "Registrando usuario",
            html: "Por favor espere",
            showConfirmButton: false,
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            }
        });

        const formData = new FormData(event.target);
        const usuario = {
            nombre: formData.get("nombre"),
            aPaterno: formData.get("aPaterno"),
            aMaterno: formData.get("aMaterno"),
            correo: formData.get("correo"),
            telefono: formData.get("telefono"),
            contrasena: formData.get("contrasena"),
            edad: parseInt(formData.get("edad"), 10)
        };

        const response = await fetch("anadir-usuario", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(usuario)
        });

        const resultado = await response.json();
        if (resultado === "success") {
            Swal.fire({
                title: "Usuario registrado",
                text: "El usuario se ha registrado correctamente",
                icon: "success",
                confirmButtonText: "Aceptar"
            }).then(() => {
                window.location.href = "inicio";
            });
        } else {
            Swal.fire({
                title: "Error",
                text: "Ha ocurrido un error al registrar el usuario",
                icon: "error",
                confirmButtonText: "Aceptar"
            });
        }
    });
</script>
</body>
</html>
