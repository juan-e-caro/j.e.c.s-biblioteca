package sena.adso.rol.controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sena.adso.rol.dao.UsuarioDAO;
import sena.adso.rol.modelo.Usuario;
import sena.adso.rol.util.EmailUtil;

/* servlet que maneja el proseso de rejistro del usuario

 */
@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})

public class RegistroServlet extends HttpServlet {

    /*
    maneja las solicitudes Get al servlet de registro muestra el formulario de registro 
    
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/registro.jsp").forward(request, response);

    }

    /*
    *maneja las solicitudes POST al servlet  de registro 
    prosesa el formulario de reguistro de usuario 
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String rol = request.getParameter("rol");
        String mensaje = "";

        // validar que se hayan proporcionado todos los campos 
        if (username == null || username.isEmpty() || email == null || email.isEmpty() || rol == null || rol.isEmpty()) {
            mensaje = " por favor complete todos los campos del formulario ";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", "danger");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }
        
        // verificar si el rol ssea valido 
        if (!rol.equals("Bibliotecario") && !rol.equals("Lector")) {
            mensaje = " rol selecionado no es valido ";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", "danger");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }
        
        //Verificar si el usuario ya existe
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        if (usuarioDAO.existeUsername(username)) {
            mensaje = " El nombre de usuario ya esta en uso. Por favor, elija otro";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", "danger");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }
        
        //Verificacion si el mail ya existe
        Usuario usuarioExistente = usuarioDAO.buscarPorEmail(email);
        if (usuarioExistente != null) {
            mensaje = " El correo electronico ya esta registrado";
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("tipo", "danger");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }
        
        //Genarar contraseña aleatoria
        String password = EmailUtil.generalPasswordTemporal();
        
        //Crear objeto Usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setUsername(username);
        nuevoUsuario.setPassword(password);
        nuevoUsuario.setEmail(email);
        nuevoUsuario.setRol(rol);
        
        //Registrar usuario en la base de datos
        boolean registrado = usuarioDAO.registrarUsuario(nuevoUsuario);
        
        if (registrado) {
            //Enviar credenciales por correo electronico
            boolean enviado = EmailUtil.enviarCorreoRecuperacion(email, username, password); 
            
            if (enviado) {
                mensaje = "Registro exitoso. Se han enviado las  credenciales a su correo electronico";
                request.setAttribute("tipo", "success");
            }else{
                mensaje = "Registro exitoso. Pero hubo un problema al enviar las credenciales por correo";
                request.setAttribute("tipo", "warning");     
            }
        }else{
            mensaje = "Error al registrar el usuario. Por favor, intente nuevamente";
            request.setAttribute("tipo", "danger");
        }
        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
        

    }
}