
<%@page import="sena.adso.sinfonica_nobsa.model.Loan"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Devolver Instrumento - Sinfónica de Nobsa</title>
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
                <li><a href="../instruments/list.jsp">Instrumentos</a></li>
                <li><a href="list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Devolver Instrumento</h2>
            
            <%
                // Get the instrument manager instance
                InstrumentManager manager = InstrumentManager.getInstance();
                
                // Get the loan ID from the request
                int loanId = 0;
                try {
                    loanId = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    // Invalid ID, redirect to list page
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                // Get the loan from the manager
                Loan loan = manager.getLoanById(loanId);
                
                // Check if the loan exists and is active
                if (loan == null || !loan.isActive()) {
                    // Loan not found or already returned, redirect to list page
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                // Date formatter
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                
                // Check if form was submitted (confirmation)
                if (request.getMethod().equals("POST")) {
                    // Return the instrument
                    boolean returned = manager.returnInstrument(loanId);
                    
                    if (returned) {
                        // Instrument returned successfully, redirect to list page
                        response.sendRedirect("list.jsp");
                    } else {
                        // Instrument could not be returned (shouldn't happen)
            %>
                        <div class="alert alert-danger">
                            <p>No se pudo devolver el instrumento. Por favor, intente nuevamente.</p>
                        </div>
            <%
                    }
                    return;
                }
            %>
            
            <div class="loan-details">
                <h3>Detalles del Préstamo</h3>
                <p><strong>ID del Préstamo:</strong> <%= loan.getId() %></p>
                <p><strong>Instrumento:</strong> <%= loan.getInstrument().getName() %> (<%= loan.getInstrument().getType() %>)</p>
                <p><strong>Músico:</strong> <%= loan.getBorrowerName() %> (<%= loan.getBorrowerId() %>)</p>
                <p><strong>Fecha de Préstamo:</strong> <%= dateFormat.format(loan.getLoanDate()) %></p>
                <p><strong>Fecha de Devolución Programada:</strong> <%= dateFormat.format(loan.getDueDate()) %></p>
                <p><strong>Estado:</strong> <%= loan.isOverdue() ? "<span class='overdue'>Vencido</span>" : "Activo" %></p>
            </div>
            
            <form method="post" action="return.jsp?id=<%= loan.getId() %>">
                <div class="form-group">
                    <p>¿Está seguro que desea registrar la devolución de este instrumento?</p>
                    <p>Fecha de Devolución: <%= dateFormat.format(new Date()) %></p>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-success">Confirmar Devolución</button>
                    <a href="list.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>