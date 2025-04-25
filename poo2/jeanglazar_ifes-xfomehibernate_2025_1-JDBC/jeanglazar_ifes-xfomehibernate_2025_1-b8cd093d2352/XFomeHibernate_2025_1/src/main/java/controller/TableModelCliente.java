package controller;


import domain.Cliente;
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
public class TableModelCliente extends AbstractTableModel {

    private List lista  = new ArrayList();  

    @Override
    public int getColumnCount() {
        return 6;   // Quantidade de colunas da TABELA
    }
    
    @Override
    public int getRowCount() {
        return lista.size();
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        
        Cliente cli = (Cliente) lista.get(rowIndex);
        switch ( columnIndex ) {
            case 0: return cli.getNome();
            case 1: return cli.getEndereco().getBairro();
            case 2: return cli.getCidade().getNome();
            case 3: return cli.getDtNascFormatada();
            case 4: return cli.getCelular();
            case 5: return cli.getFoto();

        }
        return null;
    }

    @Override
    public String getColumnName(int column) {
        String nomes[] = {"Nome", "Bairro", "Cidade", "DT. NASC.", "Celular", "Foto" };
        return nomes[column];
    }
    
    
    public Object getItem (int rowIndex) {
        return lista.get(rowIndex);        
    }
    
    public void adicionar (Object obj) {
        lista.add(obj);
        fireTableRowsInserted( lista.size() - 1, lista.size() - 1 );
        
    }
    
    public void remover (int indice) {
        lista.remove(indice);
        fireTableRowsDeleted( indice, indice );
        
    }
    
    public void setLista(List novaLista) {
        if ( novaLista == null || novaLista.isEmpty()) {
            if ( !lista.isEmpty() ) {
                lista.clear();
                fireTableRowsDeleted(0,0);
            }
        } else {
            lista = novaLista;
            fireTableRowsInserted( 0, lista.size() - 1);
        }
        
    }
    
    public List getLista() {
        return lista;
    }
              
}
