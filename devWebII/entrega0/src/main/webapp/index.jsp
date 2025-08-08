<%@ page import="java.util.*, model.domain.Ator, model.application.AplCadastrarAtor" %>
<%
    AplCadastrarAtor aplicacao = (AplCadastrarAtor) application.getAttribute("aplAtor");
    if (aplicacao == null) {
        aplicacao = new AplCadastrarAtor();
        application.setAttribute("aplAtor", aplicacao);
    }

    String acao = request.getParameter("acao");
    String metodo = request.getMethod();

    if ("POST".equalsIgnoreCase(metodo)) {
        if ("alterar".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            aplicacao.atualizarAtor(id, nome); // ? nome correto do m�todo
        } else {
            String nome = request.getParameter("nome");
            aplicacao.adicionarAtor(nome); // ? nome correto
        }
        response.sendRedirect("index.jsp");
        return;
    }

    if ("excluir".equals(acao)) {
        int id = Integer.parseInt(request.getParameter("id"));
        aplicacao.removerAtor(id); // ? nome correto
        response.sendRedirect("index.jsp");
        return;
    }

    List<Ator> lista = aplicacao.listarAtores(); // ? nome correto
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Locadora - Atores</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js"></script>
</head>
<body>
    <header>
        <h1>Locadora Passatempo</h1>
    </header>

    <aside>
        <ul>
            <li><strong>&#9656; Atores</strong></li>
        </ul>
    </aside>

    <main>
        <h2>Cadastro de Ator</h2>
        <form method="post" action="index.jsp">
            <input type="hidden" name="acao" value="inserir">
            <label for="nome">Nome do Ator:</label>
            <input type="text" id="nome" name="nome" required>
            <button type="submit">OK</button>
            <button type="reset">Reset</button>
        </form>

        <h2>Lista de Atores</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% for (Ator ator : lista) { %>
                    <tr>
                        <td><%= ator.getId() %></td>
                        <td><%= ator.getNome() %></td>
                        <td>
                            <a href="editarAtor.jsp?id=<%= ator.getId() %>">Alterar</a> |
                            <a href="javascript:void(0);" onclick="confirmarExclusao(<%= ator.getId() %>)">Excluir</a>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>
