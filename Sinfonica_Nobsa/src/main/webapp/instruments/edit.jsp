<%@page import="sena.adso.sinfonica_nobsa.model.PercussionInstrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.WindInstrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.StringInstrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.Instrument"%>
<%@page import="sena.adso.sinfonica_nobsa.model.InstrumentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Instrumento - Sinfónica de Nobsa</title>
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
            <h2>Editar Instrumento</h2>
            
               <%
                 InstrumentManager manager = InstrumentManager.getInstance();
                 
                 int instrumentId = 0;
                 try {
                         instrumentId = Integer.parseInt(request.getParameter("id"));
                     } catch (NumberFormatException e) {
                        response.sendRedirect("list.jsp");
                        return;
                     }
                 
                Instrument instrument = manager.getInstrumentById(instrumentId);
                
                if (instrument == null) {
                        response.sendRedirect("list.jsp");
                        return;
                }
                
                if (request.getMethod().equals("POST")) {
                        String name = request.getParameter("name");
                        String condition = request.getParameter("condition");
                        
                        if (instrument instanceof StringInstrument) {
                                StringInstrument stringInstrument = (StringInstrument)instrument;
                                stringInstrument.setName(name);
                                stringInstrument.setCondition(condition);
                                
                                int numberOfStrings = Integer.parseInt(request.getParameter("numberOfStrings"));
                                String stringType = request.getParameter("stringType");
                                
                                stringInstrument.setNumberOfStrings(numberOfStrings);
                                stringInstrument.setStringType(stringType);
                                
                                manager.updateInstrument(stringInstrument);                                
                        } else if (instrument instanceof WindInstrument) {
                             WindInstrument windInstrument = (WindInstrument) instrument;
                             windInstrument.setName(name);
                             windInstrument.setCondition(condition);
                             
                             String material = request.getParameter("material");
                             String mouthpieceType = request.getParameter("mouthpieceType");
                             
                             windInstrument.setMaterial(material);
                             windInstrument.setMouthpieceType(mouthpieceType);
                             
                             manager.updateInstrument(windInstrument);
                        } else if (instrument instanceof PercussionInstrument) {
                                PercussionInstrument percussionInstrument = (PercussionInstrument) instrument;
                                percussionInstrument.setName(name);
                                percussionInstrument.setCondition(condition);
                                
                                String material = request.getParameter("material");
                                boolean tunable = request.getParameter("tunable") != null;
                                
                                percussionInstrument.setMaterial(material);
                                percussionInstrument.setTunable(tunable);
                                
                                manager.updateInstrument(percussionInstrument);
                        }
                        
                        response.sendRedirect("list.jsp");
                        return;
                }
                
                String instrumentType = instrument.getType();
                
                int numberOfStrings = 0;
                String stringType = "";
                String material = "";
                String mouthpieceType = "";
                boolean tunable = false;
                
                if (instrument instanceof StringInstrument) {
                        StringInstrument stringInstrument = (StringInstrument) instrument;
                        numberOfStrings = stringInstrument.getNumberOfStrings();
                        stringType = stringInstrument.getStringType();
                } else if(instrument instanceof WindInstrument) {
                    WindInstrument windInstrument = (WindInstrument) instrument;
                    material = windInstrument.getMaterial();
                    mouthpieceType = windInstrument.getMouthpieceType();
                }else if (instrument instanceof PercussionInstrument) {
                        PercussionInstrument percussionInstrument = (PercussionInstrument) instrument;
                        material = percussionInstrument.getMaterial();
                        tunable = percussionInstrument.isTunable();
                    }
                %>       
                <form method="post" action="edit.jsp?id=<%= instrument.getId()%>">
                <div class="form-group">
                    <label for="name">Nombre:</label>
                    <input type="text" id="name" name="name" value="<%= instrument.getName()%>" required>
                </div>
                
                <div class="form-group">
                    <label for="type">Tipo:</label>
                    <input type="text" id="type" name="type" value="<%= instrument.getType()%>" readonly>
                </div>
                
                <div class="form-group">
                    <label for="condition">Condición:</label>
                    <select id="condition" name="condition" required>
                        <option value="Excellent" <%= instrument.getCondition().equals("Excellent") ? "selected" : ""%>>Excelente</option>
                        <option value="Good" <%= instrument.getCondition().equals("Good") ? "selected" : ""%>>Bueno</option>
                        <option value="Fair" <%= instrument.getCondition().equals("Fair") ? "selected" : ""%>>Regular</option>
                        <option value="Poor" <%= instrument.getCondition().equals("Poor") ? "selected" : ""%>>Malo</option>
                    </select>
                </div>
                
                <% if(instrumentType.equals("String")) {%>
                    <!-- String instrument fields -->
                    <div id="stringFields">
                        <div class="form-group">
                            <label for="numberOfStrings">Número de cuerdas:</label>
                            <input type="number" id="numberOfStrings" name="numberOfStrings" min="1" value="">
                        </div>
                        
                        <div class="form-group">
                            <label for="stringType">Tipo de cuerdas:</label>
                            <select id="stringType" name="stringType">
                                <option value="Nylon" <%= stringType.equals("Nylon") ? "selected" : ""%>>Nylon</option>
                                <option value="Steel" <%= stringType.equals("Steel") ? "selected" : ""%>>Acero</option>
                                <option value="Gut" <%= stringType.equals("Gut") ? "selected" : ""%>>Tripa</option>
                            </select>
                        </div>
                    </div>
                    <%} else if(instrumentType.equals("Wind")){%>
                    <!-- Wind instrument fields -->
                    <div id="windFields">
                        <div class="form-group">
                            <label for="material">Material:</label>
                            <select id="material" name="material">
                                <option value="Wood" <%= material.equals("Wood") ? "selected" : ""%>>Madera</option>
                                <option value="Brass" <%= material.equals("Brass") ? "selected" : ""%>>Latón</option>
                                <option value="Silver" <%= material.equals("Silver") ? "selected" : ""%>>Plata</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="mouthpieceType">Tipo de boquilla:</label>
                            <select id="mouthpieceType" name="mouthpieceType">
                                <option value="Reed" <%= mouthpieceType.equals("Reed") ? "selected" : ""%>>Caña</option>
                                <option value="Embouchure" <%= mouthpieceType.equals("Embouchure") ? "selected" : ""%>>Embocadura</option>
                            </select>
                        </div>
                    </div>
                    <%} else if(instrumentType.equals("Percussion")) {%>
                    <!-- Percussion instrument fields -->
                    <div id="percussionFields">
                        <div class="form-group">
                            <label for="percussionMaterial">Material:</label>
                            <select id="percussionMaterial" name="material">
                                <option value="Wood" <%= material.equals("Wood") ? "selected" : ""%>>Madera</option>
                                <option value="Metal" <%= material.equals("Metal") ? "selected" : ""%>>Metal</option>
                                <option value="Synthetic" <%= material.equals("Synthetic") ? "selected" : ""%>>Sintético</option>
                                <option value="Wood and Metal" <%= material.equals("Wood and Metal") ? "selected" : ""%>>Madera y Metal</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="tunable">¿Es afinable?</label>
                            <input type="checkbox" id="tunable" name="tunable" value="true" <%= tunable ? "checked" : ""%>>
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
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>
