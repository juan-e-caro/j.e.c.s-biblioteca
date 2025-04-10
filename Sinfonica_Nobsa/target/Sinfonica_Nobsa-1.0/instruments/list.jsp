<%@page import="sena.adso.sinfonica_nobsa.model.Instrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instrumentos - Sinfónica de Nobsa</title>
        <link rel="stylesheet" href="../css/styles.css">
    </head>
    <body>
        <header>
            <h1>Sinfónica de Nobsa</h1>
            <p>Sistema de Préstamo de Instrumentos</p>
        </header>
        
        <nav>
            <ul>
                <li><a href="../index.jsp">Inicio</a></li>
                <li><a href="list.jsp">Instrumentos</a></li>
                <li><a href="../loans/list.jsp">Préstamos</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <h2>Gestión de Instrumentos</h2>
            
            <div class="actions">
                <a href="add.jsp" class="btn">Agregar Nuevo Instrumento</a>
            </div>
            
            <%
              InstrumentManager manager = InstrumentManager.getInstance();
              
              ArrayList<Instrument> instruments = manager.getAllInstruments();
              
              if (instruments.isEmpty()) {                                
            %>
                <p>No hay instrumentos registrados en el sistema.</p>
            <% 
                } else {
            %>
                <table>
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
                        <% for (Instrument instrument : instruments) { %>
                            <tr>
                                <td><%= instrument.getId()%></td>
                                <td><%= instrument.getName()%></td>
                                <td><%= instrument.getType()%></td>
                                <td><%= instrument.getCondition()%></td>
                                <td><%= instrument.isAvailable()%></td>
                                <td><%= instrument.getDescription()%></td>
                                <td>
                                    <a href="edit.jsp?id=<%= instrument.getId()%>" class="btn">Editar</a>
                                    <a href="delete.jsp?id=<%= instrument.getId()%>" class="btn btn-danger">Eliminar</a>
                                    <% if(instrument.isAvailable()){ %>
                                        <a href="../loans/add.jsp?instrumentId=<%= instrument.getId()%>" class="btn btn-success">Prestar</a>
                                    <% } %>
                                </td>
                            </tr>
                    <% } %>    
                    </tbody>
                </table>
           <% } %> 
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>
