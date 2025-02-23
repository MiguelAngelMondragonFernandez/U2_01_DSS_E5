package mx.edu.utez.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "EditarUsuarioServlet", urlPatterns = { "/editar-usuario" })
public class EditarUsuarioServlet extends HttpServlet {
    private UsuarioDao usuarioDao = new UsuarioDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario usuario = usuarioDao.obtenerUsuarioPorId(id);
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("editarUsuario.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String aPaterno = request.getParameter("aPaterno");
        String aMaterno = request.getParameter("aMaterno");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        int edad = Integer.parseInt(request.getParameter("edad"));

        Usuario usuario = new Usuario(id, nombre,aPaterno, aMaterno, correo, "", telefono, edad);
        boolean actualizado = usuarioDao.actualizarUsuario(usuario);

        if (actualizado) {
            response.sendRedirect(request.getContextPath() + "/inicio");
        } else {
            request.setAttribute("error", "No se pudo actualizar el usuario.");
            request.getRequestDispatcher("editarUsuario.jsp").forward(request, response);
        }
    }
}
