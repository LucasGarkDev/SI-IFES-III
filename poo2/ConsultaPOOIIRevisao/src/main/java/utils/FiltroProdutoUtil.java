/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import dao.ProdutoDAO;
import domain.Categoria;
import domain.Produto;
import java.util.List;

/**
 *
 * @author lucas
 */
public class FiltroProdutoUtil {
     private static final ProdutoDAO produtoDAO = new ProdutoDAO();

    // 🔍 Busca por nome que começa com...
    public static List<Produto> listarPorNome(String nome) throws Exception {
        String sql = "SELECT * FROM Produto WHERE nome LIKE ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> stmt.setString(1, nome + "%"));
    }

    // 🏷️ Listar por categoria
    public static List<Produto> listarPorCategoria(Categoria categoria) throws Exception {
        String sql = "SELECT * FROM Produto WHERE idCategoria = ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> stmt.setInt(1, categoria.getIdCategoria()));
    }

    // 🕒 Mais recentes
    public static List<Produto> listarMaisRecentes(int limite) throws Exception {
        String sql = "SELECT * FROM Produto ORDER BY idProduto DESC LIMIT ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> stmt.setInt(1, limite));
    }

    // 💲 Mais baratos
    public static List<Produto> listarMaisBaratos(int limite) throws Exception {
        String sql = "SELECT * FROM Produto ORDER BY preco ASC LIMIT ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> stmt.setInt(1, limite));
    }

    // 🔢 Quantidade abaixo de limite
    public static List<Produto> listarPorQuantidadeMenorQue(int limite) throws Exception {
        String sql = "SELECT * FROM Produto WHERE quantidade < ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> stmt.setInt(1, limite));
    }

    // 💲 Entre faixas de preço
    public static List<Produto> listarPorFaixaDePreco(float minimo, float maximo) throws Exception {
        String sql = "SELECT * FROM Produto WHERE preco BETWEEN ? AND ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> {
            stmt.setFloat(1, minimo);
            stmt.setFloat(2, maximo);
        });
    }

    // 🔠 Produtos que começam com determinada letra
    public static List<Produto> listarPorInicial(char letra) throws Exception {
        String sql = "SELECT * FROM Produto WHERE nome LIKE ?";
        return produtoDAO.executarQueryPersonalizada(sql, stmt -> stmt.setString(1, letra + "%"));
    }
}
