<%@page import="sena.adso.biblioteca_duitama.ReferenceBook"%>
<%@page import="sena.adso.biblioteca_duitama.NonFictionBook"%>
<%@page import="sena.adso.biblioteca_duitama.FictionBook"%>
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
            <h2>Editar Libros</h2>
            
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
                            String name = request.getParameter("name");
                            String condition = request.getParameter("condition");
                            
                            if (book instanceof FictionBook) {
                                FictionBook fictionBook = (FictionBook)book;
                                fictionBook.setName(name);
                                fictionBook.setCondition(condition);
                                
                                String gender = request.getParameter("gender");
                                String autor = request.getParameter("autor");
                                boolean literaryAwards = request.getParameter("literaryAwards") != null;
                                
                                fictionBook.setGender(gender);
                                fictionBook.setAutor(autor);
                                fictionBook.setLiteraryAwards(literaryAwards);
                                
                                manager.updateBook(fictionBook);
                            } else if (book instanceof NonFictionBook) {
                               NonFictionBook nonFictionBook = (NonFictionBook)book;
                               nonFictionBook.setName(name);
                               nonFictionBook.setCondition(condition);
                               
                               String theme = request.getParameter("theme");
                               String objectivePublic = request.getParameter("objectivePublic");
                               
                               nonFictionBook.setTheme(theme);
                               nonFictionBook.setObjectivePublic(objectivePublic);
                               
                               manager.updateBook(nonFictionBook);
                            } else if (book instanceof ReferenceBook) {
                                ReferenceBook referenceBook = (ReferenceBook)book;
                                referenceBook.setName(name);
                                referenceBook.setCondition(condition);
                                
                                String academicArea = request.getParameter("academicArea");
                                boolean borrowed = request.getParameter("borrowed") != null;
                                
                                referenceBook.setAcademicArea(academicArea);
                                referenceBook.setBorrowed(borrowed);
                                
                                manager.updateBook(referenceBook);
                            }
                            
                            response.sendRedirect("list.jsp");
                            return;
                    }
                    
                    String bookType = book.getType();
                    
                    String gender= "";
                    String autor = "";
                    boolean literaryAwards = false;
                    String theme = "";
                    String objectivePublic = "";
                    String academicArea = "";
                    boolean borrowed = false;
                    
                    if (book instanceof FictionBook) {
                        FictionBook fictionBook = (FictionBook) book;
                        gender = fictionBook.getGender();
                        autor = fictionBook.getAutor();
                        literaryAwards = fictionBook.isLiteraryAwards();
                    } else if (book instanceof NonFictionBook) {
                        NonFictionBook nonFictionBook = (NonFictionBook) book;
                        theme = nonFictionBook.getTheme();
                        objectivePublic = nonFictionBook.getObjectivePublic();
                    } else if (book instanceof ReferenceBook) {
                        ReferenceBook referenceBook = (ReferenceBook) book;
                        academicArea = referenceBook.getAcademicArea();
                        borrowed = referenceBook.isBorrowed();
                    }
                %>
                <form method="post" action="edit.jsp?id=<%= book.getId()%>">
                    <div class="form-group">
                        <label for="name">Nombre:</label>
                        <input type="text" id="name" name="name" value="<%= book.getName()%>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="type">Tipo:</label>
                        <input type="text" id="type" name="type" value="<%= book.getType()%>" readonly>
                    </div>
                        
                    <div class="form-group">
                        <label for="condition">Condición:</label>
                        <select id="condition" name="condition" required>
                            <option value="Excellent" <%= book.getCondition().equals("Excellent") ? "selected" : ""%>>Excelente</option>
                            <option value="Good" <%= book.getCondition().equals("Good") ? "selected" : ""%>>Bueno</option>
                            <option value="Fair" <%= book.getCondition().equals("Fair") ? "selected" : ""%>>Regular</option>
                            <option value="Poor" <%= book.getCondition().equals("Poor") ? "selected" : ""%>>Malo</option>
                        </select>
                    </div>
                        
                    <% if(bookType.equals("Fiction")) {%>
                        <!-- campos libros Ficción -->
                        <div id="fictionFields">
                            <div class="form-group">
                                <label for="gender">Genero:</label>
                                <select id="gender" name="gender">
                                    <option value="Fantasy"<%= gender.equals("Fantasy") ? "Selected" : ""%>>Fantasia</option>
                                    <option value="CienceFiction"<%= gender.equals("CienceFiction") ? "Selected" : ""%>>Ciencia Ficción</option>
                                    <option value="Mystery"<%= gender.equals("Mystery") ? "Selected" : ""%>>Misterio</option>
                                    <option value="Thriller"<%= gender.equals("Triller") ? "Selected" : ""%>>Suspenso</option>
                                    <option value="Romantic"<%= gender.equals("Romantic") ? "Selected" : ""%>>Romance</option>
                                    <option value="Terror"<%= gender.equals("Terror") ? "Selected" : ""%>>Horror</option>
                                    <option value="Adventure"<%= gender.equals("Adventure") ? "Selected" : ""%>>Aventura</option>
                                    <option value="Other"<%= gender.equals("Other") ? "Selected" : ""%>>Otro Genero</option>
                                </select>
                            </div>
                                
                            <div class="form-group">
                                <label for="autor">Autor:</label>
                                <input type="text" id="autor" name="autor" value="<%= autor.equals("autor") %>">
                            </div>
                                
                            <div>
                                <label for="literaryAwards">¿posee un premio literario?</label>
                                <input type="checkbox" id="literaryAwards" name="literaryAwards" value="true" <%= literaryAwards ? "checked" : ""%>>
                            </div>   
                        </div>
                    <%} else if (bookType.equals("NonFiction")) {%>
                        <!-- campos libros no Ficción -->
                        <div id="nonFictionFields">
                            <div class="form-group">
                                <label for="theme">Área tematica:</label>
                                <input type="text" id="theme" name="theme" value="<%= theme.equals("theme") %>">
                            </div>
                            
                            <div>
                                <label for="objectivePublic">Publico Objetivo</label>
                                <select id="objectivePublic" name="objectivePublic">
                                    <option value="General"<%= objectivePublic.equals("General") ? "Selected" : ""%>>General</option>
                                    <option value="Students"<%= objectivePublic.equals("Students") ? "Selected" : ""%>>Estudiantes</option>
                                    <option value="Instructos"<%= objectivePublic.equals("Instructors") ? "Selected" : ""%>>Instrutores</option>
                                    <option value="Kids"<%= objectivePublic.equals("Kids") ? "Selected" : ""%>>Niños</option>
                                </select>
                            </div>
                        </div>
                    <%}else if (bookType.equals("Reference")){%>
                        <!-- campos bibros referencias -->
                        <div id="referenceFields">
                            <div class="form-group">
                                <label  for="academicArea">Área academica:</label>
                                <input type="text" id="academicArea" name="academicArea" value="<%= academicArea.equals("academicArea") %>">
                            </div>
                            
                            <div class="form-group">
                                <label for="borrowed">¿Se puede prestar?</label>
                                <input type="checkbox" id="borrowed" name="borrowed" value="true" <%= borrowed ? "checked" : "" %> >
                            </div>
                        </div>
                    <% } %>
                    
                    <div class="form-group">
                        <button type="submit" class="btn">Guardar Cambios</button>
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
