<%@page import="java.util.ArrayList"%>
<%@page import="sena.adso.biblioteca_duitama.Book"%>
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
            <h2>Crear Nuevo Préstamo</h2>
            
            <%
                //obtener instancia de libros
                BookManager manager = BookManager.getInstance();
                
                //revisar si una forma fue escrita
                if (request.getMethod().equals("POST")) {
                        // obtener form data
                        int bookId = Integer.parseInt(request.getParameter("bookId"));
                        String borrowerName = request.getParameter("borrowerName");
                        String borrowerId = request.getParameter("borrowerId");
                        int loanDays = Integer.parseInt(request.getParameter("loanDays"));
                        
                        //crear el prestamo
                        LoanBook loan = manager.createLoan(bookId, borrowerName, borrowerId, loanDays);
                        
                        if (loan != null) {
                            //presamo creado de manera exitosa
                            response.sendRedirect("list.jsp");
                        } else {
                            //creacion de prestamo fallida
            %>
                            <div>
                                <p>No se pudo crear el prestamo. El libro actualmente no está disponible.</p>
                            </div>
            <%
                        } return;
                    }
                
                //obtener libros disponibles
                ArrayList<Book> availableBooks = manager.getAvailableBooks();

                //revisa si hay libros disponibles
                if (availableBooks.isEmpty()) {
            %>
                <div class="alert alert danger">
                    <p>No hay libro disponibles para préstamo en este momento.</p>
                </div>
                <p><a href="list.jsp" class="btn">Volver a la lista de prestamos</a></p>
            <%
                } else {
                    //revisa si el ID fue proveido en el pedido (lista libros)
                    String bookIdParam = request.getParameter("bookId");
                    int selectedBookId = 0;

                    if (bookIdParam != null && !bookIdParam.isEmpty()) {
                        try {
                            selectedBookId = Integer.parseInt(bookIdParam);
                        } catch (NumberFormatException e){
                        //ID invalido, ignorar
                        }
                    }
            %>
                <form method="post" action="add.jsp">
                    <div class="form-group">
                        <label for="bookId">Libro:</label>
                        <select id="bookId" name="bookId" required>
                            <option value="">Seleccione un libro</option>
                            <% for (Book book : availableBooks) {%>
                                <option value="<%= book.getId() %>" <%= (book.getId() == selectedBookId) ? "selected" : "" %> >
                                    <%= book.getName() %> (<%= book.getType() %>, <%= book.getCondition() %>)
                                </option>
                            <% } %>
                        </select>
                    </div>
                        
                    <div class="form-group">
                        <label for="borrowerName">Nombre del Usuario:</label>
                        <input type="text" id="borrowerName" name="borrowerName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="borrowerId">ID del Usuario:</label>
                        <input type="text" id="borrowerId" name="borrowerId" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="loanDays">Días de Préstamo:</label>
                        <input type="number" id="loanDays" name="loanDays" min="1" max="30" value="7" required>
                        <small>Número de días que el instrumento estará prestado (máximo 30 días).</small>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn">Crear Préstamo</button>
                        <a href="list.jsp" class="btn">Cancelar</a>
                    </div>
                </form>
            <% } %>
        </div>
        
        
        <footer>
            <p>&copy; 2025 Biblioteca Publica de Duitama - Sistema de Préstamo de Libros </p>
        </footer>
    </body>
</html>
