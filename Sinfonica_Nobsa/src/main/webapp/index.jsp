<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</title>
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <header>
            <h1>Sinfónica de Nobsa</h1>
            <p>Sistema de Préstamo de Instrumentos</p>
        </header>
        
        <nav>
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="instruments/list.jsp">Instrumentos</a></li>
                <li><a href="loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Bienvenido al Sistema de Préstamo de Instrumentos</h2>
            
            <div class="dashboard">
                <div class="dashboard-item">
                    <h3>Gestión de Instrumentos</h3>
                    <p>Administre el inventario de instrumentos musicales de la sinfónica.</p>
                    <a href="instruments/list.jsp" class="btn">Ver Instrumentos</a>
                </div>
                
                <div class="dashboard-item">
                    <h3>Gestión de Préstamos</h3>
                    <p>Administre los préstamos de instrumentos a los músicos.</p>
                    <a href="loans/list.jsp" class="btn">Ver Préstamos</a>
                </div>
            </div>
            
            <div class="about-section">
                <h3>Acerca de la Sinfónica de Nobsa</h3>
                <p>La Sinfónica de Nobsa es una organización dedicada a la promoción de la música y la cultura en la región. 
                   Contamos con una amplia variedad de instrumentos disponibles para préstamo a nuestros músicos.</p>
            </div>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>