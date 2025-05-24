package sena.adso.rol.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import sena.adso.rol.modelo.Persona;
import sena.adso.rol.util.ConexionBD;

public class PersonaDAO {
    
    private boolean resultado;

    public List<Persona> listarTodos() {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Persona> listarAprendices = new ArrayList<>();

        try {
            conn = ConexionBD.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM personas ORDER BY nombre");

            while (rs.next()) {
                Persona persona = new Persona();
                persona.setId(rs.getInt("id"));
                persona.setCedula(rs.getString("cedula"));
                persona.setNombre(rs.getString("nombre"));
                persona.setDireccion(rs.getString("direccion"));
                persona.setEmail(rs.getString("email"));
                persona.setFechaRegistro(rs.getTimestamp("fecha_registro"));

                listarAprendices.add(persona);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar personas: " + e.getMessage());
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
        return listarAprendices;
    }
    
    public Persona buscarPorId(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Persona persona = null;
        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT * FROM personas WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                persona  = new Persona();
                persona .setId(rs.getInt("id"));
                persona .setCedula(rs.getString("cedula"));
                persona .setNombre(rs.getString("nombre"));
                persona .setDireccion(rs.getString("direccion"));
                persona .setEmail(rs.getString("email"));
                persona .setFechaRegistro(rs.getTimestamp("fecha_registro"));
            }

        } catch (Exception e) {
            System.out.println("Error al buscar personas por ID: " + e.getMessage());
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
                System.out.println("Error al cerrar recursos" + e.getMessage());
            }
        }
        return persona;
    }
    
    public boolean insertar(Persona persona) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;

        try {
            conn = ConexionBD.getConnection();
            String sql = "INSERT INTO personas (cedula,nombre,direccion,email) VALUES (?,?,?;?,)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, persona.getCedula());
            stmt.setString(4, persona.getNombre());
            stmt.setString(2, persona.getDireccion());
            stmt.setString(3, persona.getEmail());

            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);

        } catch (SQLException e) {
            System.out.println("Error al insertar personas" + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos" + e.getMessage());
            }
        }
        return resultado;
    }
    
    public boolean actualizar(Persona persona) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;

        try {
            conn = ConexionBD.getConnection();
            String sql = " UPDATE personas SET cedula =  ?,nombre=  ?,direccion=  ?,email=  ? WHERE id =  ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, persona.getCedula());
            stmt.setString(4, persona.getNombre());
            stmt.setString(2, persona.getDireccion());
            stmt.setString(3, persona.getEmail());

            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);

        } catch (SQLException e) {
            System.out.println("Error al actualizar personas" + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos" + e.getMessage());
            }
        }
        return resultado;
    }
    
    public boolean eliminar(int id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean resultado = false;

        try {
            conn = ConexionBD.getConnection();
            String sql = " DELETE FROM aprendices WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            int filasAfectadas = stmt.executeUpdate();
            resultado = (filasAfectadas > 0);

        } catch (SQLException e) {
            System.out.println("Error al eliminar aprendiz" + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos" + e.getMessage());
            }
        }
        return resultado;
    }
    
    public boolean existeMail(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
       ResultSet rs = null;
        boolean existe = false;

        try {
            conn = ConexionBD.getConnection();
            String sql = "SELECT COUNT (*) FROM personas WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                existe = (rs.getInt(1) > 0  );
            }

        } catch (SQLException e) {
            System.out.println("Error al verificar email" + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    ConexionBD.closeConnection(conn);
                }
            } catch (SQLException e) {
                System.out.println("Error al cerrar email" + e.getMessage());
            }
        }
        return existe;
    }
    
    public boolean existeCedula(String cedula) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
        
