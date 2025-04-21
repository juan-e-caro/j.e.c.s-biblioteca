<%@page import="sena.adso.biblioteca_duitama.LoanBook"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biblioteca Publica de Duitama - Sistema de Préstamo de Libros</title>
        <link rel="stylesheet" href="../css/styles.css">
        <!-- Agregar CSS de DataTables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <!-- Agregar jQuery y JS de DataTables -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    </head>
    <body>
        <header>
            <h1>Biblioteca Publica de Duitama</h1>
            <p>Sistema de Préstamo de Libros</p>
        </header>
        
        <nav>
            <ul>
                <li><a href="../index.jsp">Inicio</a></li>
                <li><a href="../books/list.jsp">Libros</a></li>
                <li><a href="list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Gestión de Préstamos</h2>
            
            <div class="actions">
                <a href="add.jsp" class="btn">Crear Nuevo Préstamo</a>
            </div>
            
            <%
                // Obtener la lista de préstamos
                BookManager manager = BookManager.getInstance();
                ArrayList<LoanBook> loans = manager.getAllLoans();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                // Verificar si hay préstamos activos
                boolean hasActiveLoans = false;
                for (LoanBook loan : loans) {
                    if (loan.isActive()) {
                        hasActiveLoans = true;
                        break;
                    }
                }

                // Verificar si hay historial de préstamos
                boolean hasHistoryLoans = false;
                for (LoanBook loan : loans) {
                    if (!loan.isActive()) {
                        hasHistoryLoans = true;
                        break;
                    }
                }
            %>

            <h3>Préstamos Activos</h3>
            <% if (hasActiveLoans) { %>
                <table id="activeLoansTable" class="display">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Libro</th>
                            <th>Usuario</th>
                            <th>Fecha de Préstamo</th>
                            <th>Fecha de Devolución</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (LoanBook loan : loans) {
                                if (loan.isActive()) {
                        %>
                            <tr>
                                <td><%= loan.getId() %></td>
                                <td><%= loan.getBook().getName() %></td>
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
                        %>
                    </tbody>
                </table>
            <% } else { %>
                <p>No hay préstamos activos en este momento.</p>
            <% } %>

            <h3>Historial de Préstamos</h3>
            <% if (hasHistoryLoans) { %>
                <table id="historyLoansTable" class="display">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Libro</th>
                            <th>Usuario</th>
                            <th>Fecha de Préstamo</th>
                            <th>Fecha de Devolución</th>
                            <th>Fecha Real de Devolución</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (LoanBook loan : loans) {
                                if (!loan.isActive()) {
                        %>
                            <tr>
                                <td><%= loan.getId() %></td>
                                <td><%= loan.getBook().getName() %></td>
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
                        %>
                    </tbody>
                </table>
            <% } else { %>
                <p>No hay historial de préstamos.</p>
            <% } %>
        </div>
        
        <footer>
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>

        <script>
            $(document).ready(function() {
                // Inicializar DataTables solo si las tablas existen
                if ($('#activeLoansTable').length) {
                    $('#activeLoansTable').DataTable();
                }
                if ($('#historyLoansTable').length) {
                    $('#historyLoansTable').DataTable();
                }
            });
        </script>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/10/03/20250410033304-5MWH6OXO.js"></script>
    </body>
</html>
