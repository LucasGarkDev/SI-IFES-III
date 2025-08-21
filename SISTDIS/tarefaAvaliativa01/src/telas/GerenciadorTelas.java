/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package telas;

/**
 *
 * @author lucas
 */
public class GerenciadorTelas {
    private static String nomeUsuario;

    public static void iniciar() {
        TelaEntrada telaEntrada = new TelaEntrada();
        telaEntrada.setVisible(true);
    }

    public static void entrarNoChat(String nome) {
        nomeUsuario = nome;
        TelaChat telaChat = new TelaChat(nomeUsuario);
        telaChat.setVisible(true);
    }

    public static String getNomeUsuario() {
        return nomeUsuario;
    }
}
