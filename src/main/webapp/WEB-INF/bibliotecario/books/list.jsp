<%@page import="sena.adso.biblioteca_duitama.Book"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Libros - Biblioteca</title>
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#booksTable').DataTable();
        });
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f0fb;
            color: #333;
            padding: 20px;
        }

        header {
            background-color: #6f42c1;
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        nav ul li a {
            text-decoration: none;
            color: #6f42c1;
            font-weight: bold;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #6f42c1;
        }

        .btn {
            background-color: #6f42c1;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            margin-right: 5px;
            display: inline-block;
        }

        .btn:hover {
            background-color: #59359d;
        }

        .btn-danger {
            background-color: #dc3545;
        }

        .btn-success {
            background-color: #28a745;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #6f42c1;
            color: white;
        }

        footer {
            margin-top: 40px;
            text-align: center;
            color: #777;
        }
    </style>
</head>
<body>
    <header>
        <h1>Biblioteca Pública de Duitama</h1>
        <p>Gestión de Libros</p>
    </header>

    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li><a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/list.jsp">Libros</a></li>
            <li><a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/loans/list.jsp">Préstamos</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Lista de Libros</h2>
        <div class="actions">
            <a href="add.jsp" class="btn">Agregar Nuevo Libro</a>
        </div>

        <%
            BookManager manager = BookManager.getInstance();
            ArrayList<Book> books = manager.getAllBooks();

            if (books.isEmpty()) {
        %>
            <p>No hay libros registrados en el sistema.</p>
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
                        <th>Descripción</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Book book : books) { %>
                        <tr>
                            <td><%= book.getId() %></td>
                            <td><%= book.getName() %></td>
                            <td><%= book.getType() %></td>
                            <td><%= book.getCondition() %></td>
                            <td><%= book.isAvailable() ? "Sí" : "No" %></td>
                            <td><%= book.getDescription() %></td>
                            <td>
                                <a href="edit.jsp?id=<%= book.getId() %>" class="btn">Editar</a>
                                <a href="delete.jsp?id=<%= book.getId() %>" class="btn btn-danger">Eliminar</a>
                                <% if (book.isAvailable()) { %>
                                    <a href="../loans/add.jsp?bookId=<%= book.getId() %>" class="btn btn-success">Prestar</a>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <%
            }
        %>
    </div>

    <footer>
        &copy; 2025 Biblioteca Pública de Duitama
    </footer>
</body>
</html>
