<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Recuperar Contraseña - Sistema de Roles</title>

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
            min-height: 100vh;
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        .recovery-container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        .recovery-icon {
            font-size: 60px;
            color: #6f42c1; /* Morado */
            margin-bottom: 15px;
        }

        .recovery-title {
            font-size: 24px;
            color: #6f42c1; /* Morado */
            margin-bottom: 10px;
        }

        .recovery-message {
            font-size: 16px;
            color: #6c757d;
            margin-bottom: 25px;
        }

        .form-floating {
            margin-bottom: 20px;
            text-align: left;
        }

        .btn-recovery {
            width: 100%;
            padding: 12px;
            font-weight: 600;
            background-color: #6f42c1;
            border-color: #6f42c1;
        }

        .btn-recovery:hover {
            background-color: #5936a2;
            border-color: #5936a2;
        }

        .back-to-login {
            margin-top: 20px;
        }

        footer {
            background-color: rgba(0, 0, 0, 0.1);
            padding: 10px;
            text-align: center;
            color: #f1f1f1;
            font-size: 0.9em;
        }
    </style>

</head>
<body>

<div class="content">
    <div class="recovery-container">
        <div class="recovery-icon">
            <i class="fas fa-key"></i>
        </div>
        <h1 class="recovery-title">Recuperar Contraseña</h1>
        <p class="recovery-message">Ingrese su correo electrónico para recibir instrucciones de restablecimiento</p>

        <c:if test="${not empty mensaje}">
            <div class="alert alert-${tipo == null ? 'info' : tipo} alert-dismissible fade show" role="alert">
                ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/recuperar-password" method="post">
            <div class="form-floating">
                <input type="email" class="form-control" id="email" name="email" placeholder="Correo electrónico" required>
                <label for="email">Correo electrónico</label>
            </div>
            <button type="submit" class="btn btn-primary btn-recovery">
                <i class="fas fa-paper-plane me-2"></i>Enviar Instrucciones
            </button>
        </form>

        <div class="back-to-login">
            <a href="${pageContext.request.contextPath}/login.jsp" class="text-decoration-none">
                <i class="fas fa-arrow-left me-1"></i>Volver al inicio de sesión
            </a>
        </div>
    </div>
</div>

<footer>
    &copy; 2025 Biblioteca Pública de Duitama
</footer>

<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
