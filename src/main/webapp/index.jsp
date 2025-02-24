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
            </div>

            <div class="mb-3 password-container">
                <label for="pass" class="form-label">Contraseña</label>
                <input type="password" id="pass" name="pass" class="form-control" placeholder="Ingresa tu contraseña" required autocomplete="off">
                <img onclick="pruebaShowPassword()" src="assets/download.png" class="toggle-password">
            </div>

            <button class="btn btn-dark w-100 mt-2" type="submit">Iniciar sesión</button>
        </form>
    </div>
</div>


<script>

    document.getElementById('mail').addEventListener('input', ()=>{
        const mailInput = document.getElementById('mail');
        if(mailInput.value.trim() === "" && mailInput.test('\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b')){
            mailInput.classList.add('is-invalid');
        } else {
            mailInput.classList.remove('is-invalid');
        }
    });

    document.getElementById('pass').addEventListener('input', ()=>{
        const passInput = document.getElementById('pass');
     if (!/^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$/.test(passInput.value) || /[{}[\]<>'"`]/.test(passInput.value)) {
         passInput.classList.add('is-invalid');
     } else {
         passInput.classList.remove('is-invalid');
     }
    });
    const pruebaShowPassword = ()=>{
        const passInput = document.getElementById('pass');
        if(passInput.type === 'password'){
            passInput.type = 'text';
        } else {
            passInput.type = 'password';
        }
    }
    // Evento para el formulario de inicio de sesion
    document.getElementById('loginForm').addEventListener('submit', async (e)=> {
        Swal.fire({
            title: 'Iniciando sesion',
            html: 'Por favor espere',
            showConfirmButton: false,
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading()
            },
        });
        e.preventDefault();
        // Obtenemos los datos del formulario
        const formData = new FormData(e.target);
        const data = {
            mail: formData.get('mail'),
            pass: formData.get('pass')
        }
        // Enviamos los datos al servidor
        try{
            await fetch('signIn', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            }).then(response => response.json()).then((data)=>{
                if(data === "fail"){
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
                        text: 'Inicio de sesion exitoso',
                        showConfirmButton: false,
                        timer: 1500
                    });
                    setTimeout(()=>{
                        window.location.href = "inicio";
                    }, 1500);
                }
            });
        }catch (e) {
            console.error(e);
        }
    });
</script>

</body>
</html>
