package sena.adso.rol.util;

import java.io.PrintStream;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress; 
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    //Configuracion del servidor de correo (Gmail)
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    private static final String USERNAME = "juaneduardocarosochimilca.jecs@gmail.com"; // Colocar su correo electroico
    private static final String PASSWORD = ""; //Usar su contraseña de aplicacion
    // Bandera para activar/desactivar depuracion
    private static final boolean DEBUG = true;
    private static String nuevaPassword;

    public static boolean enviarCorreoRecuperacion(String destinatario, String nuevoPassaword) {
        //Configurar propiedades del servidor SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.ssl.protocols", " TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        //Configuracion adicional para evitar errores de conexion
        props.put("mail.smtp.connectiontimeout", "5000");
        props.put("mail.smtp.timeout", "5000");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        try {
            //Crear sesion con autenticacion
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });

            //Activar depuracion si esta habilitada
            //El DEBUG sirve para comprobar errores 
            if (DEBUG) {
                session.setDebug(true);
                session.setDebugOut(new PrintStream(System.out));
                System.out.printf("Enviando correo de recuperacion a: " + destinatario);
                System.out.printf("Usando correo remitente: " + USERNAME);
                System.out.printf("Usando contraseña de aplicacion: " + PASSWORD.replaceAll(".", "*"));
            }
            //Crear mensaje
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(USERNAME));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Recuperacion de Contraseña - Sistema de Roles");

            //Contenido del mensaje
            String contenido = "<html><body>"
                    + "<h2>Recuperacion de Contraseña</h2>"
                    + "<p>Estimado usuario,</p>"
                    + "<p>Hemos recibido una solicitud para recuperar su contraseña."
                    + "Su nueva contraseña temporal es: <strong>" + nuevaPassword + "</strong></p>"
                    + "<p>Por favor, cambie esta contraseña despues de iniciar sesion por motivos de seguridad.</p>"
                    + "<p>Si usted no solicito este cambio, por favor ignore este mensaje.</p>"
                    + "<p>Saludos,<br>Equipo de Soporte</p>"
                    + "</body></html>";

            mensaje.setContent(contenido, "text/html; charset=utf-8");

            //Enviar mensaje
            Transport.send(mensaje);
            if (DEBUG) {
                System.out.println("Correo de recuperacion enviado exitosamente a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            System.out.println("Error al enviar correo de recuperacion a " + destinatario + ": " + e.getMessage());
            if (DEBUG) {
                e.printStackTrace();
            }
            return false;
        } catch (Exception e) {
            System.out.println("Error inesperado al enviar correo de recuperacion a " + e.getMessage());
            if (DEBUG) {
                e.printStackTrace();
            }
            return false;
        }
    }

    /**
     * Enviar un correo electronico con las credenciales de registro
     *
     * @param destinatario Direccion de correo del destinatario
     * @param username Nombre de usuario general
     * @param passaword Contraseña generada
     * @return true si el envio fue existoso, false en caso contrario
     */
    public static boolean enviarCredencialesRegistro(String destinatario, String username, String password) {

        //Configurar propiedades del servidor SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        //Configuracion adicional para evitar errores de conexion
        props.put("mail.smtp.connectiontimeout", "5000");
        props.put("mail.smtp.timeout", "5000");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        try {
            //Crear sesion con autenticacion
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });

            //Activar depuracion si esta habilitada
            //El DEBUG sirve para comprobar errores 
            if (DEBUG) {
                session.setDebug(true);
                session.setDebugOut(new PrintStream(System.out));
                System.out.printf("Enviando correo de credenciales a: " + destinatario);
                System.out.printf("Usando correo remitente: " + USERNAME);
                System.out.printf("Usando contraseña de aplicacion: " + PASSWORD.replaceAll(".", "*"));
            }
            //Crar mensaje
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(USERNAME));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Credenciales de Acceso - Sistema de Roles");

            //Contenido del mensaje
            String contenido = "<html><body>"
                    + "<h2>Bienvenido al sistema de Roles</h2>"
                    + "<p>Estimado usuario,</p>"
                    + "<p>Su cuenta ha sido creado exitosamente. A continuacion, encontrara sus credenciales de acceso: </p>"
                    + "<p><strong>Usuario:</strong> " + username + "</p>"
                    + "<p><strong>Contraseña:</strong> " + password + "</p>"
                    + "<p>Saludos,<br>Equipo de Soporte</p>"
                    + "</body></html>";

            mensaje.setContent(contenido, "text/html; charset=utf-8");

            //Enviar mensaje
            Transport.send(mensaje);
            if (DEBUG) {
                System.out.println("Correo de recuperacion enviado exitosamente a: " + destinatario);
            }
            return true;
        } catch (MessagingException e) {
            System.out.println("Error al enviar correo de recuperacion a " + destinatario + ": " + e.getMessage());
            if (DEBUG) {
                e.printStackTrace();
            }
            return false;
        } catch (Exception e) {
            System.out.println("Error inesperado al enviar correo de recuperacion a " + e.getMessage());
            if (DEBUG) {
                e.printStackTrace();
            }
            return false;
        }
    }
    
    public static String generarPasswordTemporal(){
       String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
       StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {
            int index = (int) (Math.random() * caracteres.length());
            sb.append(caracteres.charAt(index));          
        }
        return sb.toString();
    }
    
    public static boolean probarConexion(String destinatario){
        try {
            System.out.println("Probando conexion de correo con: " + HOST + ":" + PORT);
            System.out.println("Centa remitente: " + USERNAME);
            
            return enviarCorreoRecuperacion(destinatario, "PRUEBA-CONEXION-" + System.currentTimeMillis());
        } catch (Exception e) {
            System.out.println("Error en prueba de conexion: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static String generalPasswordTemporal() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public static boolean enviarCorreoRecuperacion(String email, String username, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
