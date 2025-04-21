<%@page import="sena.adso.biblioteca_duitama.ReferenceBook"%>
<%@page import="sena.adso.biblioteca_duitama.NonFictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.FictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.Book"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="sena.adso.biblioteca_duitama.LoanBook"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <h2>Detalles del Prestamo</h2>
            
            <%
                //obtener intancia libros
                BookManager manager = BookManager.getInstance();
                
                //obtener ID del prestame
                int loanId = 0;
                try {
                     loanId = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    //Id invalido
                    response.sendRedirect("list.jsp");
                    return;
                }
                    
                //obtener el prestamo del manager
                LoanBook loan = manager.getLoanById(loanId);
                
                //comprobar si el prestamo existe
                if (loan == null) {
                    //no se encontro el prestamo
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                //formatear fecha
                SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
                
                // obtener el libro
                Book book = loan.getBook();
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
                <h3>Información del Libro</h3>  
                <p><strong>Id:</strong><%= book.getId() %></p>
                <p><strong>Nombre:</strong><%= book.getName()  %></p>
                <p><strong>Tipo:</strong><%= book.getType() %></p>
                <p><strong>Condición:</strong><%= book.getCondition()  %></p>
                <p><strong>Descrición:</strong><%= book.getDescription() %></p>
                
                <% if (book instanceof FictionBook) {%>
                    <% FictionBook fictionBook = (FictionBook) book; %>
                    <p><strong>Genero:</strong><%= fictionBook.getGender() %></p>
                    <p><strong>Autor:</strong><%= fictionBook.getAutor() %></p>
                    <p><strong>Premios Literarios:</strong><%= fictionBook.isLiteraryAwards() %></p>
                <% } else if (book instanceof NonFictionBook) {%>
                    <% NonFictionBook nonFictionBook = (NonFictionBook) book;%>
                    <p><strong>Área Tematica:</strong><%= nonFictionBook.getTheme() %></p>
                    <p><strong>Publico Objetivo:</strong><%= nonFictionBook.getObjectivePublic() %></p>
                <% } else if (book instanceof ReferenceBook) {%>
                    <% ReferenceBook referenceBook = (ReferenceBook) book;%>
                    <p><strong>Área Academica:</strong><%= referenceBook.getAcademicArea() %></p>
                    <p><strong>Prestamo:</strong><%= referenceBook.isBorrowed() %></p>
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
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/10/03/20250410033304-5MWH6OXO.js"></script>
    </body>
</html>
