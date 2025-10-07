/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package app;

import agent.Agente;
import java.util.Scanner;
/**
 *
 * @author lucas
 */
public class MainAgente {
    public static void main(String[] args) {
        try {
            Scanner sc = new Scanner(System.in);
            System.out.print("Digite o ID do usuário (0..4): ");
            int idUsuario = sc.nextInt();
            System.out.println("=== Iniciando Agente " + idUsuario + " ===");

            Agente agente = new Agente(idUsuario);
            agente.iniciar();
        } catch (Exception e) {
            System.err.println("[MainAgente] Erro: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
