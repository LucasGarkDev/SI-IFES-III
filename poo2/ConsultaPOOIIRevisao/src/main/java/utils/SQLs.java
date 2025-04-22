/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author lucas
 */
public class SQLs {
    // ===== PRODUTO =====

    public static final String PRODUTO_INSERIR = 
        "INSERT INTO Produto (nome, quantidade, preco, idCategoria) VALUES (?, ?, ?, ?)";

    public static final String PRODUTO_BUSCAR_POR_ID = 
        "SELECT * FROM Produto WHERE idProduto = ?";

    public static final String PRODUTO_LISTAR_TODOS = 
        "SELECT * FROM Produto";

    public static final String PRODUTO_LISTAR_ESTOQUE_BAIXO = 
        "SELECT * FROM Produto WHERE quantidade < ?";

    public static final String PRODUTO_LISTAR_POR_CATEGORIA = 
        "SELECT * FROM Produto WHERE idCategoria = ?";

    public static final String PRODUTO_LISTAR_POR_NOME = 
        "SELECT * FROM Produto WHERE nome LIKE ?";

    public static final String PRODUTO_LISTAR_POR_FAIXA_PRECO = 
        "SELECT * FROM Produto WHERE preco BETWEEN ? AND ?";

    public static final String PRODUTO_LISTAR_ULTIMOS_10 = 
        "SELECT * FROM Produto ORDER BY idProduto DESC LIMIT 10";

    public static final String PRODUTO_LISTAR_PRIMEIROS_10 = 
        "SELECT * FROM Produto ORDER BY idProduto ASC LIMIT 10";

    public static final String PRODUTO_ATUALIZAR = 
        "UPDATE Produto SET nome = ?, quantidade = ?, preco = ?, idCategoria = ? WHERE idProduto = ?";

    public static final String PRODUTO_DELETAR = 
        "DELETE FROM Produto WHERE idProduto = ?";

    // ===== CATEGORIA =====

    public static final String CATEGORIA_INSERIR = 
        "INSERT INTO Categoria (descricao) VALUES (?)";

    public static final String CATEGORIA_LISTAR_TODAS = 
        "SELECT * FROM Categoria";

    public static final String CATEGORIA_BUSCAR_POR_ID = 
        "SELECT * FROM Categoria WHERE idCategoria = ?";

    public static final String CATEGORIA_BUSCAR_POR_NOME = 
        "SELECT * FROM Categoria WHERE descricao LIKE ?";

    // ===== JUNÇÕES (INNER JOIN) =====

    public static final String PRODUTO_POR_CATEGORIA_DESCRICAO = 
        "SELECT P.* FROM Produto P JOIN Categoria C ON P.idCategoria = C.idCategoria " +
        "WHERE C.descricao = ?";

    // ===== OUTROS EXEMPLOS =====

    public static final String CONTAR_PRODUTOS = 
        "SELECT COUNT(*) FROM Produto";

    
    // =========================
    // PRODUTO + CATEGORIA
    // =========================

    // Lista todos os produtos com o nome da categoria (JOIN direto)
    public static final String PRODUTO_COM_CATEGORIA =
        "SELECT P.idProduto, P.nome, P.quantidade, P.preco, " +
        "C.idCategoria, C.descricao AS nomeCategoria " +
        "FROM Produto P " +
        "JOIN Categoria C ON P.idCategoria = C.idCategoria";

    // Filtra produtos por descrição da categoria (útil em pesquisa por nome da categoria)
    public static final String PRODUTO_POR_DESCRICAO_CATEGORIA =
        "SELECT P.* FROM Produto P " +
        "JOIN Categoria C ON P.idCategoria = C.idCategoria " +
        "WHERE C.descricao LIKE ?";

    // Traz produto por ID com os dados completos da categoria (bom para detalhar)
    public static final String PRODUTO_POR_ID_COM_CATEGORIA =
        "SELECT P.idProduto, P.nome, P.quantidade, P.preco, " +
        "C.idCategoria, C.descricao AS nomeCategoria " +
        "FROM Produto P " +
        "JOIN Categoria C ON P.idCategoria = C.idCategoria " +
        "WHERE P.idProduto = ?";

    // Conta quantos produtos tem por categoria (relatório geral)
    public static final String CONTAR_PRODUTOS_POR_CATEGORIA =
        "SELECT C.descricao, COUNT(*) AS totalProdutos " +
        "FROM Produto P " +
        "JOIN Categoria C ON P.idCategoria = C.idCategoria " +
        "GROUP BY C.descricao";

    // =========================
    // CASO GENÉRICO — JOIN MODELO
    // =========================

    // JOIN genérico entre duas tabelas com FK (usável como base para outras entidades)
    public static final String MODELO_JOIN_ENTIDADE_FK =
        "SELECT A.*, B.nome AS nomeFK " +
        "FROM Entidade A " +
        "JOIN OutraEntidade B ON A.idOutraEntidade = B.idOutraEntidade";
}
