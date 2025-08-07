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
            String novoNome = request.getParameter("nome");
            aplicacao.atualizar(id, novoNome);
            response.sendRedirect("index.jsp");
            return;
        } else {
            String nome = request.getParameter("nome");
            if (nome != null && !nome.trim().isEmpty()) {
                aplicacao.adicionar(nome.trim());
            }
            response.sendRedirect("index.jsp");
            return;
        }
    }

    if ("excluir".equals(acao)) {
        int id = Integer.parseInt(request.getParameter("id"));
        aplicacao.remover(id);
        response.sendRedirect("index.jsp");
        return;
    }

    List<Ator> lista = aplicacao.listar();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Locadora - Atores</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js"></script>
    <script>
        function confirmarExclusao(id) {
            if (confirm("Deseja realmente excluir este ator?")) {
                window.location.href = "index.jsp?acao=excluir&id=" + id;
            }
        }
    </script>
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
