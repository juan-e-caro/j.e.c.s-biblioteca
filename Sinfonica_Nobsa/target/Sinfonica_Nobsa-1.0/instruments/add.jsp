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
        <title>Agregar Instrumento - Sinfónica de Nobsa</title>
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
            <h2>Agregar Nuevo Instrumento</h2>
            
            <%
               if (request.getMethod().equals("POST")) {
                       
                   InstrumentManager manager = InstrumentManager.getInstance();
                   
                   String name = request.getParameter("name");
                   String type = request.getParameter("type");
                   String condition = request.getParameter("condition");
                   
                   Instrument newInstrument = null;
                   int id = manager.getNextInstrumentId();
                   
                   if (type.equals("String")) {
                         int numberOfStrings = Integer.parseInt(request.getParameter("numberOfStrings"));
                         String stringType = request.getParameter("stringType");
                         newInstrument = new StringInstrument(id, name, condition, numberOfStrings, stringType);
                       } else if(type.equals("Wind")) {
                           String material = request.getParameter("material");
                           String mouthpieceType = request.getParameter("mouthpieceType");
                           newInstrument = new WindInstrument(id, name, condition, material, mouthpieceType);
                       } else if (type.equals("Percussion")) {
                               String material = request.getParameter("material");
                               boolean tunable = request.getParameter("tunable") != null;
                               newInstrument = new PercussionInstrument(id, name, condition, material, tunable);
                        }
                           
                        if (newInstrument != null) {
                                manager.addInstrument(newInstrument);
                                
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
                        <option value="">Seleccione un tipo</option>
                        <option value="String">Cuerda</option>
                        <option value="Wind">Viento</option>
                        <option value="Percussion">Percusión</option>
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
                
                <!-- String instrument fields -->
                <div id="stringFields" style="display: none;">
                    <div class="form-group">
                        <label for="numberOfStrings">Número de cuerdas:</label>
                        <input type="number" id="numberOfStrings" name="numberOfStrings" min="1">
                    </div>
                    
                    <div class="form-group">
                        <label for="stringType">Tipo de cuerdas:</label>
                        <select id="stringType" name="stringType">
                            <option value="Nylon">Nylon</option>
                            <option value="Steel">Acero</option>
                            <option value="Gut">Tripa</option>
                            
                        </select>
                    </div>
                </div>
                
                <!-- Wind instrument fields -->
                <div id="windFields" style="display: none;">
                    <div class="form-group">
                        <label for="material">Material:</label>
                        <select id="material" name="material">
                            <option value="Wood">Madera</option>
                            <option value="Brass">Latón</option>
                            <option value="Silver">Plata</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="mouthpieceType">Tipo de boquilla:</label>
                        <select id="mouthpieceType" name="mouthpieceType">
                            <option value="Reed">Caña</option>
                            <option value="Embouchure">Embocadura</option>
                        </select>
                    </div>
                </div>
                
                <!-- Percussion instrument fields -->
                <div id="percussionFields" style="display: none;">
                    <div class="form-group">
                        <label for="percussionMaterial">Material:</label>
                        <select id="percussionMaterial" name="material">
                            <option value="Wood">Madera</option>
                            <option value="Metal">Metal</option>
                            <option value="Synthetic">Sintético</option>
                            <option value="Wood and Metal">Madera y Metal</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="tunable">¿Es afinable?</label>
                        <input type="checkbox" id="tunable" name="tunable" value="true">
                    </div>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn">Guardar</button>
                    <a href="list.jsp" class="btn">Cancelar</a>
                </div>
            </form>
            
            <script>
                function showTypeFields(){
                    document.getElementById('stringFields').style.display = 'none';
                    document.getElementById('windFields').style.display = 'none';
                    document.getElementById('percussionFields').style.display = 'none';
                    
                    var type = document.getElementById('type').value;
                    if (type === 'String') {
                        document.getElementById('stringFields').style.display = 'block';
                    } else if (type === 'Wind') {
                        document.getElementById('windFields').style.display = 'block';
                    } else if (type === 'Percussion') {
                        document.getElementById('percussionFields').style.display = 'block';
                    } 
                }
            </script>
        </div>
        
        <footer>
            <p>&copy; 2025 Sinfónica de Nobsa - Sistema de Préstamo de Instrumentos</p>
        </footer>
    </body>
</html>