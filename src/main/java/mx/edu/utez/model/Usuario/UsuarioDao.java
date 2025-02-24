package mx.edu.utez.model.Usuario;
import javax.crypto.Cipher;
import javax.crypto.spec.*;

import static java.util.Base64.getDecoder;
import static java.util.Base64.getEncoder;

import jakarta.servlet.http.HttpSession;
import mx.edu.utez.model.Bitacora;
import mx.edu.utez.utils.MySQLConnection;

import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class UsuarioDao {
    public static MySQLConnection connection;
    public static Connection con;
    public static PreparedStatement pstm;
    public static ResultSet rs;

    public static UsuarioBean obtenerUsuarioPorId(int id) {
        UsuarioBean usuario = new UsuarioBean();
        try {
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement("SELECT * FROM usuarios WHERE id = ?");
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                usuario.setId(String.valueOf(rs.getInt("id")));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setaPaterno(rs.getString("aPaterno"));
                usuario.setaMaterno(rs.getString("aMaterno"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setEdad(rs.getInt("edad"));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            addBitacora(id, "GET", "error");
        } finally {
            closeConnection();
        }
        return usuario;

    }

    public static List<UsuarioBean> obtenerUsuarios(String id){
        String sqlQuery = "SELECT * FROM usuarios where id != 1 and id != 2;";
        List<UsuarioBean> usuarios = new ArrayList<>();
        boolean resBitacora = false;
        try{
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            rs = pstm.executeQuery();
            while(rs.next()){
                UsuarioBean usuario = new UsuarioBean();
                usuario.setId(encrypt("HelloUnhappyReoN","HelloUnhappyReoN",String.valueOf(rs.getInt("id"))));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setaPaterno(rs.getString("aPaterno"));
                usuario.setaMaterno(rs.getString("aMaterno"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setEdad(rs.getInt("edad"));
                usuarios.add(usuario);
            }
            resBitacora = addBitacora(Integer.parseInt(id), "GET", "success");
        }catch (Exception e){
            System.out.println("Error: "+e.getMessage());
            addBitacora(Integer.parseInt(id), "GET", "error");
        } finally {
            closeConnection();
        }
        return usuarios != null && resBitacora ? usuarios : null;
    }

    public static boolean anadirUsuario(UsuarioBean usuario, String idUser){
        String sqlQuery = "INSERT INTO usuarios values(null, ?, ?, ?, ?, sha1(?), ?, ?);";
        try{
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setString(1, usuario.getNombre());
            pstm.setString(2, usuario.getaPaterno());
            pstm.setString(3, usuario.getaMaterno());
            pstm.setString(4, usuario.getCorreo());
            pstm.setString(5, usuario.getContrasena());
            pstm.setString(6, usuario.getTelefono());
            pstm.setInt(7, usuario.getEdad());
            int res = pstm.executeUpdate();
            boolean resBitacora = addBitacora(Integer.parseInt(idUser), "POST", "success");
            return res > 0 && resBitacora;
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            addBitacora(Integer.parseInt(idUser), "POST", "error");
        }
        return false;
    }

    public static boolean actualizarUsuario(UsuarioBean usuario, String id) {
        String sqlQuery = "UPDATE usuarios SET nombre = ?, aPaterno = ?, aMaterno = ?, correo = ?, telefono = ?, edad = ? WHERE id = ?";
        try {
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setString(1, usuario.getNombre());
            pstm.setString(2, usuario.getaPaterno());
            pstm.setString(3, usuario.getaMaterno());
            pstm.setString(4, usuario.getCorreo());
            pstm.setString(5, usuario.getTelefono());
            pstm.setInt(6, usuario.getEdad());
            pstm.setInt(7, Integer.parseInt(usuario.getId()));
            int res = pstm.executeUpdate();
            boolean resBitacora = addBitacora(Integer.parseInt(id), "PUT", "success");
            return res > 0 && resBitacora;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            addBitacora(Integer.parseInt(id), "PUT", "error");
        } finally {
            closeConnection();
        }
        return false;
    }

    public static boolean eliminarUsuario(int id, String idUser) {
        String sqlQuery = "DELETE FROM usuarios WHERE id = ?";
        try {
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setInt(1, id);
            int res = pstm.executeUpdate();
            boolean resBitacora = addBitacora(Integer.parseInt(idUser), "DELETE", "success");
            return res > 0 && resBitacora;  // Retorna true si la eliminación fue exitosa
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            addBitacora(Integer.parseInt(idUser), "DELETE", "error");
        } finally {
            closeConnection();
        }
        return false;  // Retorna false si hubo un error
    }

    public static String encrypt(String llave, String iv, String texto) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        SecretKeySpec secretKeySpec = new SecretKeySpec(llave.getBytes(), "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);
        byte[] encrypted = cipher.doFinal(texto.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }

    public static String decrypt(String llave, String iv, String encrypted) throws Exception {
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        SecretKeySpec secretKeySpec = new SecretKeySpec(llave.getBytes(), "AES");
        IvParameterSpec ivParameterSpec = new IvParameterSpec(iv.getBytes());
        byte[] enc = Base64.getDecoder().decode(encrypted);
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);
        // Descifrado del texto
        byte[] decrypted = cipher.doFinal(enc);
        return new String(decrypted, StandardCharsets.UTF_8);
    }

    public static void closeConnection() {
        try {
            rs.close();
            pstm.close();
            con.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static boolean addBitacora(int idUser, String method, String estado) {
        String sqlQuery = "INSERT INTO bitacora values(null, ?, ?, ?, CURRENT_TIMESTAMP());";
        String descripcion = "Metodo " + method;
        try {
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            pstm.setInt(1, idUser);
            pstm.setString(2, descripcion);
            pstm.setString(3, estado);
            int res = pstm.executeUpdate();
            return res > 0;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    public static List<Bitacora> obtenerBitacora(int idUser) {
        List<Bitacora> bitacoras = new ArrayList<>();
        String sqlQuery = "SELECT * FROM bitacora;";
        boolean res = false;
        try{
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            rs = pstm.executeQuery();
            while(rs.next()){
                Bitacora bitacora = new Bitacora();
                bitacora.setId(rs.getInt("idBitacora"));
                bitacora.setIdUsuario(rs.getInt("idUsuario"));
                bitacora.setAccion(rs.getString("operacion"));
                bitacora.setFecha(rs.getString("fecha_realizacion"));
                bitacora.setEstado(rs.getString("estado_operacion"));
                bitacoras.add(bitacora);
            }
            res = addBitacora(idUser, "GET", "success");
        }catch (Exception e){
            System.out.println("Error: "+e.getMessage());
           res = addBitacora(idUser, "GET", "error");
        } finally {
            closeConnection();
        }
        return res && !bitacoras.isEmpty() ? bitacoras : null;
    }
}
