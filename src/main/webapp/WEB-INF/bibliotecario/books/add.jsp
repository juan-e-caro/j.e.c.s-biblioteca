<%@page import="sena.adso.biblioteca_duitama.FictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.NonFictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.ReferenceBook"%>
<%@page import="sena.adso.biblioteca_duitama.Book"%>
<%@page import="sena.adso.biblioteca_duitama.BookManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Libro - Biblioteca Duitama</title>
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

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 0.3rem;
        }

        input[type="text"], select {
            width: 100%;
            padding: 0.4rem;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            background-color: #7b3ec8;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #5f259f;
        }
    </style>
</head>
<body>
    <header>
        <h1>Biblioteca Publica de Duitama</h1>
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
        <h2>Agregar Nuevo Libro</h2>
        <%
            if (request.getMethod().equals("POST")) {
                BookManager manager = BookManager.getInstance();
                String name = request.getParameter("name");
                String type = request.getParameter("type");
                String condition = request.getParameter("condition");

                Book newBook = null;
                int id = manager.getNextBookId();

                if ("Fiction".equals(type)) {
                    String gender = request.getParameter("gender");
                    String autor = request.getParameter("autor");
                    boolean literaryAwards = request.getParameter("literaryAwards") != null;
                    newBook = new FictionBook(id, name, type, condition, gender, autor, literaryAwards);
                } else if ("NonFiction".equals(type)) {
                    String theme = request.getParameter("theme");
                    String objectivePublic = request.getParameter("objectivePublic");
                    newBook = new NonFictionBook(id, name, type, condition, theme, objectivePublic);
                } else if ("Reference".equals(type)) {
                    String academicArea = request.getParameter("academicArea");
                    boolean borrowed = request.getParameter("borrowed") != null;
                    newBook = new ReferenceBook(id, name, type, condition, academicArea, borrowed);
                }

                if (newBook != null) {
                    manager.addBook(newBook);
                    response.sendRedirect("list.jsp");
                    return;
                }
            }
        %>
        <form method="post" action="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/add.jsp">
            <div class="form-group">
                <label for="name">Nombre:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="type">Tipo:</label>
                <select id="type" name="type" onchange="showTypeFields()" required>
                    <option value="">Seleccione un tipo</option>
                    <option value="Fiction">Ficción</option>
                    <option value="NonFiction">No Ficción</option>
                    <option value="Reference">Referencia</option>
                </select>
            </div>

            <div class="form-group">
                <label for="condition">Condición:</label>
                <select id="condition" name="condition" required>
                    <option value="Excellent">Excelente</option>
                    <option value="Good">Bueno</option>
                    <option value="Fair">Regular</option>
                    <option value="Poor">Malo</option>
                </select>
            </div>

            <!-- Ficción -->
            <div id="fictionFields" style="display: none;">
                <div class="form-group">
                    <label for="gender">Género:</label>
                    <select id="gender" name="gender">
                        <option value="Fantasy">Fantasía</option>
                        <option value="CienceFiction">Ciencia Ficción</option>
                        <option value="Mystery">Misterio</option>
                        <option value="Thriller">Suspenso</option>
                        <option value="Romantic">Romance</option>
                        <option value="Terror">Terror</option>
                        <option value="Adventure">Aventura</option>
                        <option value="Other">Otro</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="autor">Autor:</label>
                    <input type="text" id="autor" name="autor">
                </div>
                <div class="form-group">
                    <label><input type="checkbox" id="literaryAwards" name="literaryAwards"> ¿Posee premios literarios?</label>
                </div>
            </div>

            <!-- No Ficción -->
            <div id="nonFictionFields" style="display: none;">
                <div class="form-group">
                    <label for="theme">Área temática:</label>
                    <input type="text" id="theme" name="theme">
                </div>
                <div class="form-group">
                    <label for="objectivePublic">Público objetivo:</label>
                    <select id="objectivePublic" name="objectivePublic">
                        <option value="General">General</option>
                        <option value="Students">Estudiantes</option>
                        <option value="Instructors">Instructores</option>
                        <option value="Kids">Niños</option>
                    </select>
                </div>
            </div>

            <!-- Referencia -->
            <div id="referenceFields" style="display: none;">
                <div class="form-group">
                    <label for="academicArea">Área Académica:</label>
                    <input type="text" id="academicArea" name="academicArea">
                </div>
                <div class="form-group">
                    <label><input type="checkbox" id="borrowed" name="borrowed"> ¿Se puede prestar?</label>
                </div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">Guardar</button>
                <a href="${pageContext.request.contextPath}/WEB-INF/bibliotecarios/books/list.jsp" class="btn">Cancelar</a>
            </div>
        </form>

        <script>
            function showTypeFields() {
                document.getElementById('fictionFields').style.display = 'none';
                document.getElementById('nonFictionFields').style.display = 'none';
                document.getElementById('referenceFields').style.display = 'none';

                var type = document.getElementById('type').value;
                if (type === 'Fiction') {
                    document.getElementById('fictionFields').style.display = 'block';
                } else if (type === 'NonFiction') {
                    document.getElementById('nonFictionFields').style.display = 'block';
                } else if (type === 'Reference') {
                    document.getElementById('referenceFields').style.display = 'block';
                }
            }
        </script>
    </div>

    <footer>
        <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros</p>
    </footer>
</body>
</html>
