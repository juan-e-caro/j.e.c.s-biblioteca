<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Iniciar Sesión - Sistema de Roles</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            background: url('${pageContext.request.contextPath}/img/fondo_biblioteca.jpg') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensures the page takes at least full height */
        }
        .login-container {
            max-width: 450px;
            margin: 100px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h2 {
            color: #6f42c1;
        }
        .form-floating {
            margin-bottom: 20px;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            font-weight: 600;
            background-color: #6f42c1; /* Color morado */
            border: none;
        }
        .btn-login:hover {
            background-color: #5936a3;
        }
        .forgot-password {
            text-align: center;
            margin-top: 20px;
        }
        .forgot-password a {
            color: #6f42c1;
        }
        .forgot-password a:hover {
            color: #5936a3;
        }
        .alert {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
            margin-bottom: 20px;
        }
        footer {
            background-color: rgba(0, 0, 0, 0.1);
            padding: 10px;
            text-align: center;
            color: #f1f1f1;
            font-size: 0.9em;
            margin-top: auto; /* Empuja el footer hacia el fondo de la página */
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <h2><i class="fas fa-users"></i> INICIAR SESIÓN </h2>
                <p class="text-muted">Inicie sesión para acceder al sistema</p>
            </div>
            
            <c:if test="${not empty mensaje}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-floating">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Usuario" required>
                    <label for="username">Usuario</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
                    <label for="password">Contraseña</label>
                </div>
                <button type="submit" class="btn btn-primary btn-login">
                    <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                </button>
            </form>
            
            <div class="forgot-password">
                <a href="${pageContext.request.contextPath}/recuperar-password.jsp
                   ">
                    ¿Olvidó su contraseña?
                </a>
                <p class="mt-2">¿No tiene una cuenta? <a href="${pageContext.request.contextPath}/registro.jsp">Regístrese aquí</a></p>
            </div>
        </div>
    </div>

    <!-- Footer at the bottom -->
    <footer>
        &copy; 2025 Biblioteca Pública de Duitama
    </footer>

    
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
