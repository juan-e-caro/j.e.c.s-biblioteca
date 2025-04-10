<%@page import="sena.adso.sinfonica_nobsa.model.Instrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Instrumento - Sinfónica de Nobsa</title>
        <link rel="stylesheet" href="../css/styles.css">
    </head>
    <body>
        <header>
            <h1>Sinfónica de Nobsa</h1>
            <p>Sistema de Préstamo de Instrumentos</p>
        </header>
        
        <nav>
            <ul>
                <li><a href="../index.jsp">Inicio</a></li>
                <li><a href="list.jsp">Instrumentos</a></li>
                <li><a href="../loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Eliminar Instrumento</h2>
            
            <%
                // Get the instrument manager instance
                InstrumentManager manager = InstrumentManager.getInstance();
                
                // Get the instrument ID from the request
                int instrumentId = 0;
                try {
                    instrumentId = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    // Invalid ID, redirect to list page
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                // Get the instrument from the manager
                Instrument instrument = manager.getInstrumentById(instrumentId);
                
                // Check if the instrument exists
                if (instrument == null) {
                    // Instrument not found, redirect to list page
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                // Check if form was submitted (confirmation)
                if (request.getMethod().equals("POST")) {
                    // Try to delete the instrument
                    boolean deleted = manager.deleteInstrument(instrumentId);
                    
                    if (deleted) {
                        // Instrument deleted successfully, redirect to list page
                        response.sendRedirect("list.jsp");
                    } else {
                        // Instrument could not be deleted (probably because it's on loan)
            %>
                        <div class="alert alert-danger">
                            <p>No se puede eliminar el instrumento porque está actualmente en préstamo.</p>
                        </div>
                        <p><a href="list.jsp" class="btn">Volver a la lista</a></p>
            <%
                    }
                    return;
                }
            %>
            
            <div class="alert alert-danger">
                <p>¿Está seguro que desea eliminar el siguiente instrumento?</p>
                <p><strong>ID:</strong> <%= instrument.getId() %></p>
                <p><strong>Nombre:</strong> <%= instrument.getName() %></p>
                <p><strong>Tipo:</strong> <%= instrument.getType() %></p>
                <p><strong>Condición:</strong> <%= instrument.getCondition() %></p>
                <p><strong>Descripción:</strong> <%= instrument.getDescription() %></p>
            </div>
            
            <form method="post" action="delete.jsp?id=<%= instrument.getId() %>">
                <div class="form-group">
                    <button type="submit" class="btn btn-danger">Confirmar Eliminación</button>
                    <a href="list.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>