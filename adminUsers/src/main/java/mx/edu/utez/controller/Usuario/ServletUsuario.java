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
        Gson gson = new Gson();
        String json = "";
        res.setContentType("application/json");
        req.setCharacterEncoding("UTF-8");
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String requestBody = sb.append(reader.readLine()).toString();
        HttpSession session = req.getSession();
        String data = (String) session.getAttribute("session");
        String action = req.getServletPath();
        if(data != null){
            String[] dataSession = data.split("/");
            if(dataSession[2].equals("admin")){
                switch (action) {
                    case "/inicio":
                        res.sendRedirect(req.getContextPath()+"/home.jsp");
                        System.out.println("Inicio");
                        break;
                }
            } else {
                res.sendRedirect(req.getContextPath()+"/403.jsp");
            }
        }else{
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