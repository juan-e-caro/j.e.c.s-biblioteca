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

/**
 * Servlet que maneja el proceso de recuperacion de contraseña
 */
@WebServlet(name = "RecuperarPasswordServlet", urlPatterns = {"/recuperar-password"})
public class RecuperarPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/recuperar-password.jsp").forward(request, response);

    }

    /**
     * Maneja las solicitudes GET al servlet de recuperacion Muestra el
     * formulario de recuperacion de contraseña
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String mensaje = "";

        //Validar que se haya proporcionado un email
        if (email == null || email.isEmpty()) {
            mensaje = "Por favor ingrese su direccion de correo electronico";
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("/recuperar-password.jsp").forward(request, response);
            return;

        }

        //Busca el usuario por email
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.buscarPorEmail(email);

        if (usuario != null) {
            //Genarar nueva contraseña temporal
            String nuevaPassword = EmailUtil.generarPasswordTemporal();

            //Actualizar la contraseña en la base de datos y marcarla explicitamente como temporal
            boolean actualizado = usuarioDAO.actualizarPasaword(email, nuevaPassword, true); //True = es temporal

            System.out.println("Contraseña ttemporal general para " + email + ": " + nuevaPassword);
            System.out.println("¿Contrseña marca como temporal? " + (actualizado ? "Si" : "No"));

            if (actualizado) {
                //Envia correo con la nueva contraseña
                boolean enviado = EmailUtil.enviarCorreoRecuperacion(email, nuevaPassword);

                if (enviado) {
                    mensaje = "Se ha enviado un correo con su nueva contraseña";
                    request.setAttribute("tipo", "success");
                } else {
                    mensaje = "Error al enviar correo. Por favor, contacte al administrador";
                    request.setAttribute("tipo", "danger");
                }
            } else {
                mensaje = "Error al actualizar la contraseña. Por favor, intente nuevamente";
                request.setAttribute("tipo", "danger");
            }

        } else {
            //No mostrar si el email existe o no por seguridad
            mensaje = "Si su correo esta registrado, recibira instrucciones para recuperar su contraseña";
            request.setAttribute("tipo", "info");
        }

        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("/recuperar-password.jsp").forward(request, response);
    }

}
