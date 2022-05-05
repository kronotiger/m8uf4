<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css">
<meta charset="UTF-8">
<title>Crea carta</title>
</head>
<%!public int dado() {
		int total = 0;

		int[] dados = { 0, 0, 0, 0 };
		for (int a = 0; a < dados.length; a++) {
			dados[a] = (int) (Math.random() * 6 + 1);
		}
		int minimo = dados[0];
		for (int a = 0; a < dados.length; a++) {
			if (minimo > dados[a]) {
				minimo = dados[a];
			}
		}
		for (int a = 0; a < dados.length; a++) {
			if (minimo == dados[a]) {
				minimo = 0;
			} else {
				total += dados[a];
			}
		}
		return total;
	}%>
<%
//Base de dades
String user = "pablo";
String password = "Abc123$";
String host = "localhost";
String db = "dungeondragons";
String url = "jdbc:mysql://" + host + "/" + db;
Connection conn = null;
Statement statement = null;
ResultSet rs = null;

// recollim valors formulari:
String nom = request.getParameter("nom");
String race = request.getParameter("race");
String fue = request.getParameter("fue");
String des = request.getParameter("des");
String con = request.getParameter("con");
String intt = request.getParameter("int");
String sab = request.getParameter("sab");
String car = request.getParameter("car");

String picture = race + ".png";
int mod[] = { 0, 0, 0, 0, 0, 0 };
if (race != null) {
	if (race.equals("Elfs")) {
		mod[0] = 0;
		mod[1] = 2;
		mod[2] = -2;
		mod[3] = 2;
		mod[4] = 0;
		mod[5] = 0;
	} else if (race.equals("Nans")) {
		mod[0] = 0;
		mod[1] = 0;
		mod[2] = 2;
		mod[3] = 0;
		mod[4] = 2;
		mod[5] = -2;
	} else if (race.equals("Gnom")) {
		mod[0] = -2;
		mod[1] = 0;
		mod[2] = 2;
		mod[3] = 0;
		mod[4] = 0;
		mod[5] = 2;
	} else if (race.equals("Mitjans")) {
		mod[0] = -2;
		mod[1] = 2;
		mod[2] = 0;
		mod[3] = 0;
		mod[4] = 0;
		mod[5] = 0;
	} else if (race.equals("Semiorc")) {
		mod[0] = 2;
		mod[1] = 0;
		mod[2] = 0;
		mod[3] = -2;
		mod[4] = 0;
		mod[5] = -2;
	}
}

int nfue = 0;
int ndes = 0;
int ncon = 0;
int nint = 0;
int nsab = 0;
int ncar = 0;
int pv = 0;
int pm = 0;

//Creamos los datos y los rellenamos
int[] dados = { 0, 0, 0, 0, 0, 0 };
for (int a = 0; a < dados.length; a++) {
	dados[a] = dado();
}

