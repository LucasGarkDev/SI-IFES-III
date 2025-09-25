/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servidor;

import protocolo.Mensagem;
import protocolo.TiposMensagem;
import utils.MatrizAvaliacao;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
/**
 *
 * @author lucas
 */
public class ServidorRingo {
    private static final int PORTA = 5000;
    private static MatrizAvaliacao matriz = new MatrizAvaliacao(); // 5x20
    private static ExecutorService pool = Executors.newCachedThreadPool();

    public static void main(String[] args) {
        try (ServerSocket servidor = new ServerSocket(PORTA)) {
            System.out.println("Servidor Ringo iniciado na porta " + PORTA);

            while (true) {
                Socket cliente = servidor.accept();
                pool.execute(() -> tratarCliente(cliente));
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void tratarCliente(Socket socket) {
        try (
            ObjectInputStream in = new ObjectInputStream(socket.getInputStream());
            ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream())
        ) {
            Mensagem msg = (Mensagem) in.readObject();

            switch (msg.getTipo()) {
                case REQUISITAR_AVALIACOES:
                    int[] avaliacoes = matriz.getLinha(msg.getIdUsuario());
                    Mensagem resposta = new Mensagem(TiposMensagem.ENVIAR_AVALIACOES);
                    resposta.setIdUsuario(msg.getIdUsuario());
                    resposta.setAvaliacoes(avaliacoes);
                    out.writeObject(resposta);
                    break;

                case ATUALIZAR_AVALIACOES:
                    matriz.atualizarLinha(msg.getIdUsuario(), msg.getAvaliacoes());
                    System.out.println("Atualizações recebidas do usuário " + msg.getIdUsuario());
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
