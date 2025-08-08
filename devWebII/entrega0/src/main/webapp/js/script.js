function confirmarExclusao(id) {
    if (confirm("Deseja realmente excluir este ator?")) {
        window.location.href = "index.jsp?acao=excluir&id=" + id;
    }
}