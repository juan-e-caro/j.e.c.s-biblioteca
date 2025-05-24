<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registro de Usuario - Sistema de Roles</title>
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
        .registro-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .registro-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .registro-header h2 {
            color: #6f42c1;
        }
        .form-floating {
            margin-bottom: 20px;
        }
        .btn-registro {
            width: 100%;
            padding: 12px;
            font-weight: 600;
            background-color: #6f42c1;
            border: none;
        }
        .btn-registro:hover {
            background-color: #5936a3;
        }
        .back-to-login {
            text-align: center;
            margin-top: 20px;
        }
        .back-to-login a {
            color: #6f42c1;
        }
        .back-to-login a:hover {
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
        <div class="registro-container">
            <div class="registro-header">
                <h2><i class="fas fa-user-plus"></i> Registro de Usuario</h2>
                <p class="text-muted">Complete el formulario para crear una cuenta</p>
            </div>
            
            <c:if test="${not empty mensaje}">
                <div class="alert alert-${tipo == null ? 'info' : tipo} alert-dismissible fade show" role="alert">
                    ${mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/registro" method="post">
                <div class="form-floating">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Nombre de usuario" required>
                    <label for="username">Nombre de usuario</label>
                </div>
                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Correo electrónico" required>
                    <label for="email">Correo electrónico</label>
                </div>
                <div class="form-floating">
                    <select class="form-select" id="rol" name="rol" required>
                        <option value="" selected disabled>Seleccione un rol</option>
                        <option value="Bibliotecario">Bibliotecario</option>
                        <option value="Lector">Lector</option>
                    </select>
                    <label for="rol">Rol</label>
                </div>
                <button type="submit" class="btn btn-primary btn-registro">
                    <i class="fas fa-user-plus"></i> Registrarse
                </button>
            </form>
            
            <div class="back-to-login">
                <a href="${pageContext.request.contextPath}/login.jsp">
                    <i class="fas fa-arrow-left"></i> Volver al inicio de sesión
                </a>
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
