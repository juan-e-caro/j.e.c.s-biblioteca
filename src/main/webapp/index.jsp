<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Biblioteca Pública de Duitama - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* General page styling */
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

        .content {
            z-index: 1;
            flex: 1; /* Ensures content takes remaining space */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
        }

        .welcome-container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        .welcome-container h1 {
            color: #6f42c1;
            margin-bottom: 10px;
        }

        .welcome-container p {
            color: #4c3575;
            margin-bottom: 30px;
        }

        .btn-primary {
            background-color: #6f42c1;
            border-color: #6f42c1;
        }

        .btn-primary:hover {
            background-color: #5936a3;
            border-color: #5936a3;
        }

        .btn-outline-primary {
            color: #6f42c1;
            border-color: #6f42c1;
        }

        .btn-outline-primary:hover {
            background-color: #6f42c1;
            color: white;
        }

        .btn {
            width: 100%;
            margin-bottom: 10px;
        }

        footer {
            background-color: rgba(0, 0, 0, 0.1);
            padding: 10px;
            text-align: center;
            color: #f1f1f1;
            font-size: 0.9em;
            margin-top: auto; /* Empuja el footer hacia el fondo de la página */
        }

        .about-section {
            margin-top: 40px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            text-align: left;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            margin-bottom: 20px; /* Spacing between the section and footer */
        }

        .about-section h3 {
            color: #6f42c1;
            margin-bottom: 15px;
        }

        .about-section p {
            color: #4c3575;
            line-height: 1.6;
        }
    </style>
</head>
<body>

<div class="content">
    <!-- Main content with welcome message and buttons -->
    <div class="welcome-container">
        <h1>Biblioteca Pública de Duitama</h1>
        <p>Sistema de Préstamo de Libros</p>

        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
            Iniciar Sesión
        </a>
        <a href="${pageContext.request.contextPath}/registro.jsp" class="btn btn-outline-primary">
            Registrarse
        </a>
    </div>

    <!-- "Acerca de la Biblioteca" Section -->
    <div class="about-section">
        <h3>Acerca de la Biblioteca Pública de Duitama</h3>
        <p>La Biblioteca Pública de Duitama es un espacio dedicado al estudio, cultura, conocimiento y la comunidad.
        Nuestro objetivo es ofrecer acceso libre y equitativo al conocimiento y recursos ya sean educativos, literarios y
        tecnológicos para personas de todas las edades.</p>
    </div>
</div>

<!-- Footer at the bottom -->
<footer>
    &copy; 2025 Biblioteca Pública de Duitama
</footer>

</body>
</html>
