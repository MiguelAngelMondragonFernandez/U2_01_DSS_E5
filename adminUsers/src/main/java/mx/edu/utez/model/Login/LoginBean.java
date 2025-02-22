package mx.edu.utez.model.Login;

public class LoginBean {
    public String mail, pass;

    public LoginBean() {
    }

    public LoginBean(String mail, String password) {
        this.mail = mail;
        this.pass = password;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword() {
        return pass;
    }

    public void setPassword(String password) {
        this.pass = password;
    }
}
