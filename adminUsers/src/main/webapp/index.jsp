<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <title>Inicio de sesión</title>
</head>
<body>
<form id="loginForm" class="d-flex justify-content-center align-items-center" style="height: 100vh">
    <div>
        <h1>Bienvenido</h1>
        <div class="mt-3">
            <h6>Correo electronico</h6>
            <input id="mail" name="mail" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$" placeholder="Ingresa tu correo electronico" required/>
        </div>
        <div class="mt-3">
            <h6>Contraseña</h6>
            <input id="pass" name="pass" type="password" placeholder="Ingresa tu contraseña" required/>
            <img onclick="pruebaShowPassword()" src="./assets/download.png" class="p-1" style="width: 35px;"/>
        </div>
        <button class="btn btn-primary mt-2" type="submit">Iniciar sesion</button>
    </div>
</form>
<script>
    const pruebaShowPassword = ()=>{
        const passInput = document.getElementById('pass');
        passInput.type = passInput.type === 'password' ? 'text' : 'password';
    }
    document.getElementById('loginForm').addEventListener('submit', async (e)=> {
        e.preventDefault();
        const SECRET_KEY = "Hello_Unhappy";
        const formData = new FormData(e.target);
        const data = {
            mail: formData.get('mail'),
            pass: formData.get('pass')
        }
        try{
            const response = await fetch('signIn', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            }).then(response => response.json()).then((data)=>{
                if(data === "fail"){
                    alert("Correo o contraseña incorrectos");
                }else{
                    window.location.href = "home.jsp";
                }
            });
        }catch (e) {
            console.error(e);
        }
    });
</script>
</body>
</html>