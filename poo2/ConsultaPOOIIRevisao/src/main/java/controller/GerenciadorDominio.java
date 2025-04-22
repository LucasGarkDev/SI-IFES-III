/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CategoriaDAO;
import dao.ProdutoDAO;
import domain.Categoria;
import domain.Produto;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author lucas
 */
public class GerenciadorDominio {
    private ProdutoDAO produtoDAO;
    private CategoriaDAO categoriaDAO;

    public GerenciadorDominio() {
        this.produtoDAO = new ProdutoDAO();
        this.categoriaDAO = new CategoriaDAO();
    }

    // === Métodos para Produto ===
    public void inserirProduto(Produto p) throws SQLException, Exception {
        produtoDAO.inserir(p);
    }

    public Produto pesquisarProduto(int id) throws SQLException, Exception {
        return produtoDAO.buscar(id);
    }

    public void alterarProduto(Produto p) throws SQLException, Exception {
        produtoDAO.alterar(p);
    }

    public List<Produto> listarTodosProdutos() throws SQLException, Exception {
        return produtoDAO.listarTodos();
    }

    public List<Produto> listarProdutosPorCategoria(Categoria cat) throws SQLException, Exception {
        return produtoDAO.listarPorCategoria(cat);
    }

    public List<Produto> listarEstoque(int limite) throws SQLException, Exception {
        return produtoDAO.listarPorEstoque(limite);
    }

    // === Métodos para Categoria ===
    public void inserirCategoria(Categoria c) throws Exception {
        categoriaDAO.inserir(c);
    }

    public List<Categoria> listarCategorias() {
        try {
            return categoriaDAO.listarTodos();
        } catch (Exception ex) {
            ex.printStackTrace();
            return Collections.emptyList();
        }
    }
}
