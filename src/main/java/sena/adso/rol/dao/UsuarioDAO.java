package sena.adso.rol.dao;

import java.sql.*;
import sena.adso.rol.modelo.Usuario;
import sena.adso.rol.util.ConexionBD;

public class UsuarioDAO {

    public Usuario validarUsuario(String username, String password) {

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;

        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery(sql);

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFechaRegistro(rs.getTimestamp("fecha_registro"));

                try {
                    usuario.setPasswordTemporal(rs.getBoolean("password_temporal"));
                    System.out.println("Password_temporal para username " + username + ": " + rs.getBoolean("password_temporal"));
                } catch (SQLException e) {
                    System.out.println("Columna password_temporal no encontrada en validarUsuario " + e.getMessage());
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al validar usuarios: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return usuario;
    }

    public Usuario buscarPorEmail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usuario = null;

        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT * FROM usuarios WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setUsername(rs.getString("username"));
                usuario.setPassword(rs.getString("password"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setFechaRegistro(rs.getTimestamp("fecha_registro"));

                try {
                    usuario.setPasswordTemporal(rs.getBoolean("password_temporal"));
                    System.out.println("Password_temporal para " + email + ": " + rs.getBoolean("password_temporal"));
                } catch (SQLException e) {
                    System.out.println("Columna password_temporal no encontrada en buscarPorEmail " + e.getMessage());
                }
            }

        } catch (SQLException e) {

            System.out.println("Error al buscar usurio por email: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return usuario;
    }

    public boolean actualizarPasaword(String email, String nuevaPassword) {
        return actualizarPasaword(email, nuevaPassword, true);
    }

    public boolean actualizarPasaword(String email, String nuevaPassword, boolean esTemporal) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;

        try {
            conn = ConexionBD.getConnection();
            String sql = "UPDATE usuarios SET password = ?, password_temporal = ? WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nuevaPassword);
            stmt.setBoolean(2, esTemporal);
            stmt.setString(3, email);

            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);

            //Log para depuracion
            System.out.println("Actualizar contraseña para " + email + ", es temporal:" + esTemporal + ", resultado: " + resultado);
        } catch (SQLException e) {
            System.out.println("Error al actualizar contraseña: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return resultado;
    }

    public boolean registrarUsuario(Usuario usuario) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;

        try {
            conn = ConexionBD.getConnection();
            String sql = "INSERT INTO usuario(username, password, email, rol, password_temporal) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, usuario.getUsername());
            stmt.setString(2, usuario.getPassword());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getRol());
            stmt.setBoolean(5, usuario.isPasswordTemporal());

            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);
        } catch (SQLException e) {
            System.out.println("Error al registrar usuario: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return resultado;
    }

    public boolean existeUsername(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean existe = false;
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT COUNT(*) FROM usuarios WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar existencia de usuario: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (Exception e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return existe;
    }

    public boolean actualizarPassword(String email, String passwordNuevo, boolean b) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
