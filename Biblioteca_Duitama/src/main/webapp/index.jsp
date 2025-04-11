<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biblioteca Publica de Duitama - Sistema de Préstamo de Libros</title>
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <header>
            <h1>Biblioteca Publica de Duitama</h1>
            <p>Sistema de Préstamo de Libros</p>
        </header>
        
        <nav>
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="books/list.jsp">Libros</a></li>
                <li><a href="loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Bienvenido al Sistema de Préstamo de Instrumentos</h2>
            
            <div class="dashboard">
                <div>
                    <h3>Gestión de Libros</h3>
                    <p>Administre el inventario de libros en la biblioteca</p>
                    <a href="books/list.jsp" class="btn">Ver Libros</a>
                </div>
                
                <div>
                    <h3>Gestión de Préstamos</h3>
                    <p>Administre los Préstamos de libros de la biblioteca</p>
                    <a href="loans/list.jsp" class="btn">Ver Préstamos</a>
                </div>
            </div>
            
            <div class="about-section">
                <h3>Acerca de la Biblioteca Publica de Duitama</h3>
                <p>La Biblioteca Publica de Duitama es un espacio dedicado al estudio, cultura, conocimiento y la comunidad.
                nuestro objetivo es ofrecer acceso libre y equitativo al conocimiento y recursos ya sean educativos, literarios y
                tecnologicos para personas de todas las edades</p>
            </div>
        </div>
        
        <footer>
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
    </body>
</html>
