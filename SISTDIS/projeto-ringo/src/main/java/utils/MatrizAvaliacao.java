/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author lucas
 */
public class MatrizAvaliacao {
    private int[][] matriz = new int[5][20]; // 5 usuários, 20 artistas

    public synchronized int[] getLinha(int idUsuario) {
        return matriz[idUsuario].clone(); // retorna cópia da linha
    }

    public synchronized void atualizarLinha(int idUsuario, int[] novaLinha) {
        if (novaLinha.length == 20) {
            matriz[idUsuario] = novaLinha.clone(); // substitui a linha
        }
    }
}
