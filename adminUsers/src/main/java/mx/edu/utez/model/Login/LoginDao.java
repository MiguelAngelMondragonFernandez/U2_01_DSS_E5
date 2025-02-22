package mx.edu.utez.model.Login;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.adminusers.HelloServlet;
import mx.edu.utez.utils.MySQLConnection;
import java.sql.*;


public class LoginDao {
    private static MySQLConnection connection = new MySQLConnection();
    public static Connection con;
    public static PreparedStatement pstm;
    public static ResultSet rs;

    public static boolean login(LoginBean loginBean, HttpSession session){
        String sqlQuery = "SELECT * FROM usuarios where correo = ? and contrasena = sha1(?);";
        try{
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setString(1, loginBean.mail);
            pstm.setString(2, loginBean.pass);
            rs = pstm.executeQuery();
            if(rs.next()){
                //Se asigna el permiso
                String permisos = rs.getInt("id") == 1 ? "admin" : "user";
                //Se asigna la sesion con el permiso
                session.setAttribute("session", loginBean.mail+"/"+loginBean.pass+"/"+permisos);
                //Se retorna true si la sesion se asigno correctamente
                return session.getAttribute("session") != null;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if(con != null) con.close();
                if(pstm != null) pstm.close();
                if(rs != null) rs.close();
            } catch (Exception e) {
                System.out.println("Error login: " + e.getMessage());
            }
        }
        return false;
    }
}
