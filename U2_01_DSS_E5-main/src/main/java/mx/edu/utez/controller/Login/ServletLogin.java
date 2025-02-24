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
        "/login",
        "/getPermisos",
        "/withoutSession",
        "/ServeltLogin",
})
public class ServletLogin extends HttpServlet {
    String redirect = "/", action;

    protected void proccessRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("application/json");
        req.setCharacterEncoding("UTF-8");
        LoginBean loginBean = new LoginBean();
        LoginDao dao = new LoginDao();
        Gson gson = new Gson();
        String json = "";
        String requestBody = req.getReader().readLine();
        HttpSession session = req.getSession();
        action = req.getServletPath();
        switch (action) {
            case "/login":
                req.getRequestDispatcher("/index.jsp").forward(req, res);
                break;
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
            case "/withoutSession":
                req.getRequestDispatcher("/WEB-INF/403.jsp").forward(req, res);
                break;
            case "/signOut":
                session.invalidate();
                res.sendRedirect(req.getContextPath()+"/");
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