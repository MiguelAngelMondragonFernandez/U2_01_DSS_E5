package mx.edu.utez.utils;

import java.sql.*;

public class MySQLConnection {

    Connection conn;
    public static void main(String[] args) {
        try {
            Connection con = new MySQLConnection().getConnection();
            if(con != null){
                System.out.println("Hello Unhappy");
                con.close();
            }else {
                System.out.println("Sí jaló");
            }
        }catch (SQLException e){
            System.out.println("Eror en: "+e);
        }
    }

    public MySQLConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/adminusers","root","");
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error en: "+e);
        }
    }
    public Connection getConnection(){
        return conn;
    }
}
