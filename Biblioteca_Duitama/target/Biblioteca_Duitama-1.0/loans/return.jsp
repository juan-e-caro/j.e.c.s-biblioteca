<%@page import="sena.adso.biblioteca_duitama.LoanBook"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biblioteca Publica de Duitama - Sistema de Préstamo de Libros</title>
        <link rel="stylesheet" href="../css/styles.css">
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
            <h2>Devolver Libro</h2>
            
            <%
                //obtener manager de libro
                BookManager manager = BookManager.getInstance();
                
                //obtener el id del prestamo
                int loanId= 0;
                try {
                    loanId = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    //Id invalido
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                //obtener el prestamo del manager
                LoanBook loan = manager.getLoanById(loanId);
                
                //revisar si el prestamo existe y si esta activo
                if (loan == null || !loan.isActive()) {
                    //prestamo no existe o ya ha sido retornado
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                // formateo fecha
                SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
                
                //revisar si un pedido fue hecho
                if (request.getMethod().equals("POST")) {
                    //regresar libro
                    boolean returned = manager.returnBook(loanId);
                    
                    if (returned) {
                        //libro devuelto exitosamente
                        response.sendRedirect("list.jsp");
                    } else {
            %>
                        <div class="alert alert-danger">
                            <p>No se pudo devolver el libro. Intentelo nuevamente.</p>
                        </div>
            <%
                    }
                    return;
                }
            %>

            <div class="loan-details">
                <h3>Detalles del Préstamo</h3>
                <p><strong>ID del Préstamo:</strong><%= loan.getId()  %></p>
                <p><strong>Libro:</strong><%= loan.getBook().getName() %> (<%= loan.getBook().getType() %>)</p>
                <p><strong>Usuario:</strong><%= loan.getBorrowerName() %> (<%= loan.getBorrowerId() %>)</p>
                <p><strong>Fecha de Préstamo:</strong><%= dateFormat.format(loan.getLoanDate()) %></p>
                <p><strong>Fecha de Devolución Programada:</strong><%= dateFormat.format(loan.getDueDate()) %></p>
                <p><strong>Estado:</strong><%= loan.isOverdue() ? "<span class='overdue'>Vencido</span>" : "Activo" %></p>
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
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/10/03/20250410033304-5MWH6OXO.js"></script>
    </body>
</html>
