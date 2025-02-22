package mx.edu.utez.controller.Usuario;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(name = "ServletUsuario", urlPatterns= {
        "/inicio"
})
public class ServletUsuario extends HttpServlet {

    protected void proccessRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("application/json");
        req.setCharacterEncoding("UTF-8");
        /*Lineas necesarias para el uso de JSON
        Y para recibir los datos de la peticion* en JSON
         */
        Gson gson = new Gson();
        String json = "";
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String requestBody = sb.append(reader.readLine()).toString();
        /*Lineas necesarias para el uso de JSON*/

        /*Lineas necesarias para la validacion de permisos*/
        HttpSession session = req.getSession();
        String data = (String) session.getAttribute("session");
        /*Lineas necesarias para la validacion de permisos*/

        //Se obtiene la url donde se encuentra el usuario
        String action = req.getServletPath();

        //Se valida si existe una sesion activa
        if(data != null){
            //Se obtiene el tipo de usuario
            String[] dataSession = data.split("/");
            //Se valida si el usuario es admin
            if(dataSession[2].equals("admin")){
                switch (action) {
                    case "/inicio":
                        res.sendRedirect(req.getContextPath()+"/home.jsp");
                        System.out.println("Inicio");
                        break;
                    case "ejemplo":
                        //Lineas de codigo para regresar la respuesta en JSON
                        json = gson.toJson("respuesta, puede ser un objeto o un mensaje");
                        res.getWriter().write(json);
                        break;
                }
            } else {
                //Si el usuario no es admin se redirecciona a la pagina de error 403
                res.sendRedirect(req.getContextPath()+"/403.jsp");
            }
        }else{
            //Si no existe una sesion activa se redirecciona a la pagina de error 403
            res.sendRedirect(req.getContextPath()+"/403.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        proccessRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        proccessRequest(request, response);
    }
}