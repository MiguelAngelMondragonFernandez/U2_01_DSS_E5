package mx.edu.utez.model.Usuario;
import mx.edu.utez.utils.MySQLConnection;

import java.sql.*;

public class UsuarioDao {
    public Usuario obtenerUsuarioPorId(int id) {
        Usuario usuario = null;
        try (Connection connection = new MySQLConnection().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM usuarios WHERE id = ?")) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                usuario = new Usuario(
                        resultSet.getInt("id"),
                        resultSet.getString("nombre"),
                        resultSet.getString("aPaterno"),
                        resultSet.getString("aMaterno"),
                        resultSet.getString("correo"),
                        resultSet.getString("contrasena"),
                        resultSet.getString("telefono"),
                        resultSet.getInt("edad")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    public boolean actualizarUsuario(Usuario usuario) {
        try (Connection connection = new MySQLConnection().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE usuarios SET nombre=?, aPaterno=?, aMaterno=?, correo=?, telefono=?, edad=? WHERE id=?")) {
            preparedStatement.setString(1, usuario.getNombre());
            preparedStatement.setString(2, usuario.getaPaterno());
            preparedStatement.setString(3, usuario.getaMaterno());
            preparedStatement.setString(4, usuario.getCorreo());
            preparedStatement.setString(5, usuario.getTelefono());
            preparedStatement.setInt(6, usuario.getEdad());
            preparedStatement.setInt(7, usuario.getId());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
