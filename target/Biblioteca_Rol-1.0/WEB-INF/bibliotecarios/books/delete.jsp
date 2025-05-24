<%@page import="sena.adso.biblioteca_duitama.Book"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Libro - Biblioteca Duitama</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f6f0fa;
            margin: 0;
            padding: 0;
        }

        header, footer {
            background-color: #5f259f;
            color: white;
            padding: 1rem;
            text-align: center;
        }

        nav {
            background-color: #b392d3;
            padding: 0.5rem;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 1rem;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            background-color: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 0 10px #ccc;
        }

        h2 {
            color: #5f259f;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .form-group {
            margin-top: 1rem;
        }

        .btn {
            background-color: #7b3ec8;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            margin-right: 0.5rem;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn:hover {
            background-color: #5f259f;
        }
    </style>
</head>
<body>
    <header>
        <h1>Biblioteca Pública de Duitama</h1>
        <p>Sistema de Préstamo de Libros</p>
    </header>

    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li><a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/list.jsp">Libros</a></li>
            <li><a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/loans/list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Eliminar Libro</h2>

        <%
            BookManager manager = BookManager.getInstance();
            int bookId = 0;
            try {
                bookId = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                response.sendRedirect("list.jsp");
                return;
            }

            Book book = manager.getBookById(bookId);

            if (book == null) {
                response.sendRedirect("list.jsp");
                return;
            }

            if (request.getMethod().equals("POST")) {
                boolean deleted = manager.deleteBook(bookId);

                if (deleted) {
                    response.sendRedirect("list.jsp");
                    return;
                } else {
        %>
        <div class="alert alert-danger">
            <p>No se puede eliminar el libro actualmente. Puede estar en préstamo.</p>
        </div>
        <p><a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/list.jsp" class="btn">Volver a la lista</a></p>
        <%  return; } } %>

        <div class="alert alert-danger">
            <p>¿Está seguro de que desea eliminar el siguiente libro?</p>
            <p><strong>ID:</strong> <%= book.getId() %></p>
            <p><strong>Nombre:</strong> <%= book.getName() %></p>
            <p><strong>Tipo:</strong> <%= book.getType() %></p>
            <p><strong>Condición:</strong> <%= book.getCondition() %></p>
            <p><strong>Descripción:</strong> <%= book.getDescription() %></p>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/delete.jsp?id=<%= book.getId() %>">
            <div class="form-group">
                <button type="submit" class="btn btn-danger">Confirmar Eliminación</button>
                <a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/list.jsp" class="btn">Cancelar</a>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2025 Biblioteca Pública de Duitama - Sistema de Préstamo de Libros</p>
    </footer>
</body>
</html>
