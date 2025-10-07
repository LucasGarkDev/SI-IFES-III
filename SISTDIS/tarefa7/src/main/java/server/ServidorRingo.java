/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package server;

import common.Constantes;
import common.Mensagem;
import common.TiposMensagem;
import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
/**
 *
 * @author lucas
 */
public class ServidorRingo {
    private final MatrizAvaliacao matriz;

    public ServidorRingo(MatrizAvaliacao matriz) {
        this.matriz = matriz;
    }

    /** Inicia o servidor TCP */
    public void iniciar() throws IOException {
        try (ServerSocket server = new ServerSocket(Constantes.PORTA_TCP_SERVIDOR)) {
            System.out.println("[Servidor] Rodando em TCP " + Constantes.PORTA_TCP_SERVIDOR);
            while (true) {
                Socket s = server.accept();
                new Thread(() -> atender(s)).start();
            }
        }
    }

    /** Atende cada conexão */
    private void atender(Socket s) {
        try (ObjectInputStream in = new ObjectInputStream(s.getInputStream());
             ObjectOutputStream out = new ObjectOutputStream(s.getOutputStream())) {

            Mensagem req = (Mensagem) in.readObject();
            switch (req.getTipo()) {
                case REQUISITAR_AVALIACOES -> {
                    int[] linha = matriz.getLinhaUsuario(req.getIdUsuario());
                    Mensagem resp = new Mensagem(TiposMensagem.ENVIAR_AVALIACOES);
                    resp.setIdUsuario(req.getIdUsuario());
                    resp.setAvaliacoes(linha);
                    out.writeObject(resp);
                    System.out.println("[Servidor] Enviou linha do usuário " + req.getIdUsuario());
                }
                case ATUALIZAR_AVALIACOES -> {
                    matriz.atualizarLinhaUsuario(req.getIdUsuario(), req.getAvaliacoes());
                    Mensagem ack = new Mensagem(TiposMensagem.ATUALIZAR_AVALIACOES);
                    out.writeObject(ack);
                    System.out.println("[Servidor] Atualizou linha do usuário " + req.getIdUsuario());
                }
                default -> System.out.println("[Servidor] Tipo de mensagem não suportado: " + req.getTipo());
            }
        } catch (Exception e) {
            System.err.println("[Servidor] Erro: " + e.getMessage());
        }
    }

    /** Main para rodar o servidor */
    public static void main(String[] args) throws Exception {
        MatrizAvaliacao base = new MatrizAvaliacao();
        new ServidorRingo(base).iniciar();
    }
}
