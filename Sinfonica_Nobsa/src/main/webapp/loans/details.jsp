<%@page import="sena.adso.sinfonica_nobsa.model.PercussionInstrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.WindInstrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.StringInstrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.Instrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.Loan"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalles del Préstamo - Sinfónica de Nobsa</title>
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
            <h2>Detalles del Préstamo</h2>
            
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
                
                // Check if the loan exists
                if (loan == null) {
                    // Loan not found, redirect to list page
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                // Date formatter
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                
                // Get the instrument
                Instrument instrument = loan.getInstrument();
            %>
            
            <div class="loan-details">
                <h3>Información del Préstamo</h3>
                <p><strong>ID del Préstamo:</strong> <%= loan.getId() %></p>
                <p><strong>Fecha de Préstamo:</strong> <%= dateFormat.format(loan.getLoanDate()) %></p>
                <p><strong>Fecha de Devolución Programada:</strong> <%= dateFormat.format(loan.getDueDate()) %></p>
                <p><strong>Estado:</strong> 
                    <% if (loan.isActive()) { %>
                        <%= loan.isOverdue() ? "<span class='overdue'>Vencido</span>" : "Activo" %>
                    <% } else { %>
                        Devuelto el <%= dateFormat.format(loan.getReturnDate()) %>
                    <% } %>
                </p>
            </div>
            
            <div class="instrument-details">
                <h3>Información del Instrumento</h3>
                <p><strong>ID:</strong> <%= instrument.getId() %></p>
                <p><strong>Nombre:</strong> <%= instrument.getName() %></p>
                <p><strong>Tipo:</strong> <%= instrument.getType() %></p>
                <p><strong>Condición:</strong> <%= instrument.getCondition() %></p>
                <p><strong>Descripción:</strong> <%= instrument.getDescription() %></p>
                
                <% if (instrument instanceof StringInstrument) { %>
                    <% StringInstrument stringInstrument = (StringInstrument) instrument; %>
                    <p><strong>Número de Cuerdas:</strong> <%= stringInstrument.getNumberOfStrings() %></p>
                    <p><strong>Tipo de Cuerdas:</strong> <%= stringInstrument.getStringType() %></p>
                <% } else if (instrument instanceof WindInstrument) { %>
                    <% WindInstrument windInstrument = (WindInstrument) instrument; %>
                    <p><strong>Material:</strong> <%= windInstrument.getMaterial() %></p>
                    <p><strong>Tipo de Boquilla:</strong> <%= windInstrument.getMouthpieceType() %></p>
                <% } else if (instrument instanceof PercussionInstrument) { %>
                    <% PercussionInstrument percussionInstrument = (PercussionInstrument) instrument; %>
                    <p><strong>Material:</strong> <%= percussionInstrument.getMaterial() %></p>
                    <p><strong>Afinable:</strong> <%= percussionInstrument.isTunable() ? "Sí" : "No" %></p>
                <% } %>
            </div>
            
            <div class="borrower-details">
                <h3>Información del Músico</h3>
                <p><strong>Nombre:</strong> <%= loan.getBorrowerName() %></p>
                <p><strong>ID:</strong> <%= loan.getBorrowerId() %></p>
            </div>
            
            <div class="actions">
                <% if (loan.isActive()) { %>
                    <a href="return.jsp?id=<%= loan.getId() %>" class="btn btn-success">Devolver Instrumento</a>
                <% } %>
                <a href="list.jsp" class="btn">Volver a la Lista</a>
            </div>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>
