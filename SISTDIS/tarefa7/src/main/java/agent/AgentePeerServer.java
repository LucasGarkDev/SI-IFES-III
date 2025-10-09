/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// agent/AgentePeerServer.java
package agent;

import common.Mensagem;
import common.TiposMensagem;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class AgentePeerServer extends Thread {
    private final int idUsuario;
    private final int[] avaliacoesLocais;
    private final int porta;

    public AgentePeerServer(int idUsuario, int[] avaliacoesLocais, int porta) {
        this.idUsuario = idUsuario;
        this.avaliacoesLocais = avaliacoesLocais;
        this.porta = porta;
        setName("AgentePeerServer-" + idUsuario);
        setDaemon(true);
    }

    @Override
    public void run() {
        try (ServerSocket server = new ServerSocket(porta)) {
            System.out.println("[Agente " + idUsuario + "] PeerServer escutando TCP " + porta);
            while (true) {
                Socket s = server.accept();
                new Thread(() -> atender(s)).start();
            }
        } catch (IOException e) {
            System.err.println("[Agente " + idUsuario + "] PeerServer erro: " + e.getMessage());
        }
    }

    private void atender(Socket s) {
        try (ObjectInputStream in = new ObjectInputStream(s.getInputStream());
             ObjectOutputStream out = new ObjectOutputStream(s.getOutputStream())) {

            Mensagem req = (Mensagem) in.readObject();
            if (req.getTipo() == TiposMensagem.RECOMENDACOES_PEDIDO) {
                int[] doSolicitante = req.getAvaliacoes();
                List<Integer> sugerir = new ArrayList<>();

                // Recomenda artistas que o solicitante não avaliou (0)
                // e que este agente avaliou como "GOSTA MUITO" (>=3)
                for (int i = 0; i < avaliacoesLocais.length; i++) {
                    if (doSolicitante[i] == 0 && avaliacoesLocais[i] >= 3) {
                        sugerir.add(i);
                    }
                }

                Mensagem resp = new Mensagem(TiposMensagem.RECOMENDACOES_RESPOSTA);
                resp.setRemetenteId(idUsuario);
                resp.setRecomendacoes(sugerir.stream().mapToInt(Integer::intValue).toArray());
                out.writeObject(resp);

                System.out.println("[Agente " + idUsuario + "] Enviou " + sugerir.size() + " recomendações.");
            }
        } catch (Exception e) {
            System.err.println("[Agente " + idUsuario + "] Erro ao atender pedido: " + e.getMessage());
        }
    }
}
