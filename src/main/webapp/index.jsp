<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de sesión</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap JS y SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .password-container {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            width: 30px;
            opacity: 0.7;
        }

        .toggle-password:hover {
            opacity: 1;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
    <div class="p-4 shadow-lg rounded bg-light" style="width: 350px;">
        <h2 class="text-center mb-4">Bienvenido</h2>

        <form id="loginForm">
            <div class="mb-3">
                <label for="mail" class="form-label">Correo electrónico</label>
                <input type="email" id="mail" name="mail" class="form-control" placeholder="Ingresa tu correo" required>
                <div class="invalid-feedback">Introduce un correo válido.</div>
            </div>

            <div class="mb-3 password-container">
                <label for="pass" class="form-label">Contraseña</label>
                <input type="password" id="pass" name="pass" class="form-control" placeholder="Ingresa tu contraseña" required autocomplete="off">
                <img onclick="toggleShowPassword()" src="assets/download.png" class="toggle-password">
                <div class="invalid-feedback">La contraseña debe tener al menos 6 caracteres, incluir una mayúscula, un número y no contener caracteres especiales.</div>
            </div>

            <button class="btn btn-dark w-100 mt-2" type="submit" disabled>Iniciar sesión</button>
        </form>
    </div>
</div>

<script>
    function validarFormulario() {
        const mailInput = document.getElementById('mail');
        const passInput = document.getElementById('pass');
        const submitBtn = document.querySelector("#loginForm button");

        let correoValido = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(mailInput.value);
        let contrasenaValida = /^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$/.test(passInput.value) && !/[{}[\]<>'"`]/.test(passInput.value);

        mailInput.classList.toggle('is-invalid', !correoValido);
        passInput.classList.toggle('is-invalid', !contrasenaValida);

        submitBtn.disabled = !(correoValido && contrasenaValida);
    }

    document.getElementById('mail').addEventListener('input', validarFormulario);
    document.getElementById('pass').addEventListener('input', validarFormulario);

    function toggleShowPassword() {
        const passInput = document.getElementById('pass');
        passInput.type = passInput.type === 'password' ? 'text' : 'password';
    }

    // Evento para el formulario de inicio de sesión
    document.getElementById('loginForm').addEventListener('submit', async (e) => {
        e.preventDefault();

        Swal.fire({
            title: 'Iniciando sesión',
            html: 'Por favor espere',
            showConfirmButton: false,
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            },
        });

        // Obtenemos los datos del formulario
        const formData = new FormData(e.target);
        const data = {
            mail: formData.get('mail'),
            pass: formData.get('pass')
        };

        try {
            const response = await fetch('signIn', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });

            const result = await response.json();

            if (result === "fail") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Correo y/o contraseña incorrectos',
                    showConfirmButton: false,
                    timer: 1500
                });
            } else {
                Swal.fire({
                    icon: 'success',
                    title: 'Bienvenido',
                    text: 'Inicio de sesión exitoso',
                    showConfirmButton: false,
                    timer: 1500
                });

                setTimeout(() => {
                    window.location.href = "inicio";
                }, 1500);
            }
        } catch (error) {
            console.error(error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Ha ocurrido un problema, inténtalo más tarde.',
                showConfirmButton: true
            });
        }
    });
</script>

</body>
</html>
