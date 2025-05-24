package sena.adso.rol.filtro;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sena.adso.rol.modelo.Usuario;

/**
 * Filtro de seguridad para controlar el acceso a las paginas protegidas
 */
@WebFilter(filterName = "SeguridadFiltro", urlPatterns = {"/bibliotecario/*", "/lector/*"})
public class SeguridadFiltro implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No se requiere inicializacion especial
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();

        //Verificar si el usuario esta autenticado
        boolean isLoggedIn = (session != null && session.getAttribute("usuario") != null);
        boolean isBibliotecarioArea = requestURI.contains("/bibliotecario/");
        boolean isLectorArea = requestURI.contains("/Lector/");

        if (isLoggedIn) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            String rol = usuario.getRol();

            //Verificar acceso segun el rol
            if (isLectorArea && !"Bibliotecario".equals(rol)) {
                //Redirigir a la pagina de acceso denegado si un aprendiz intenta acceder al area de instructor
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/acceso-denegado.jsp");
                return;
            } else if (isLectorArea && !"Lector".equals(rol) && !"Bibliotecario".equals(rol)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/acceso-denegado.jsp");
                return;
            }

            // Si pasa las verificaciones, continuar con la cadena de filtros
            chain.doFilter(request, response);
        } else {
            //Si no esta autenticado, redirigir al login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
    //No se requiere limpieza especial    
    }

}
