/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.google.protobuf.TextFormat.ParseException;
import controller.GenericTableModel;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFormattedTextField;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JSpinner;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author lucas
 */
public class Util {
    
    
    /** =========================
     * MÉTODOS PARA TEXTFIELD
     * ========================= */

    public static String getTexto(JTextField txt) {
        return txt.getText().trim();
    }

    public static void setTexto(JTextField txt, String valor) {
        txt.setText(valor);
    }

    public static int getInt(JTextField txt) {
        return Integer.parseInt(txt.getText().trim());
    }

    public static float getFloat(JTextField txt) {
        return Float.parseFloat(txt.getText().trim());
    }

    /** =========================
     * FORMATTED TEXT FIELD
     * ========================= */

    public static String getTexto(JFormattedTextField txt) {
        return txt.getText().trim();
    }

    public static void setTexto(JFormattedTextField txt, String valor) {
        txt.setText(valor);
    }

    /** =========================
     * SPINNER
     * ========================= */

    public static int getValorSpinner(JSpinner spinner) {
        return (Integer) spinner.getValue();
    }

    public static void setValorSpinner(JSpinner spinner, int valor) {
        spinner.setValue(valor);
    }

    /** =========================
     * CHECKBOX
     * ========================= */

    public static boolean isMarcado(JCheckBox chk) {
        return chk.isSelected();
    }

    public static void setMarcado(JCheckBox chk, boolean valor) {
        chk.setSelected(valor);
    }

    /** =========================
     * COMBOBOX
     * ========================= */

    public static <T> void carregarCombo(JComboBox<T> combo, List<T> lista) {
        combo.removeAllItems();
        for (T item : lista) {
            combo.addItem(item);
        }
    }

    public static <T> T getSelecionado(JComboBox<T> combo) {
        return (T) combo.getSelectedItem();
    }

    public static <T> void setSelecionado(JComboBox<T> combo, T item) {
        combo.setSelectedItem(item);
    }

    /** =========================
     * JLIST
     * ========================= */

    public static <T> void carregarLista(JList<T> lista, List<T> dados) {
        DefaultListModel<T> modelo = new DefaultListModel<>();
        for (T d : dados) {
            modelo.addElement(d);
        }
        lista.setModel(modelo);
    }

    public static <T> T getSelecionado(JList<T> lista) {
        return lista.getSelectedValue();
    }

    /** =========================
     * LABEL
     * ========================= */

    public static void setTexto(JLabel lbl, String texto) {
        lbl.setText(texto);
    }

    /** =========================
     * BOTÃO (usado para estado)
     * ========================= */

    public static void habilitar(JButton botao, boolean habilitado) {
        botao.setEnabled(habilitado);
    }

    public static void mudarTexto(JButton botao, String texto) {
        botao.setText(texto);
    }

    /** =========================
     * FORMATAR STRING (capitalize, útil pro GenericTableModel)
     * ========================= */

    public static String capitalize(String str) {
        if (str == null || str.isEmpty()) return str;
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }
    
    
    /**
     * Método genérico para carregar objetos em um JComboBox
     */
    public static <T> void preencherComboBox(JComboBox<T> combo, List<T> lista) {
        combo.removeAllItems();
        for (T item : lista) {
            combo.addItem(item);
        }
    }
    

