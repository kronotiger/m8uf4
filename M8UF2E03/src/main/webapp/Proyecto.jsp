<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>M8 UF2 Ex3</title>
</head>
<body>

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

	<%!public int[] raza() {
		int resultado = (int) (Math.random() * 6 + 1) - 1;
		if (resultado == 0) {
			int[] raza = { resultado, 0, 2, -2, 2, 0, 0 };
			return raza;
		} else if (resultado == 1) {
			int[] raza = { resultado, 0, 0, 2, 0, 2, -2 };
			return raza;
		} else if (resultado == 2) {
			int[] raza = { resultado, -2, 0, 2, 0, 0, 2 };
			return raza;
		} else if (resultado == 3) {
			int[] raza = { resultado, -2, 2, 0, 0, 0, 0 };
			return raza;
		} else if (resultado == 4) {
			int[] raza = { resultado, 2, 0, 0, -2, 0, -2 };
			return raza;
		} else if (resultado == 5) {
			int[] raza = { resultado, 0, 0, 0, 0, 0, 0 };
			return raza;
		} else {
			return null;
		}
	}%>

	<%
	int[] raza = raza();
	int[] tiradas = { 0, 0, 0, 0, 0, 0 };

	for (int a = 0; a < tiradas.length; a++) {
		tiradas[a] = dado();
	}
	int vida = (tiradas[2] + (int) raza[3]) * (int) (Math.random() * 8 + 1);
	int mana = ((tiradas[3] + (int) raza[4]) + (tiradas[4] + (int) raza[5]) / 2) * (int) (Math.random() * 4 + 1);

	String nomraza = "";

	if (raza[0] == 0) {
		nomraza = "Elf";
	} else if (raza[0] == 1) {
		nomraza = "Nan";
	} else if (raza[0] == 2) {
		nomraza = "Gnom";
	} else if (raza[0] == 3) {
		nomraza = "Mitja";
	} else if (raza[0] == 4) {
		nomraza = "Semiorc";
	} else if (raza[0] == 5) {
		nomraza = "Humans";
	}
	%>
	<h1><%=nomraza%></h1>
	<table id="principal">
		<tr>
			<td rowspan="9"><img src="img/<%=raza[0]%>.png" width="200px"
				height="350px"></td>
			<td>Caracteristiques</td>
			<td>Valor Base</td>
			<td>Mod.</td>
			<td>Valor Final</td>
		</tr>
		<tr>
			<td>FUE:</td>
			<td><%=tiradas[0]%></td>
			<td><%=raza[1]%></td>
			<td><%=tiradas[0] + (int) raza[1]%></td>
		</tr>
		<tr>
			<td>DES:</td>
			<td><%=tiradas[1]%></td>
			<td><%=raza[2]%></td>
			<td><%=tiradas[1] + (int) raza[2]%></td>
		</tr>
		<tr>
			<td>CON:</td>
			<td><%=tiradas[2]%></td>
			<td><%=raza[3]%></td>
			<td><%=tiradas[2] + (int) raza[3]%></td>
		</tr>
		<tr>
			<td>INT:</td>
			<td><%=tiradas[3]%></td>
			<td><%=raza[4]%></td>
			<td><%=tiradas[3] + (int) raza[4]%></td>
		</tr>
		<tr>
			<td>SAB:</td>
			<td><%=tiradas[4]%></td>
			<td><%=raza[5]%></td>
			<td><%=tiradas[4] + (int) raza[5]%></td>
		</tr>
		<tr>
			<td>CAR:</td>
			<td><%=tiradas[5]%></td>
			<td><%=raza[6]%></td>
			<td><%=tiradas[5] + (int) raza[6]%></td>
		</tr>
		<tr>

			<td>P.V(<%=vida%>)
			</td>
			<td colspan="3">
				<table width="<%=vida * 2%>px">
				</table>
			</td>
		</tr>
		<tr>
			<td>P.M(<%=mana%>)
			</td>
			<td colspan="3">
				<table width="<%=mana * 2%>px">
				</table>
			</td>
		</tr>
	</table>
</body>
</html>