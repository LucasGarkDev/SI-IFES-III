/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package app;

import server.MatrizAvaliacao;
import server.ServidorRingo;
/**
 *
 * @author lucas
 */
public class MainServidor {
    public static void main(String[] args) {
        try {
            System.out.println("=== Servidor Ringo ===");
            MatrizAvaliacao base = new MatrizAvaliacao();
            ServidorRingo servidor = new ServidorRingo(base);
            servidor.iniciar();
        } catch (Exception e) {
            System.err.println("[MainServidor] Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
