package mx.edu.utez.model.Login;

import jakarta.servlet.http.HttpSession;
import mx.edu.utez.utils.MySQLConnection;

import java.sql.*;


public class LoginDao {
    public static MySQLConnection connection;
    public static Connection con;
    public static PreparedStatement pstm;
    public static ResultSet rs;

    public static boolean login(LoginBean loginBean, HttpSession session) {
        String sqlQuery = "SELECT * FROM usuarios where correo = ? and contrasena = sha1(?);";
        try {
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setString(1, loginBean.mail);
            pstm.setString(2, loginBean.pass);
            rs = pstm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                //Se asigna el permiso
                String permisos = id == 1 ? "admin" : "user";
                //Se asigna la sesion con el permiso
                session.setAttribute("session", loginBean.mail + "/" + id + "/" + permisos);
                //Se registra en la bitacora
                boolean res = addBitacora(id, "POST");
                //Se retorna true si la sesion se asigno correctamente y se hizo el registro en la bitacora
                return session.getAttribute("session") != null && res;
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    public static boolean addBitacora(int idUser, String method) {
        String sqlQuery = "INSERT INTO bitacora values(null, ?, ?, CURRENT_TIMESTAMP());";
        String descripcion = "Metodo " + method;
        try {
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setInt(1, idUser);
            pstm.setString(2, descripcion);
            int res = pstm.executeUpdate();
            return res > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    public static void closeConnection() {
        try {
            rs.close();
            pstm.close();
            con.close();
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }

}
