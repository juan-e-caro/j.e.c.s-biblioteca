<%@page import="java.util.ArrayList"%>
<%@page import="sena.adso.sinfonica_nobsa.model.Instrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.Loan"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear Préstamo - Sinfónica de Nobsa</title>
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
            <h2>Crear Nuevo Préstamo</h2>
            
            <%
                // Get the instrument manager instance
                InstrumentManager manager = InstrumentManager.getInstance();
                
                // Check if form was submitted
                if (request.getMethod().equals("POST")) {
                    // Get form data
                    int instrumentId = Integer.parseInt(request.getParameter("instrumentId"));
                    String borrowerName = request.getParameter("borrowerName");
                    String borrowerId = request.getParameter("borrowerId");
                    int loanDays = Integer.parseInt(request.getParameter("loanDays"));
                    
                    // Create the loan
                    Loan loan = manager.createLoan(instrumentId, borrowerName, borrowerId, loanDays);
                    
                    if (loan != null) {
                        // Loan created successfully, redirect to list page
                        response.sendRedirect("list.jsp");
                    } else {
                        // Loan creation failed (instrument not available)
            %>
                        <div class="alert alert-danger">
                            <p>No se pudo crear el préstamo. El instrumento no está disponible.</p>
                        </div>
            <%
                    }
                    return;
                }
                
                // Get available instruments
                ArrayList<Instrument> availableInstruments = manager.getAvailableInstruments();
                
                // Check if there are any available instruments
                if (availableInstruments.isEmpty()) {
            %>
                <div class="alert alert-danger">
                    <p>No hay instrumentos disponibles para préstamo en este momento.</p>
                </div>
                <p><a href="list.jsp" class="btn">Volver a la lista de préstamos</a></p>
            <%
                } else {
                    // Check if an instrument ID was provided in the request (from the instruments list)
                    String instrumentIdParam = request.getParameter("instrumentId");
                    int selectedInstrumentId = 0;
                    
                    if (instrumentIdParam != null && !instrumentIdParam.isEmpty()) {
                        try {
                            selectedInstrumentId = Integer.parseInt(instrumentIdParam);
                        } catch (NumberFormatException e) {
                            // Invalid ID, ignore
                        }
                    }
            %>
                <form method="post" action="add.jsp">
                    <div class="form-group">
                        <label for="instrumentId">Instrumento:</label>
                        <select id="instrumentId" name="instrumentId" required>
                            <option value="">Seleccione un instrumento</option>
                            <% for (Instrument instrument : availableInstruments) { %>
                                <option value="<%= instrument.getId() %>" <%= (instrument.getId() == selectedInstrumentId) ? "selected" : "" %>>
                                    <%= instrument.getName() %> (<%= instrument.getType() %>, <%= instrument.getCondition() %>)
                                </option>
                            <% } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="borrowerName">Nombre del Músico:</label>
                        <input type="text" id="borrowerName" name="borrowerName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="borrowerId">ID del Músico:</label>
                        <input type="text" id="borrowerId" name="borrowerId" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="loanDays">Días de Préstamo:</label>
                        <input type="number" id="loanDays" name="loanDays" min="1" max="30" value="7" required>
                        <small>Número de días que el instrumento estará prestado (máximo 30 días).</small>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn">Crear Préstamo</button>
                        <a href="list.jsp" class="btn">Cancelar</a>
                    </div>
                </form>
            <% } %>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>