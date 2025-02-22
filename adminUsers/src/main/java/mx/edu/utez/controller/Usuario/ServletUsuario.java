package mx.edu.utez.controller.Usuario;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(name = "ServletUsuario", urlPatterns= {
        "/incio"
})
public class ServletUsuario extends HttpServlet {

    protected void proccessRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Gson gson = new Gson();
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String json = "";
        String requestBody = sb.append(reader.readLine()).toString();
        String redirect = "/";
        String action = req.getServletPath();

        switch (action) {
            case "/inicio":
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}