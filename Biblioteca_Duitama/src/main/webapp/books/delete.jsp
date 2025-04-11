<%@page import="sena.adso.biblioteca_duitama.Book"%>
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
                <li><a href="list.jsp">Libros</a></li>
                <li><a href="../loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Eliminar Libros</h2>
            
            <%
                //obtener el manager de libros
                BookManager manager = BookManager.getInstance();
            
                //obtener los id de un pedido
                int bookId = 0;
                try {
                    bookId = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                    //id invalido, redireccion a pagina principal
                    response.sendRedirect("list.jsp");
                    return;
                }
                
                //obtener el libro del manager
                Book book = manager.getBookById(bookId);
                
                //revisar si el libro existe
                if (book == null) {
                        //libro no encontrado, redireccion
                        response.sendRedirect("list.jsp");
                        return;
                }
                
                //verificar si la forma fue suministrada(confirmacion)
                if (request.getMethod().equals("POST")) {
                    //intenta borrar el libro
                    boolean deleted = manager.deleteBook(bookId);

                    if (deleted) {
                            response.sendRedirect("list.jsp");
                    } else {
                        //no se puede eliminar porque esta prestado
            %>
                        <div class="alert alert-danger">
                            <p>no se puede eliminar el libro actualmente, puede estar en préstamo.</p>
                        </div>
                        <p><a href="list.jsp" class="btn">Volver a la lista</a></p>
            <%
                    }
                    return;
                }
            %>
            <div class="alert alert-danger">
                <p>¿está seguro de que desea elinimar el siguiente libro?</p>
                <p><strong>ID:</strong> <%= book.getId() %></p>
                <p><strong>Nombre:</strong> <%= book.getName() %></p>
                <p><strong>Tipo:</strong> <%= book.getType() %></p>
                <p><strong>Condición:</strong> <%= book.getCondition() %></p>
                <p><strong>Descripción:</strong> <%= book.getDescription() %></p>
            </div>
            
            <form method="post" action="delete.jsp?id=<%= book.getId() %>">
                <div class="form-group">
                    <button type="submit" class="btn btn-danger">confirmar Eliminación</button>
                    <a href="list.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>
        
        <footer>
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
    </body>
</html>
