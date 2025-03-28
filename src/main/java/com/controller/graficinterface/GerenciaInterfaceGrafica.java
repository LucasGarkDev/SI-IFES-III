/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controller.graficinterface;

import com.controller.controll.GerenciaDominio;
import com.viewer.CadastrarBovino;
import com.viewer.GerenciarFazenda;
import com.viewer.GerenciarMovimentacao;
import com.viewer.Home;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;

/**
 *
 * @author lucas
 */
public class GerenciaInterfaceGrafica {
    private static GerenciaInterfaceGrafica instance; // Singleton

    private JFrame telaAtual; // Armazena a tela atualmente visível
    private Home homeFrame;
    private GerenciarFazenda fazendaFrame;
    private GerenciarMovimentacao movimentacaoFrame;
    private CadastrarBovino bovinoFrame;

    // Construtor privado para evitar instâncias externas
    private GerenciaInterfaceGrafica() {}

    // Método para obter a instância única (Singleton)
    public static GerenciaInterfaceGrafica getInstance() {
        if (instance == null) {
            instance = new GerenciaInterfaceGrafica();
        }
        return instance;
    }

    // Método para abrir uma tela específica
    public void abrirTela(String nomeTela) {
        JFrame novaTela = null;

        switch (nomeTela) {
            case "Home":
                if (homeFrame == null) homeFrame = new Home();
                novaTela = homeFrame;
                break;
            case "GerenciarFazenda":
                if (fazendaFrame == null) fazendaFrame = new GerenciarFazenda();
                novaTela = fazendaFrame;
                break;
            case "GerenciarMovimentacao":
                if (movimentacaoFrame == null) movimentacaoFrame = new GerenciarMovimentacao();
                novaTela = movimentacaoFrame;
                break;
            case "CadastrarBovino":
                if (bovinoFrame == null) bovinoFrame = new CadastrarBovino();
                novaTela = bovinoFrame;
                break;
            default:
                System.out.println("Tela inválida: " + nomeTela);
                return;
        }

        if (telaAtual != null) {
            telaAtual.setVisible(false); // Esconder a tela atual
        }

        telaAtual = novaTela;
        telaAtual.setVisible(true);
    }

    public void definirTema(String tema) {
        try {
            String lookAndFeel = null;

            // Verifica se o tema desejado está disponível no sistema
            for (UIManager.LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
                if ("GTK+".equals(tema) && info.getName().contains("GTK")) {
                    lookAndFeel = info.getClassName();
                } else if ("Windows".equals(tema) && info.getName().contains("Windows")) {
                    lookAndFeel = info.getClassName();
                }
            }

            // Aplica o tema se foi encontrado
            if (lookAndFeel != null) {
                UIManager.setLookAndFeel(lookAndFeel);
            } else {
                //JOptionPane.showMessageDialog(null, "O tema " + tema + " não está disponível no sistema!", "Erro", JOptionPane.ERROR_MESSAGE);
                return;
            }

            // Atualiza os componentes gráficos (se uma janela estiver aberta)
            if (telaAtual != null) {
                SwingUtilities.updateComponentTreeUI(telaAtual);
                telaAtual.pack(); // Ajusta o layout
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Erro ao trocar o tema para " + tema, "Erro", JOptionPane.ERROR_MESSAGE);
            e.printStackTrace();
        }
    }

    
    // Método para iniciar o sistema com a tela principal
    public void iniciar() {
        definirTema("Windows"); // Define um tema inicial (ajuste se necessário)
        telaAtual = new Home(); // Define a tela principal no gerenciador
        telaAtual.setVisible(true); 
    }

    public static void main(String[] args) {
       // Inicializar o sistema chamando o Singleton
        // Inicializa o domínio (e verifica a conexão)
//        GerenciaDominio dominio = new GerenciaDominio();

        // Se passou daqui, a conexão foi bem-sucedida, então iniciamos a interface
        GerenciaInterfaceGrafica.getInstance().iniciar();
    }
}
