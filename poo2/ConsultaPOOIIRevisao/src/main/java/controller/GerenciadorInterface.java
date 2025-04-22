/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import javax.swing.JDialog;
import javax.swing.JFrame;
import viewer.ProdutoMain;

/**
 *
 * @author lucas
 */
public class GerenciadorInterface {
    private GerenciadorDominio dominio;
    private ProdutoMain janelaPrincipal;
//    private JFrame janelaAtual;

    public GerenciadorInterface() {
        this.dominio = new GerenciadorDominio();
        this.janelaPrincipal = new ProdutoMain(this); // passa o gerenciador para a janela
        this.janelaPrincipal.setVisible(true);
    }

    public GerenciadorDominio getDominio() {
        return dominio;
    }

    public static void main(String[] args) {
        // Configuração opcional de aparência
        try {
            javax.swing.UIManager.setLookAndFeel(javax.swing.UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Executa a interface
        java.awt.EventQueue.invokeLater(() -> {
            new GerenciadorInterface();
        });
    }
    
//    /**
//     * Abre uma nova janela (JFrame) e oculta a atual.
//     * Quando a nova for fechada, reabre a anterior.
//     */
//    public void trocarJanela(JFrame novaJanela) {
//        JFrame anterior = this.janelaAtual;
//
//        // Oculta a atual
//        if (anterior != null) {
//            anterior.setVisible(false);
//        }
//
//        // Atualiza e mostra a nova
//        this.janelaAtual = novaJanela;
//        novaJanela.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
//        novaJanela.setVisible(true);
//
//        // Reexibe a janela anterior ao fechar a nova
//        novaJanela.addWindowListener(new java.awt.event.WindowAdapter() {
//            @Override
//            public void windowClosed(java.awt.event.WindowEvent e) {
//                if (anterior != null) {
//                    anterior.setVisible(true);
//                }
//            }
//        });
//    }
//
//    /**
//     * Abre uma janela de diálogo modal (JDialog) vinculada à janela atual.
//     */
//    public void abrirDialog(JDialog dialog) {
//        dialog.setLocationRelativeTo(janelaAtual);
//        dialog.setModal(true);
//        dialog.setVisible(true);
//    }
//
//    /**
//     * Retorna a janela atual (pode ser útil para passar como pai em novos frames/dialogs).
//     */
//    public JFrame getJanelaAtual() {
//        return janelaAtual;
//    }
//    
//    💡 Como usar na prática?
//▶️ 1. Trocar entre telas (duas JFrame)
//
//btnIrParaTela2.addActionListener(e -> {
//    Tela2 nova = new Tela2(gerenciadorInterface);
//    gerenciadorInterface.trocarJanela(nova);
//});
//▶️ 2. Abrir um JDialog modal
//
//btnDetalhes.addActionListener(e -> {
//    ProdutoDialog dialog = new ProdutoDialog(gerenciadorInterface.getJanelaAtual(), produtoSelecionado);
//    gerenciadorInterface.abrirDialog(dialog);
//});
    
}
