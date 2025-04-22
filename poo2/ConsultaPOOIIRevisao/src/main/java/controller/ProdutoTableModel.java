/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import domain.Produto;
import java.util.List;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author lucas
 */
public class ProdutoTableModel extends AbstractTableModel{

    private List<Produto> produtos;
    private final String[] colunas = {"ID", "Nome", "Quantidade", "Preço", "Categoria"};

    public ProdutoTableModel(List<Produto> produtos) {
        this.produtos = produtos;
    }

    @Override
    public int getRowCount() {
        return produtos.size();
    }

    @Override
    public int getColumnCount() {
        return colunas.length;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Produto p = produtos.get(rowIndex);
        return switch (columnIndex) {
            case 0 -> p.getIdProduto();
            case 1 -> p.getNome();
            case 2 -> p.getQuantidade();
            case 3 -> p.getPreco();
            case 4 -> p.getCategoria().getDescricao();
            default -> null;
        };
    }

    @Override
    public String getColumnName(int column) {
        return colunas[column];
    }
    
}
