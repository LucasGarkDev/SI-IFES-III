<%@ page import="model.domain.Ator, model.application.AplCadastrarAtor" %>
<%
    AplCadastrarAtor aplicacao = (AplCadastrarAtor) application.getAttribute("aplAtor");
    if (aplicacao == null) {
        aplicacao = new AplCadastrarAtor();
        application.setAttribute("aplAtor", aplicacao);
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Ator ator = aplicacao.buscar(id);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Ator</title>
</head>
<body>
    <h2>Editar Ator</h2>
    <form method="post" action="index.jsp">
        <input type="hidden" name="acao" value="alterar">
        <input type="hidden" name="id" value="<%= ator.getId() %>">
        <label>Nome atual:</label> <strong><%= ator.getNome() %></strong><br><br>
        <label>Novo nome:</label>
        <input type="text" name="nome" required><br><br>
        <button type="submit">OK</button>
        <a href="index.jsp"><button type="button">Cancelar</button></a>
    </form>
</body>
</html>
