<%-- 
    Document   : ListagemAtores
    Created on : 7 de ago. de 2025, 06:37:34
    Author     : lucas
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.domain.Ator" %>
<%
    List<Ator> lista = (List<Ator>) request.getAttribute("listaAtores");
%>
<html>
<head>
    <title>Lista de Atores</title>
</head>
<body>
    <h2>Atores Cadastrados</h2>
    <ul>
        <%
            if (lista != null && !lista.isEmpty()) {
                for (Ator ator : lista) {
        %>
                    <li><%= ator.getId() %> - <%= ator.getNome() %></li>
        <%
                }
            } else {
        %>
            <li>Nenhum ator cadastrado.</li>
        <%
            }
        %>
    </ul>
    <br>
    <a href="FormCadastrarAtor.html">Cadastrar Novo Ator</a>
</body>
</html>