    // Seleciona um item no comboBox com base no ID
    public static <T> void selecionarItemPorId(JComboBox<T> combo, int id) {
        for (int i = 0; i < combo.getItemCount(); i++) {
            T item = combo.getItemAt(i);
            try {
                int idItem = (int) item.getClass().getMethod("getId" + item.getClass().getSimpleName()).invoke(item);
                if (idItem == id) {
                    combo.setSelectedIndex(i);
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    // ==== LISTAGEM EM JTable COM GenericTableModel ====
    public static <T> void listarEmTabela(JTable tabela, List<T> dados, String[] colunas, String[] atributos) {
        GenericTableModel<T> model = new GenericTableModel<>(colunas, atributos);
        model.setLista(dados);
        tabela.setModel(model);
    }

    // ==== LISTAGEM EM JComboBox ====
//    public static <T> void preencherComboBox(JComboBox<T> combo, List<T> dados) {
//        combo.removeAllItems();
//        for (T item : dados) {
//            combo.addItem(item);
//        }
//    }

    // ==== LISTAGEM EM JList ====
    public static <T> void preencherJList(JList<T> lista, List<T> dados) {
        DefaultListModel<T> model = new DefaultListModel<>();
        for (T item : dados) {
            model.addElement(item);
        }
        lista.setModel(model);
    }

    // ==== LISTAGEM EM JTextArea ====
    public static <T> void listarEmTextArea(JTextArea area, List<T> dados) {
        area.setText("");
        for (T item : dados) {
            area.append(item.toString() + "\n");
        }
    }

    // ==== LISTAGEM VIA System.out.println (debug ou fallback) ====
    public static <T> void listarNoConsole(List<T> dados) {
        System.out.println("=== LISTAGEM VIA CONSOLE ===");
        for (T item : dados) {
            System.out.println(item);
        }
        System.out.println("=============================");
    }

    // ==== LISTAGEM EM JTable FIXO (sem GenericTableModel) ====
    public static void listarEmTabelaFixa(JTable tabela, Object[][] dados, String[] colunas) {
        DefaultTableModel model = new DefaultTableModel(dados, colunas);
        tabela.setModel(model);
    }

    // ==== SELECIONAR ITEM NO COMBO POR ID ====
//    public static <T> void selecionarItemPorId(JComboBox<T> combo, int id) {
//        for (int i = 0; i < combo.getItemCount(); i++) {
//            T item = combo.getItemAt(i);
//            try {
//                int itemId = (int) item.getClass().getMethod("getId" + item.getClass().getSimpleName()).invoke(item);
//                if (itemId == id) {
//                    combo.setSelectedIndex(i);
//                    break;
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//    
    
    
//    // Em um botão "Listar Todos"
//private void btnListarTodosActionPerformed(java.awt.event.ActionEvent evt) {
//    try {
//        List<Produto> produtos = gerenciadorInterface.getDominio().listarTodosProdutos();
//
//        // Modo JTable com GenericTableModel
//        Util.listarEmTabela(jTable3, produtos,
//            new String[]{"ID", "Nome", "Qtd", "Preço", "Categoria"},
//            new String[]{"idProduto", "nome", "quantidade", "preco", "categoria.descricao"});
//
//        // Ou modo JList (caso use)
//        // Util.preencherJList(minhaJList, produtos);
//
//    } catch (Exception ex) {
//        ex.printStackTrace();
//        JOptionPane.showMessageDialog(this, "Erro ao listar produtos: " + ex.getMessage());
//    }
//}
    
     // ================================
    // 🎯 Conversão de Strings e Números
    // ================================

    public static int toInt(String valor) {
        try {
            return Integer.parseInt(valor.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public static float toFloat(String valor) {
        try {
            return Float.parseFloat(valor.trim());
        } catch (NumberFormatException e) {
            return 0f;
        }
    }

    public static String intToString(int valor) {
        return String.valueOf(valor);
    }

    public static String floatToString(float valor) {
        return String.format("%.2f", valor);
    }

    // ================================
    // 📅 Conversão de Datas
    // ================================

    public static Date toDate(String dataStr) throws java.text.ParseException {
        return (Date) new SimpleDateFormat("dd/MM/yyyy").parse(dataStr);
    }

    public static String dateToString(Date data) {
        return new SimpleDateFormat("dd/MM/yyyy").format(data);
    }

    
    // ================================
    // 🔄 Conversão de componentes Swing
    // ================================

    

    // ================================
    // ✅ Validação simples
    // ================================

    public static boolean isCampoVazio(JTextField campo) {
        return campo.getText().trim().isEmpty();
    }

    public static boolean isSelecionado(JComboBox<?> combo) {
        return combo.getSelectedItem() != null;
    }

}
