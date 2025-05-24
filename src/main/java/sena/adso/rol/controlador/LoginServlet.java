package sena.adso.rol.controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sena.adso.rol.dao.UsuarioDAO;
import sena.adso.rol.modelo.Usuario;


/*
*servlet que maneja el proceso de inicio de session 
 */
@WebServlet(name = "LoginsServet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    /*
    
    *maneja las solicitudes get al servlet de login 
    redirige a la pagina de inicio si ya hay una sesion activa 
    
    
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // si ya hay una session activa redirigir segun el rol 
        if (session != null && session.getAttribute("usuario") != null) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            redirigirSegunRol(usuario, request, response);
        } else {
            // si no hay sesion mostrar la pagina de login 
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        }

    }

    /*
    maneja las solicitudes POST al servidos
    prosesa el formulario de inicio de sesion 
    
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username ");
        String password = request.getParameter("password");
        String mensaje;

        // validar que se hayan proporcionado credenciales 
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            mensaje = " Por favor, ingrese usuario y contraseña";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        }

        //intentar auntificar el usuario 
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.validarUsuario(username, password);

        if (usuario != null) {
            //Autenticacion exitosa, crear sesion
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setMaxInactiveInterval(30 * 60); //30 min de inactividad
            
            //Redirigir segun el rol del usuario
            redirigirSegunRol(usuario, request, response);
        }else{
            //Autenticacion fallida
            mensaje = "Usuario o contraseña incorrectos";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            
        }

    }

    private void redirigirSegunRol(Usuario usuario, HttpServletRequest request, HttpServletResponse response)
         throws IOException{
        //Si el usuario tiene una contraseña temporal, redirigir al campo obligatorio
        if (usuario.isPasswordTemporal()) {
            response.sendRedirect(request.getContextPath() + "/cambiar-password");
            return;
        }
        
        //Redirigir segun el rol
        if ("Bibliotecario".equals(usuario.getRol())) {
            //Redirigir al instructor al CRUD de aprendices
            response.sendRedirect(request.getContextPath() + "/bibliotecario/books/list");
        } else if("Lector".equals(usuario.getRol())){
            // Redirigir al aprendiz a la vista de solo lectura
            response.sendRedirect(request.getContextPath() + "/lector/list");
        } else {
            //Rol no reconocido, cerrar sesion por seguridad
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

}