package sena.adso.rol.modelo;

import java.sql.Timestamp;

public class Usuario {
    private int id;
    private String username;
    private String password;
    private String email;
    private String rol;
    private Timestamp fechaRegistro;
    private boolean passwordTemporal = false;

    public Usuario() {
    }

    public Usuario(int id, String username, String password, String email, String rol) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.rol = rol;
        this.passwordTemporal = false;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public boolean isPasswordTemporal() {
        return passwordTemporal;
    }

    public void setPasswordTemporal(boolean passwordTemporal) {
        this.passwordTemporal = passwordTemporal;
    }

    @Override
    public String toString() {
        return "Usuario{" + "id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + ", rol=" + rol + ", passwordTemporal=" + passwordTemporal + '}';
    }

    public void setPassword_temporal(boolean b) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
}
