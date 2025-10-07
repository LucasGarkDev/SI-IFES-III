/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package server;

import common.Constantes;

/**
 *
 * @author lucas
 */
public class MatrizAvaliacao {
    private final int[][] matriz;

    public MatrizAvaliacao() {
        this.matriz = new int[Constantes.NUM_USUARIOS][Constantes.NUM_ARTISTAS];
        // Inicializa tudo com 0 (não conhece)
        for (int i = 0; i < Constantes.NUM_USUARIOS; i++) {
            for (int j = 0; j < Constantes.NUM_ARTISTAS; j++) {
                matriz[i][j] = Constantes.NAO_CONHECE;
            }
        }
    }

    /** Retorna uma cópia da linha de um usuário */
    public synchronized int[] getLinhaUsuario(int idUsuario) {
        return matriz[idUsuario].clone();
    }

    /** Atualiza a linha de um usuário inteiro */
    public synchronized void atualizarLinhaUsuario(int idUsuario, int[] novas) {
        if (novas == null || novas.length != Constantes.NUM_ARTISTAS) {
            throw new IllegalArgumentException("Linha inválida");
        }
        System.arraycopy(novas, 0, matriz[idUsuario], 0, Constantes.NUM_ARTISTAS);
    }

    /** Exibe a matriz inteira (para debug) */
    public synchronized void imprimirMatriz() {
        System.out.println("Matriz de avaliações:");
        for (int i = 0; i < Constantes.NUM_USUARIOS; i++) {
            System.out.print("Usuário " + i + ": ");
            for (int j = 0; j < Constantes.NUM_ARTISTAS; j++) {
                System.out.print(matriz[i][j] + " ");
            }
            System.out.println();
        }
    }
}
