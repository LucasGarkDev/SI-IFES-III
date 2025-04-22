/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;
import utils.Util;
import static utils.Util.capitalize;

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
            return getNestedAttributeValue(obj, atributos[columnIndex]); // usa o método certo
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

    // 🌟 Novo: acessa atributos com "categoria.descricao"
    private Object getNestedAttributeValue(Object obj, String atributo) throws Exception {
        String[] partes = atributo.split("\\.");
        Object valor = obj;

        for (String parte : partes) {
            if (valor == null) return null;

            String metodo = "get" + Util.capitalize(parte);
            Method getter = valor.getClass().getMethod(metodo);
            valor = getter.invoke(valor);
        }

        return valor;
    }
    
}
