<%@ page import="java.util.Arrays,java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Rpg Card Generator</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<h1>Visualitzar cartes</h1>
<%//  variables per fer la connexio:
	String user="pablo";
	String password="Abc123$";
	String host="localhost";
	String db = "dungeondragons";
	String url = "jdbc:mysql://"+host+"/"+db;
	Connection conn = null;
	Statement statement = null;
	Statement num_registres=null;
	ResultSet rs = null;
	ResultSet num_reg=null;
	int inicio;
	
	//Limito la busqueda
	int TAMANO_PAGINA = 4;

	//examino la página a mostrar y el inicio del registro a mostrar
	
	String pag = request.getParameter("pagina");
	int pagina=Integer.parseInt(pag);
	if (pagina==0) {
	   	inicio = 0;
	    pagina=1;
	}
	else {
	    inicio = (pagina - 1) * TAMANO_PAGINA;
	}

Class.forName("com.mysql.jdbc.Driver").newInstance();
conn = DriverManager.getConnection(url, user, password);
num_registres = conn.createStatement();
//creamos la consulta

num_reg = num_registres.executeQuery("SELECT * FROM dungeondragons");
int num_total_registros=0;
while(num_reg.next()) {
	num_total_registros++;
}

//calculo el total de páginas
int total_paginas = (int)Math.ceil(((double)num_total_registros/ TAMANO_PAGINA));

//pongo el número de registros total, el tamaño de página y la página que se muestra

out.print("Nombre de registres trobats:"+num_total_registros+"<br>");
out.print("Es mostren pàgines de "+TAMANO_PAGINA+" registres cadascuna<br>");
out.print("Mostrant la pàgina "+pagina+" de "+total_paginas+"<p><br>");




//out.print("<a href=VisualitzarCartes.jsp?pagina=2>"+2+"</a> ");
if (total_paginas > 1){
    for (int i=1;i<=total_paginas;i++){
       if (pagina == i)
          //si muestro el índice de la página actual, no coloco enlace
          out.print(pagina);
       else
          //si el índice no corresponde con la página mostrada actualmente, coloco el enlace para ir a esa página
          out.print(" <a href=visualitzacarta.jsp?pagina="+i+">"+i+"</a> ");
    }
}
out.print("<br><br>");
try{

	Class.forName("com.mysql.jdbc.Driver").newInstance ();
	conn = DriverManager.getConnection(url, user, password);
	statement = conn.createStatement();
	//inmediatamente hacemos una consulta sencilla
	//creamos la consulta
	String sentence="SELECT * from dungeondragons limit "+inicio+","+TAMANO_PAGINA;
	rs = statement.executeQuery(sentence);
	//leemos la consulta
	while(rs.next()) {
	//mostramos los resultados obtenidos
	//out.println(rs.getString("ID_carta"));
	//String nom=request.getParameter("nom");
	%>
	<div class="mostra">
	<%out.print(rs.getString("Nom"));%>
	<br>
	race:<%out.print(rs.getString("RACE")); %>
	<br>
	
	<table class="principal">
		<tr>
			<td rowspan="9"><img src="img/<%out.print(rs.getString("PICTURE")); %>"width="200px" height="350px"></td>
			<td>Caracteristiques</td>
			<td>Valor Final</td>
		</tr>
		<tr>
			<td>FUE:</td>
			<td><%out.print(rs.getString("FUE")); %></td>
		</tr>
		<tr>
			<td>DES:</td>
			<td><%out.print(rs.getString("DES"));%></td>
		</tr>
		<tr>
			<td>CON:</td>
			<td><%out.print(rs.getString("CON"));%></td>
		</tr>
		<tr>
			<td>INT:</td>
			<td><%out.print(rs.getString("INTE"));%></td>
		</tr>
		<tr>
			<td>SAB:</td>
			<td><%out.print(rs.getString("SAB"));%></td>
		</tr>
		<tr>
			<td>CAR:</td>
			<td><%out.print(rs.getString("CAR"));%></td>
		</tr>
		<tr>
			<td>P.V(<%=rs.getString("pv")%>)
			</td>
			<td colspan="2">
				<table width="<%=Integer.parseInt(rs.getString("pv")) * 1.5%>px">
				</table>
			</td>
		</tr>
		<tr>
			<td>P.M(<%=rs.getString("pm")%>)
			</td>
			<td colspan="2">
				<table width="<%=Integer.parseInt(rs.getString("pm")) * 1.5%>px">
				</table>
			</td>
		</tr>
	</table>
	</div>

<% 
	}
	//cerramos la conexión
	rs.close();
	}catch(SQLException error) {
	out.print("Error de Conexión : "+error.toString());
	}  


	
	%>
	<div class="form">
	<form action="index.jsp" method="get">
		<button class="btnprincipal abajo ">Principal</button>
	</form>
	
	<form action="creacarta.jsp" method="get">
		<button class="btnprincipal abajo" method="get" value="1" name="pagina">Crea la teva carta</button>
	</form>
	</div>