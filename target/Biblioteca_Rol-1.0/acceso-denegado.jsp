<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso Denegado - Sistema de Roles</title>
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
        .error-container {
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .error-icon {
            font-size: 80px;
            color: #6f42c1; /* Morado para el icono */
            margin-bottom: 20px;
        }
        .error-title {
            font-size: 28px;
            color: #6f42c1; /* Morado para el título */
            margin-bottom: 15px;
        }
        .error-message {
            font-size: 18px;
            margin-bottom: 30px;
            color: #6c757d;
        }
        .btn-back {
            padding: 10px 25px;
            font-weight: 600;
            background-color: #6f42c1; /* Morado para el botón */
            color: white;
            border: none;
        }
        .btn-back:hover {
            background-color: #5a2d94; /* Morado más oscuro en hover */
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
        <div class="error-container">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h1 class="error-title">Acceso Denegado</h1>
            <p class="error-message">Lo sentimos, no tiene permisos para acceder a esta página.</p>
            
            <c:if test="${not empty sessionScope.usuario}">
                <c:choose>
                    <c:when test="${sessionScope.usuario.rol eq 'Instructor'}">
                        <a href="${pageContext.request.contextPath}/instructor/aprendices" class="btn btn-back">
                            <i class="fas fa-home"></i> Ir al Panel de Instructor
                        </a>
                    </c:when>
                    <c:when test="${sessionScope.usuario.rol eq 'Aprendiz'}">
                        <a href="${pageContext.request.contextPath}/aprendiz/aprendices" class="btn btn-back">
                            <i class="fas fa-home"></i> Ir al Panel de Aprendiz
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-back">
                            <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:if>
            
            <c:if test="${empty sessionScope.usuario}">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-back">
                    <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                </a>
            </c:if>
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

