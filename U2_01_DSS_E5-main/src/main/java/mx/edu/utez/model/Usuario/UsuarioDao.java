package mx.edu.utez.model.Usuario;
import javax.crypto.Cipher;
import javax.crypto.spec.*;

import static java.util.Base64.getDecoder;
import static java.util.Base64.getEncoder;
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
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setaPaterno(rs.getString("aPaterno"));
                usuario.setaMaterno(rs.getString("aMaterno"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setEdad(rs.getInt("edad"));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return usuario;

    }

    public static List<UsuarioBean> obtenerUsuarios(){
        String sqlQuery = "SELECT * FROM usuarios where id != 1";
        List<UsuarioBean> usuarios = new ArrayList<>();
        boolean resBitacora = false;
        try{
            connection = new MySQLConnection();
            con = connection.getConnection();
            pstm = con.prepareStatement(sqlQuery);
            rs = pstm.executeQuery();
            while(rs.next()){
                UsuarioBean usuario = new UsuarioBean();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setaPaterno(rs.getString("aPaterno"));
                usuario.setaMaterno(rs.getString("aMaterno"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setEdad(rs.getInt("edad"));
                usuarios.add(usuario);
            }
            resBitacora = addBitacora(1, "GET");
        }catch (Exception e){
            System.out.println("Error: "+e.getMessage());
        } finally {
            closeConnection();
        }
        return usuarios != null && resBitacora ? usuarios : null;
    }

    public static boolean actualizarUsuario(UsuarioBean usuario) {
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
            pstm.setInt(7, usuario.getId());
            int res = pstm.executeUpdate();
            boolean resBitacora = addBitacora(usuario.getId(), "PUT");
            return res > 0 && resBitacora;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            closeConnection();
        }
        return false;
    }

    public String encrypt(String llave, String iv, String texto) throws Exception {
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
}
