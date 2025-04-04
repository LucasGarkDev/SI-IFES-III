/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author lucas
 */
public class GenericTableModel<T> extends AbstractTableModel {
    private List<T> listaObjetos = new ArrayList<>();
    private String[] colunas;
    private String[] atributos;

    public GenericTableModel(String[] colunas, String[] atributos) {
        this.colunas = colunas;
        this.atributos = atributos;
    }

    @Override
    public int getColumnCount() {
        return colunas.length;
    }

    @Override
    public int getRowCount() {
        return listaObjetos.size();
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        T obj = listaObjetos.get(rowIndex);
        try {
            Method metodo = obj.getClass().getMethod("get" + capitalize(atributos[columnIndex]));
            return metodo.invoke(obj);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String getColumnName(int column) {
        return colunas[column];
    }

    public void adicionar(T obj) {
        listaObjetos.add(obj);
        fireTableRowsInserted(listaObjetos.size() - 1, listaObjetos.size() - 1);
    }

    public void remover(int indice) {
        listaObjetos.remove(indice);
        fireTableRowsDeleted(indice, indice);
    }

    public void setLista(List<T> novaLista) {
        listaObjetos = novaLista;
        fireTableDataChanged();
    }

    public List<T> getLista() {
        return listaObjetos;
    }

    private String capitalize(String str) {
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
    
    
    
}
