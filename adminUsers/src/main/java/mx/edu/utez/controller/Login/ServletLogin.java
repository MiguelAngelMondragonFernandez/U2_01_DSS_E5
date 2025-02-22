package mx.edu.utez.controller.Login;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.model.Login.LoginBean;
import mx.edu.utez.model.Login.LoginDao;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(name = "ServletLogin", urlPatterns = {
        "/signIn",
        "/signOut",
        "/getPermisos",
        "/ServeltLogin",
})
public class ServletLogin extends HttpServlet {
    String redirect = "/", action;

    protected void proccessRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        Gson gson = new Gson();
        LoginBean loginBean = new LoginBean();
        LoginDao dao = new LoginDao();
        String json = "";
        res.setContentType("application/json");
        req.setCharacterEncoding("UTF-8");
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String requestBody = sb.append(reader.readLine()).toString();
        HttpSession session = req.getSession();
        action = req.getServletPath();
        switch (action) {
            case "/signIn":
                loginBean = gson.fromJson(requestBody, LoginBean.class);
                boolean response = dao.login(loginBean, session);
                json = gson.toJson(response ? "success" : "fail");
                res.getWriter().write(json);
                break;
            case "/getPermisos":
                String sesion = (String) session.getAttribute("session");
                if(sesion != null){
                    String[] data = sesion.split("/");
                    json = gson.toJson(data[2].equals("admin") ? "success": "fail") ;
                }else{
                    json = gson.toJson("fail");
                }
                res.getWriter().write(json);
                break;
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