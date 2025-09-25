/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package agente;

import protocolo.Mensagem;
import protocolo.TiposMensagem;

import java.io.*;
import java.net.Socket;
import java.util.Arrays;
import java.util.Scanner;
/**
 *
 * @author lucas
 */
public class Agente {
    private int idUsuario; // de 0 a 4
    private int[] avaliacoes = new int[20]; // 20 bandas
    private static final String HOST_SERVIDOR = "localhost";
    private static final int PORTA_SERVIDOR = 5000;

    public Agente(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public void iniciar() {
        try {
            // Etapa 1: conectar com servidor e obter avaliações
            try (Socket socket = new Socket(HOST_SERVIDOR, PORTA_SERVIDOR);
                 ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());
                 ObjectInputStream in = new ObjectInputStream(socket.getInputStream())) {

                Mensagem msg = new Mensagem(TiposMensagem.REQUISITAR_AVALIACOES);
                msg.setIdUsuario(idUsuario);
                out.writeObject(msg);

                Mensagem resposta = (Mensagem) in.readObject();
                this.avaliacoes = resposta.getAvaliacoes();

                System.out.println("Avaliações do usuário " + idUsuario + ": " + Arrays.toString(avaliacoes));
            }

            // Etapa 2: permitir avaliar novos artistas e atualizar servidor
            Scanner sc = new Scanner(System.in);
            while (true) {
                System.out.print("Digite o índice do artista (0 a 19) para avaliar ou -1 para sair: ");
                int artista = sc.nextInt();
                if (artista == -1) break;

                System.out.print("Digite a nota (0 a 3): ");
                int nota = sc.nextInt();
                if (nota >= 0 && nota <= 3) {
                    avaliacoes[artista] = nota;
                    atualizarServidor();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void atualizarServidor() {
        try (Socket socket = new Socket(HOST_SERVIDOR, PORTA_SERVIDOR);
             ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream())) {

            Mensagem atualizacao = new Mensagem(TiposMensagem.ATUALIZAR_AVALIACOES);
            atualizacao.setIdUsuario(idUsuario);
            atualizacao.setAvaliacoes(avaliacoes);
            out.writeObject(atualizacao);

            System.out.println("Atualizações enviadas ao servidor!");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
