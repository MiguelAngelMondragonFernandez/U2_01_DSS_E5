package mx.edu.utez.controller.Usuario;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.model.Usuario.UsuarioBean;
import mx.edu.utez.model.Usuario.UsuarioDao;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(name = "ServletUsuario", urlPatterns= {
        "/inicio",
        "/getUsuarios",
        "/getUsuario",
        "/editar-usuario",
        "/modificar-usuario",
        "/eliminar-usuario"
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
        String requestBody = req.getReader().readLine();
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
                        req.getRequestDispatcher("/WEB-INF/home.jsp").forward(req, res);
                        break;
                    case "/getUsuario":
                        //Se obtiene el id del usuario a traves de la url
                        String idEncryp = req.getParameter("id").replace(" ","+");
                        try{
                        String id = UsuarioDao.decrypt("HelloUnhappyReoN","HelloUnhappyReoN",idEncryp);
                            UsuarioBean usuario = new UsuarioBean();
                            usuario = UsuarioDao.obtenerUsuarioPorId(Integer.parseInt(id));
                            json = gson.toJson(usuario);
                            System.out.println(json);
                            res.getWriter().write(json);
                        }catch (Exception e){
                            System.out.println("Error: "+e.getMessage());
                        }
                        break;
                    case "/modificar-usuario":
                        UsuarioBean usuario = new UsuarioBean();
                        usuario = gson.fromJson(requestBody, UsuarioBean.class);
                        boolean response = UsuarioDao.actualizarUsuario(usuario, dataSession[1]);
                        String resp = response ? "success" : "error";
                        json = gson.toJson(resp);
                        res.getWriter().write(json);
                        break;
                    case "/editar-usuario":
                        req.getRequestDispatcher("/WEB-INF/editarUsuario.jsp").forward(req, res);
                        break;
                        case "/getUsuarios":
                        json = gson.toJson(UsuarioDao.obtenerUsuarios());
                        res.getWriter().write(json);
                        break;
                    case "/eliminar-usuario": // Caso para eliminar usuario
                        String idEliminarEncryp = req.getParameter("id").replace(" ", "+");
                        try {
                            String idEliminar = UsuarioDao.decrypt("HelloUnhappyReoN", "HelloUnhappyReoN", idEliminarEncryp);
                            boolean eliminado = UsuarioDao.eliminarUsuario(Integer.parseInt(idEliminar), dataSession[1]); // Método para eliminar usuario
                            String result = eliminado ? "success" : "error";
                            json = gson.toJson(result);
                            res.getWriter().write(json);
                        } catch (Exception e) {
                            json = gson.toJson("Error: " + e.getMessage());
                            res.getWriter().write(json);
                        }
                        break;
                }

            } else {
                //Si el usuario no es admin se redirecciona a la pagina de error 403
                res.sendRedirect(req.getContextPath()+"/withoutSession");
            }
        }else{
            //Si no existe una sesion activa se redirecciona a la pagina de error 403
            res.sendRedirect(req.getContextPath()+"/withoutSession");
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
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        proccessRequest(request, response);
    }
}