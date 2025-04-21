<%@page import="sena.adso.biblioteca_duitama.Book"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Biblioteca Publica de Duitama - Sistema de Préstamo de Libros</title>
        <link rel="stylesheet" href="../css/styles.css">
        <!-- Incluir CSS de DataTables -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
        
        <!-- Incluir jQuery (requerido por DataTables) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <!-- Incluir JS de DataTables -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        
        <script>
            $(document).ready(function() {
                // Inicializar DataTable
                $('table').DataTable();
            });
        </script>
    </head>
    <body>
        <header>
            <h1>Biblioteca Publica de Duitama</h1>
            <p>Sistema de Préstamo de Libros</p>
        </header>
        
        <nav>
            <ul>
                <li><a href="../index.jsp">Inicio</a></li>
                <li><a href="list.jsp">Libros</a></li>
                <li><a href="../loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Gestion de Libros</h2>
            
            <div class="actions">
                <a href="add.jsp" class="btn">Agregar nuevo Libro</a>
            </div>
            
            <%
                BookManager manager = BookManager.getInstance();
                ArrayList<Book> books = manager.getAllBooks();
                
                if (books.isEmpty()) {
            %>
                <p>No hay Libros Registrados en el sistema</p>
            <%
                } else {
            %>
                <table id="booksTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Tipo</th>
                            <th>Condición</th>
                            <th>Disponible</th>
                            <th>Detalles</th>
                            <th>Acciones</th> 
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Book book : books) {%>
                            <tr>
                                <td><%= book.getId()%></td>
                                <td><%= book.getName()%></td>
                                <td><%= book.getType()%></td>
                                <td><%= book.getCondition()%></td>
                                <td><%= book.isAvailable()%></td>
                                <td><%= book.getDescription()%></td>
                                <td>
                                    <a href="edit.jsp?id=<%= book.getId()%>" class="btn">Editar</a>
                                    <a href="delete.jsp?id=<%= book.getId()%>" class="btn btn-danger">Eliminar</a>
                                    <% if(book.isAvailable()) {%>
                                        <a href="../loans/add.jsp?bookId=<%= book.getId()%>" class="btn btn-success">Prestar</a>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
        
        <footer>
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
        <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
        <script src="https://files.bpcontent.cloud/2025/04/10/03/20250410033304-5MWH6OXO.js"></script>
    </body>
</html>
