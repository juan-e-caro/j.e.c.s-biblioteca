<%@page import="sena.adso.biblioteca_duitama.Book"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de Libros - Biblioteca</title>
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

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #6f42c1;
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
        <p>Listado de Libros Disponibles</p>
    </header>

    <div class="container">
        <h2>Catálogo de Libros</h2>

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
