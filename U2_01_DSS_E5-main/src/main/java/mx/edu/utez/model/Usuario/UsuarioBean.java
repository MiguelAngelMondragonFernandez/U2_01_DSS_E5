package mx.edu.utez.model.Usuario;

public class UsuarioBean {
    public String correo,
    contrasena, aPaterno, aMaterno, nombre, telefono;
    public int id, edad;

    public UsuarioBean() {
    }

    public UsuarioBean(String correo, String contrasena, String aPaterno, String aMaterno, String nombre, String telefono, int edad) {
        this.correo = correo;
        this.contrasena = contrasena;
        this.aPaterno = aPaterno;
        this.aMaterno = aMaterno;
        this.nombre = nombre;
        this.telefono = telefono;
        this.edad = edad;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getaPaterno() {
        return aPaterno;
    }

    public void setaPaterno(String aPaterno) {
        this.aPaterno = aPaterno;
    }

    public String getaMaterno() {
        return aMaterno;
    }

    public void setaMaterno(String aMaterno) {
        this.aMaterno = aMaterno;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }
}
