/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package server;

import common.Constantes;

import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Classe responsável por armazenar e persistir as avaliações
 * de todos os usuários (matriz 5x20).
 *
 * Cada linha representa um usuário e cada coluna um artista/banda.
 * As notas são salvas em um arquivo CSV (avaliacoes.csv) para manter
 * o histórico entre execuções do sistema.
 */
public class MatrizAvaliacao {

    private final int[][] matriz = new int[Constantes.NUM_USUARIOS][Constantes.NUM_ARTISTAS];
    private static final String ARQUIVO = "avaliacoes.csv";

    /** Construtor: carrega matriz do arquivo se existir, senão inicializa com zeros */
    public MatrizAvaliacao() {
        carregarDeArquivo();
    }

    /** Retorna uma cópia da linha de um usuário */
    public synchronized int[] getLinhaUsuario(int idUsuario) {
        return matriz[idUsuario].clone();
    }

    /** Atualiza a linha de um usuário inteiro e salva no arquivo */
    public synchronized void atualizarLinhaUsuario(int idUsuario, int[] novas) {
        if (novas == null || novas.length != Constantes.NUM_ARTISTAS) {
            throw new IllegalArgumentException("Linha inválida");
        }
        System.arraycopy(novas, 0, matriz[idUsuario], 0, Constantes.NUM_ARTISTAS);
        salvarEmArquivo();
        System.out.println("[Servidor] Linha do usuário " + idUsuario + " atualizada e salva.");
    }

    /** Salva toda a matriz no arquivo CSV */
    private void salvarEmArquivo() {
        try (PrintWriter pw = new PrintWriter(new FileWriter(ARQUIVO))) {
            for (int[] linha : matriz) {
                String csv = Arrays.stream(linha)
                        .mapToObj(String::valueOf)
                        .collect(Collectors.joining(","));
                pw.println(csv);
            }
            //System.out.println("[Servidor] Matriz salva em " + ARQUIVO);
        } catch (IOException e) {
            System.err.println("[Servidor] Erro ao salvar arquivo: " + e.getMessage());
        }
    }

    /** Carrega a matriz do arquivo CSV, se existir */
    private void carregarDeArquivo() {
        File f = new File(ARQUIVO);
        if (!f.exists()) {
            System.out.println("[Servidor] Nenhum arquivo encontrado, iniciando matriz vazia.");
            // Inicializa com zeros
            for (int i = 0; i < Constantes.NUM_USUARIOS; i++) {
                Arrays.fill(matriz[i], Constantes.NAO_CONHECE);
            }
            return;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(f))) {
            String line;
            int i = 0;
            while ((line = br.readLine()) != null && i < Constantes.NUM_USUARIOS) {
                String[] vals = line.split(",");
                for (int j = 0; j < vals.length && j < Constantes.NUM_ARTISTAS; j++) {
                    matriz[i][j] = Integer.parseInt(vals[j]);
                }
                i++;
            }
            System.out.println("[Servidor] Avaliações carregadas de " + ARQUIVO);
        } catch (IOException e) {
            System.err.println("[Servidor] Erro ao carregar arquivo: " + e.getMessage());
        }
    }

    /** Exibe a matriz inteira (para debug) */
    public synchronized void imprimirMatriz() {
        System.out.println("=== Matriz de Avaliações ===");
        for (int i = 0; i < Constantes.NUM_USUARIOS; i++) {
            System.out.print("Usuário " + i + ": ");
            for (int j = 0; j < Constantes.NUM_ARTISTAS; j++) {
                System.out.print(matriz[i][j] + " ");
            }
            System.out.println();
        }
    }
}
