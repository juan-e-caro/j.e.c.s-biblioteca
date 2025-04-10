<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sena.adso.sinfonica_nobsa.model.Loan"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Préstamos - Sinfónica de Nobsa</title>
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
            <h2>Gestión de Préstamos</h2>
            
            <div class="actions">
                <a href="add.jsp" class="btn">Crear Nuevo Préstamo</a>
            </div>
            
            <%
                
                InstrumentManager manager = InstrumentManager.getInstance();
                
                
                ArrayList<Loan> loans = manager.getAllLoans();
                
           
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                
                
                if (loans.isEmpty()) {
            %>
                <p>No hay préstamos registrados en el sistema.</p>
            <%
                } else {
            %>
                <h3>Préstamos Activos</h3>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Instrumento</th>
                            <th>Músico</th>
                            <th>Fecha de Préstamo</th>
                            <th>Fecha de Devolución</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            boolean hasActiveLoans = false;
                            for (Loan loan : loans) {
                                if (loan.isActive()) {
                                    hasActiveLoans = true;
                        %>
                            <tr>
                                <td><%= loan.getId() %></td>
                                <td><%= loan.getInstrument().getName() %></td>
                                <td><%= loan.getBorrowerName() %> (<%= loan.getBorrowerId() %>)</td>
                                <td><%= dateFormat.format(loan.getLoanDate()) %></td>
                                <td><%= dateFormat.format(loan.getDueDate()) %></td>
                                <td><%= loan.isOverdue() ? "<span class='overdue'>Vencido</span>" : "Activo" %></td>
                                <td>
                                    <a href="return.jsp?id=<%= loan.getId() %>" class="btn btn-success">Devolver</a>
                                    <a href="details.jsp?id=<%= loan.getId() %>" class="btn">Detalles</a>
                                </td>
                            </tr>
                        <% 
                                }
                            }
                            if (!hasActiveLoans) {
                        %>
                            <tr>
                                <td colspan="7">No hay préstamos activos en este momento.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <h3>Historial de Préstamos</h3>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Instrumento</th>
                            <th>Músico</th>
                            <th>Fecha de Préstamo</th>
                            <th>Fecha de Devolución</th>
                            <th>Fecha Real de Devolución</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            boolean hasHistoryLoans = false;
                            for (Loan loan : loans) {
                                if (!loan.isActive()) {
                                    hasHistoryLoans = true;
                        %>
                            <tr>
                                <td><%= loan.getId() %></td>
                                <td><%= loan.getInstrument().getName() %></td>
                                <td><%= loan.getBorrowerName() %> (<%= loan.getBorrowerId() %>)</td>
                                <td><%= dateFormat.format(loan.getLoanDate()) %></td>
                                <td><%= dateFormat.format(loan.getDueDate()) %></td>
                                <td><%= dateFormat.format(loan.getReturnDate()) %></td>
                                <td>
                                    <a href="details.jsp?id=<%= loan.getId() %>" class="btn">Detalles</a>
                                </td>
                            </tr>
                        <% 
                                }
                            }
                            if (!hasHistoryLoans) {
                        %>
                            <tr>
                                <td colspan="7">No hay historial de préstamos.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>
