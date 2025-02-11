/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.example;
import javax.swing.*;
import java.awt.*;
/**
 *
 * @author lucas
 */
public class Home extends javax.swing.JFrame {
    private JPanel conteudoPanel; // Painel para carregar os módulos

    public Home() {
        initComponents();
        inicializarPainel();
    }

    /**
     * Inicializa o painel central onde os módulos serão carregados
     */
    private void inicializarPainel() {
        conteudoPanel = new JPanel();
        conteudoPanel.setLayout(new BorderLayout());
        getContentPane().add(conteudoPanel, BorderLayout.CENTER);

        // Define a tela inicial como Dashboard
        trocarPainel(new DashboardPanel());
    }

    /**
     * Método para trocar os painéis dinamicamente no JFrame
     */
    private void trocarPainel(JPanel novoPainel) {
        conteudoPanel.removeAll();
        conteudoPanel.add(novoPainel, BorderLayout.CENTER);
        conteudoPanel.revalidate();
        conteudoPanel.repaint();
    }

    /**
     * Inicializa os componentes da interface gráfica
     */
    private void initComponents() {
        jMenuBar1 = new javax.swing.JMenuBar();

        // Criando os menus principais
        jMenu1 = new javax.swing.JMenu("Login");
        jMenu2 = new javax.swing.JMenu("Dashboard");
        jMenu3 = new javax.swing.JMenu("Fazendas");
        jMenu4 = new javax.swing.JMenu("Animais");
        jMenu5 = new javax.swing.JMenu("Alimentação");
        jMenu6 = new javax.swing.JMenu("Saúde");
        jMenu7 = new javax.swing.JMenu("Vendas");
        jMenu8 = new javax.swing.JMenu("Relatórios");

        // Adicionando menus à barra de menu
        jMenuBar1.add(jMenu1);
        jMenuBar1.add(jMenu2);
        jMenuBar1.add(jMenu3);
        jMenuBar1.add(jMenu4);
        jMenuBar1.add(jMenu5);
        jMenuBar1.add(jMenu6);
        jMenuBar1.add(jMenu7);
        jMenuBar1.add(jMenu8);

        // Criando submenus para "Fazendas"
        jMenuItem1 = new javax.swing.JMenuItem("Cadastrar Fazenda");
        jMenuItem2 = new javax.swing.JMenuItem("Listar Fazendas");
        jMenuItem1.addActionListener(evt -> trocarPainel(new FazendasPanel()));
        jMenuItem2.addActionListener(evt -> trocarPainel(new ListaFazendasPanel()));
        jMenu3.add(jMenuItem1);
        jMenu3.add(jMenuItem2);

        // Criando submenus para "Animais"
        jMenuItem3 = new javax.swing.JMenuItem("Cadastrar Animal");
        jMenuItem4 = new javax.swing.JMenuItem("Gerir Rebanho");
        jMenuItem3.addActionListener(evt -> trocarPainel(new CadastroAnimalPanel()));
        jMenuItem4.addActionListener(evt -> trocarPainel(new GerenciarRebanhoPanel()));
        jMenu4.add(jMenuItem3);
        jMenu4.add(jMenuItem4);

        // Criando submenus para "Alimentação"
        jMenuItem5 = new javax.swing.JMenuItem("Cadastro de Rações e Dietas");
        jMenuItem6 = new javax.swing.JMenuItem("Gerir Alimentação");
        jMenuItem5.addActionListener(evt -> trocarPainel(new AlimentacaoPanel()));
        jMenuItem6.addActionListener(evt -> trocarPainel(new GerenciarAlimentacaoPanel()));
        jMenu5.add(jMenuItem5);
        jMenu5.add(jMenuItem6);

        // Criando submenus para "Saúde"
        jMenuItem7 = new javax.swing.JMenuItem("Cadastro de Vacinas");
        jMenuItem8 = new javax.swing.JMenuItem("Registros de Aplicação");
        jMenuItem9 = new javax.swing.JMenuItem("Listar Vacinas Pendentes");
        jMenuItem7.addActionListener(evt -> trocarPainel(new CadastroVacinasPanel()));
        jMenuItem8.addActionListener(evt -> trocarPainel(new RegistrosAplicacaoPanel()));
        jMenuItem9.addActionListener(evt -> trocarPainel(new ListarVacinasPanel()));
        jMenu6.add(jMenuItem7);
        jMenu6.add(jMenuItem8);
        jMenu6.add(jMenuItem9);

        // Criando submenus para "Vendas"
        jMenuItem10 = new javax.swing.JMenuItem("Cadastro de Vendas");
        jMenuItem11 = new javax.swing.JMenuItem("Histórico de Vendas");
        jMenuItem10.addActionListener(evt -> trocarPainel(new CadastroVendasPanel()));
        jMenuItem11.addActionListener(evt -> trocarPainel(new HistoricoVendasPanel()));
        jMenu7.add(jMenuItem10);
        jMenu7.add(jMenuItem11);

        setJMenuBar(jMenuBar1);
        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("FarmSim - Home");
        setSize(1100, 600);
        setLocationRelativeTo(null);
    }

    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(() -> new Home().setVisible(true));
    }

    // Declaração de variáveis
    private javax.swing.JMenu jMenu1, jMenu2, jMenu3, jMenu4, jMenu5, jMenu6, jMenu7, jMenu8;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JMenuItem jMenuItem1, jMenuItem2, jMenuItem3, jMenuItem4;
    private javax.swing.JMenuItem jMenuItem5, jMenuItem6, jMenuItem7, jMenuItem8, jMenuItem9;
    private javax.swing.JMenuItem jMenuItem10, jMenuItem11;

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jMenu10 = new javax.swing.JMenu();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();
        jMenu2 = new javax.swing.JMenu();
        jMenu9 = new javax.swing.JMenu();
        jMenu11 = new javax.swing.JMenu();
        jMenu12 = new javax.swing.JMenu();
        jMenu13 = new javax.swing.JMenu();
        jMenu14 = new javax.swing.JMenu();
        jMenu15 = new javax.swing.JMenu();

        jMenu10.setText("jMenu10");

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jMenu1.setText("Login");
        jMenuBar1.add(jMenu1);

        jMenu2.setText("Dashboard");
        jMenuBar1.add(jMenu2);

        jMenu9.setText("Fazendas");
        jMenuBar1.add(jMenu9);

        jMenu11.setText("Animais");
        jMenuBar1.add(jMenu11);

        jMenu12.setText("Alimentação");
        jMenuBar1.add(jMenu12);

        jMenu13.setText("Saúde");
        jMenuBar1.add(jMenu13);

        jMenu14.setText("Vendas");
        jMenuBar1.add(jMenu14);

        jMenu15.setText("Relatórios");
        jMenuBar1.add(jMenu15);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 936, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 428, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Home.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Home.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Home.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Home.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Home().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenu jMenu10;
    private javax.swing.JMenu jMenu11;
    private javax.swing.JMenu jMenu12;
    private javax.swing.JMenu jMenu13;
    private javax.swing.JMenu jMenu14;
    private javax.swing.JMenu jMenu15;
    private javax.swing.JMenu jMenu2;
    private javax.swing.JMenu jMenu9;
    private javax.swing.JMenuBar jMenuBar1;
    // End of variables declaration//GEN-END:variables
}
