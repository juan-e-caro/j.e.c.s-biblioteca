<%@page import="sena.adso.biblioteca_duitama.FictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.NonFictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.ReferenceBook"%>
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
            <h2>Agregar Nuevo Libro</h2>
            <%
                if (request.getMethod().equals("POST")) {
                        
                    BookManager manager = BookManager.getInstance();
                    
                    String name = request.getParameter("name");
                    String type = request.getParameter("type");
                    String condition = request.getParameter("condition");
                    
                    Book newBook = null;
                    int id = manager.getNextBookid();
                    
                    if (type.equals("Fiction")) {
                            String gender = request.getParameter("Gender");
                            String autor = request.getParameter("autor");
                            boolean literaryAwards = request.getParameter("literacyAwards") != null;
                            newBook = new FictionBook(id, name, type, condition, gender, autor, literaryAwards);
                        } else if (type.equals("NonFiction")) {
                            String theme = request.getParameter("tematic");
                            String objectivePublic = request.getParameter("objectivePublic");
                            newBook = new NonFictionBook(id, name, type, condition, theme, objectivePublic);
                        } else if (type.equals("Reference")) {
                            String academicArea = request.getParameter("academicArea");
                            boolean borrowed = request.getParameter("borrowed") != null;
                            newBook = new ReferenceBook(id, name, type, condition, academicArea, borrowed);
                        }
                        
                        if (newBook !=null) {
                                manager.addBook(newBook);
                                
                                response.sendRedirect("list.jsp");
                                return;
                            }
                    }
            %>
            <form method="post" action="add.jsp">
                <div class="form-group">
                    <label for="name">Nombre:</label>
                    <input type="text" id="name" name="name" required> 
                </div>
                
                <div class="form-group">
                    <label for="type">Tipo:</label>
                    <select id="type" name="type" onchange="showTypeFields()" required>
                        <option value="">Seleccione un tipo de Libro</option>
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
                
                <!-- campos libros ficción -->
                <div id="fictionFields" style="display: none;">
                    <div class="form-group">
                        <label for="gender">Genero del libro:</label>
                        <select id="gender" name="gender">
                            <option value="Fantasy">Fantasia</option>
                            <option value="CienceFiction">Ciencia Ficción</option>
                            <option value="Mystery">Misterio</option>
                            <option value="Thriller">Suspenso</option>
                            <option value="Romantic">Romance</option>
                            <option value="Terror">Horror</option>
                            <option value="Adventure">Aventura</option>
                            <option value="Other">Otro Genero</option>
                        </select>
                    </div>
                    
                    <div class="form.group">
                        <label for="autor">Autor:</label>
                        <input type="text" id="autor" name="autor">
                    </div>
                    
                    <div>
                        <label for="literaryAwards">¿posee premio literarios?</label>
                        <input type="checkbox" id="literaryAwards" name="literaryAwards" value="true">
                    </div>
                </div>
                
                <!-- campos libros no ficción -->
                
                <div id="nonFictionFields" style="display: none;">
                    <div class="form-group">
                        <label for="theme">Area tematica:</label>
                        <input type="text" id="theme" name="theme">
                    </div>
                    
                    <div>
                        <label for="objectivePublic">Público objetivo:</label>
                        <select id="objectivePublic" name="objectivePublic">
                            <option value="General">General</option>
                            <option value="Students">Estudiantes</option>
                            <option value="Instructos">Instructores</option>
                            <option value="Kids">Niños</option>
                        </select>
                    </div>
                </div>
                
                <!-- campos libros de referencias -->
                
                <div id="referenceFields" style="display: none;">
                    <div class="form-group">
                        <label for="academicArea">Area Academica:</label>
                        <input type="text" id="academicArea" name="academicArea">
                    </div>
                    
                    <div>
                        <label for="borrowed">¿se puede prestar?</label>
                        <input type="checkbox" id="borrowed" name="borrowed" value="true">
                    </div>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn">Guardar</button>
                    <a href="list.jsp" class="btn">Cancelar</a>
                </div>
            </form>
            
            <script>
                function showTypeFields(){
                    document.getElementById('fictionFields').style.display='none';
                    document.getElementById('nonFictionFields').style.display='none';
                    document.getElementById('referenceFields').style.display='none';
                    
                    var type = document.getElementById('type').value;
                    if (type === 'Fiction') {
                        document.getElementById('fictionFields').style.display='block';
                    } else if (type === 'NonFiction') {
                        document.getElementById('nonFictionFields').style.display='block';
                    } else if (type === 'Reference') {
                        document.getElementById('referenceFields').style.display='block';
                    }
                }
            </script>
        </div>
        
        <footer>
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
    </body>
</html>
