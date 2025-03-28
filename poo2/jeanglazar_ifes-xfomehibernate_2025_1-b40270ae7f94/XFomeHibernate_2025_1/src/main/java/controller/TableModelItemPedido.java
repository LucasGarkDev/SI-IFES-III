package controller;


import domain.ItemPedido;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author 1547816
 */
public class TableModelItemPedido extends AbstractTableModel {

    private List listaItens  = new ArrayList();  

    @Override
    public int getColumnCount() {
        return 7;   // Quantidade de colunas da TABELA
    }
    
    @Override
    public int getRowCount() {
        return listaItens.size();
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        
        ItemPedido item = (ItemPedido) listaItens.get(rowIndex);
        switch ( columnIndex ) {
            case 0: return item.getLanche();
            case 1: return item.getQtde();
            case 2: return item.getMaisBife();
            case 3: return item.getMaisOvo();
            case 4: return item.getMaisPresunto();
            case 5: return item.getMaisQueijo();
            case 6: return item.getIngredientes();            
        }
        return null;
    }

    @Override
    public String getColumnName(int column) {
        String nomes[] = {"Lanche", "Qtde", "Bife", "Ovo", "Presunto", "Queijo", "Ingredientes" };
        return nomes[column];
    }
    
    
    public Object getItem (int rowIndex) {
        return listaItens.get(rowIndex);        
    }
    
    public void adicionar (Object obj) {
        listaItens.add(obj);
        fireTableRowsInserted( listaItens.size() - 1, listaItens.size() - 1 );
        
    }
    
    public void remover (int indice) {
        listaItens.remove(indice);
        fireTableRowsDeleted( indice, indice );
        
    }
    
    public void setLista(List novaLista) {
        if ( novaLista == null || novaLista.isEmpty()) {
            if ( !listaItens.isEmpty() ) {
                listaItens.clear();
                fireTableRowsDeleted(0,0);
            }
        } else {
            listaItens = novaLista;
            fireTableRowsInserted( 0, listaItens.size() - 1);
        }
        
    }
    
    public List getLista() {
        return listaItens;
    }
              
}