if (fue != null || des != null || con != null || intt != null || sab != null || car != null) {
	nfue = Integer.parseInt(fue) + mod[0];
	ndes = Integer.parseInt(des) + mod[1];
	ncon = Integer.parseInt(con) + mod[2];
	nint = Integer.parseInt(intt) + mod[3];
	nsab = Integer.parseInt(sab) + mod[4];
	ncar = Integer.parseInt(car) + mod[5];
	pv = (ncon) * (int) (Math.random() * 8 + 1);
	pm = (nint) + (nsab) * (int) (Math.random() * 4 + 1);

	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, user, password);
		statement = conn.createStatement();
		//inmediatamente hacemos un insert amb les dades
		//creamos la consulta

		int i = statement
		.executeUpdate("insert into dungeondragons(Nom,Picture,Race,Fue,Des,con,inte,sab,car,pv,pm)values('"
				+ nom + "','" + picture + "','" + race + "'," + nfue + "," + ndes + "," + ncon + "," + nint
				+ "," + sab + "," + car + "," + pv + "," + pm + ")");
		//	out.println("Data is successfully inserted!");
	} catch (SQLException error) {
		out.print("Error de Conexión : " + error.toString());
	}
}
int[] personalizada = { nfue - mod[0], ndes - mod[1], ncon - mod[2], nint - mod[3], nsab - mod[4], ncar - mod[5] };
%>
<body>
<!--  Esta es la nueva modificacion -->
	<h1>Crea carta</h1>
	<form>
		<p>Quin es el teu nom?</p>
		<input type="text" name="nom">
		<p>
			Selecciona quina es la teva raza
			</pnull>
			<select name="race">
				<option value="Elfs">Elfs</option>
				<option value="Nans">Nans</option>
				<option value="Gnom">Gnom</option>
				<option value="Mitjans">Mitjans</option>
				<option value="Semiorc">Semiorc</option>
				<option value="Humans">Humans</option>
			</select>
		<p>Ara has de repartir les estadístiques, aquestes son les teves
			tirades:</p>
		<p><%=dados[0]%>
			,
			<%=dados[1]%>
			,
			<%=dados[2]%>
			,
			<%=dados[3]%>
			,
			<%=dados[4]%>
			,
			<%=dados[5]%>.
		</p>
		<div id="creacarta">
			<p>FUE:</p>
			<select name="fue">
				<option><%=dados[0]%></option>
				<option><%=dados[1]%></option>
				<option><%=dados[2]%></option>
				<option><%=dados[3]%></option>
				<option><%=dados[4]%></option>
				<option><%=dados[5]%></option>
			</select>
			<p>DES:</p>
			<select name="des">
				<option><%=dados[0]%></option>
				<option><%=dados[1]%></option>
				<option><%=dados[2]%></option>
				<option><%=dados[3]%></option>
				<option><%=dados[4]%></option>
				<option><%=dados[5]%></option>
			</select>
			<p>CON:</p>
			<select name="con">
				<option><%=dados[0]%></option>
				<option><%=dados[1]%></option>
				<option><%=dados[2]%></option>
				<option><%=dados[3]%></option>
				<option><%=dados[4]%></option>
				<option><%=dados[5]%></option>
			</select>
			<p>INT:</p>
			<select name="int">
				<option><%=dados[0]%></option>
				<option><%=dados[1]%></option>
				<option><%=dados[2]%></option>
				<option><%=dados[3]%></option>
				<option><%=dados[4]%></option>
				<option><%=dados[5]%></option>
			</select>
			<p>SAB:</p>
			<select name="sab">
				<option><%=dados[0]%></option>
				<option><%=dados[1]%></option>
				<option><%=dados[2]%></option>
				<option><%=dados[3]%></option>
				<option><%=dados[4]%></option>
				<option><%=dados[5]%></option>
			</select>
			<p>CAR:</p>
			<select name="car">
				<option><%=dados[0]%></option>
				<option><%=dados[1]%></option>
				<option><%=dados[2]%></option>
				<option><%=dados[3]%></option>
				<option><%=dados[4]%></option>
				<option><%=dados[5]%></option>
			</select> 
		</div>
		<input type="submit" value="Crea carta">
	</form>
	<h2>
		<%
		if (nom != null) {
			out.println(nom);
		}
		%>
	</h2>
	<table class="principal">
		<tr>

			<td rowspan="9">
				<%
				if (!picture.equals("null.png")) {
					out.print("<img src='img/" + picture + "' width='200px' height='350px'>");
				}
				%>
			</td>
			<td>Caracteristiques</td>
			<td>Valor Base</td>
			<td>Mod.</td>
			<td>Valor Final</td>
		</tr>
		<tr>
			<td>FUE:</td>
			<td><%=personalizada[0]%></td>
			<td><%=mod[0]%></td>
			<td><%=nfue%></td>
		</tr>
		<tr>
			<td>DES:</td>
			<td><%=personalizada[1]%></td>
			<td><%=mod[1]%></td>
			<td><%=ndes%></td>
		</tr>
		<tr>
			<td>CON:</td>
			<td><%=personalizada[2]%></td>
			<td><%=mod[2]%></td>
			<td><%=ncon%></td>
		</tr>
		<tr>
			<td>INT:</td>
			<td><%=personalizada[3]%></td>
			<td><%=mod[3]%></td>
			<td><%=nint%></td>
		</tr>
		<tr>
			<td>SAB:</td>
			<td><%=personalizada[4]%></td>
			<td><%=mod[4]%></td>
			<td><%=nsab%></td>
		</tr>
		<tr>
			<td>CAR:</td>
			<td><%=personalizada[5]%></td>
			<td><%=mod[5]%></td>
			<td><%=ncar%></td>
		</tr>
		<tr>

			<td>P.V(<%=pv%>)
			</td>
			<td colspan="3">
				<table width="<%=pv * 2%>px">
				</table>
			</td>
		</tr>
		<tr>
			<td>P.M(<%=pm%>)
			</td>
			<td colspan="3">
				<table width="<%=pm * 2%>px">
				</table>
			</td>
		</tr>
	</table>
	<form action="index.jsp" method="get">
		<button class="btnprincipal abajo">Principal</button>
	</form>
	
	<form action="visualitzacarta.jsp" method="get">
		<button class="btnprincipal abajo" method="get" value="1" name="pagina">Visualitza la teva carta</button>
	</form>

</body>
</html>