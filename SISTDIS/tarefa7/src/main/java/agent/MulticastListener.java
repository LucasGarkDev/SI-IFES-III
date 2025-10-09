/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package agent;

import common.Bytes;
import common.Constantes;
import common.Mensagem;
import common.TiposMensagem;

import java.net.*;

/**
 * Escuta mensagens multicast de requisição de distância
 * e responde via unicast com a distância calculada
 */
public class MulticastListener extends Thread {

    private final int idUsuario;
    private volatile int[] avaliacoesLocais;

    public MulticastListener(int idUsuario, int[] linhaInicial) {
        this.idUsuario = idUsuario;
        this.avaliacoesLocais = linhaInicial.clone();
        setName("MulticastListener-" + idUsuario);
        setDaemon(true);
    }

    public void atualizarLinha(int[] nova) {
        this.avaliacoesLocais = nova.clone();
    }

    @Override
    public void run() {
        try (MulticastSocket socket = new MulticastSocket(Constantes.PORTA_MULTICAST)) {
            socket.setReuseAddress(true);
            socket.joinGroup(InetAddress.getByName(Constantes.GRUPO_MULTICAST));
            System.out.println("[Agente " + idUsuario + "] Escutando multicast em "
                    + Constantes.GRUPO_MULTICAST + ":" + Constantes.PORTA_MULTICAST);

            byte[] buffer = new byte[8192];
            while (true) {
                DatagramPacket pacote = new DatagramPacket(buffer, buffer.length);
                socket.receive(pacote);

                Object obj = Bytes.fromBytes(pacote.getData(), pacote.getLength());
                if (!(obj instanceof Mensagem msg)) continue;
                if (msg.getTipo() != TiposMensagem.DISTANCIA_REQUISICAO) continue;
                if (msg.getRemetenteId() == idUsuario) continue; // ignora se veio dele mesmo

                double distancia = euclidianaCoAvaliadas(this.avaliacoesLocais, msg.getAvaliacoes());

                Mensagem resp = new Mensagem(TiposMensagem.DISTANCIA_RESPOSTA);
                resp.setRemetenteId(idUsuario);
                resp.setIdUsuario(msg.getIdUsuario());
                resp.setDistancia(distancia);
                resp.setHostRespondente(InetAddress.getLocalHost().getHostAddress()); // Novo campo

                // envia resposta unicast
                byte[] out = Bytes.toBytes(resp);
                DatagramPacket resposta = new DatagramPacket(
                        out, out.length,
                        InetAddress.getByName(msg.getHostSolicitante()),
                        msg.getPortaResposta()
                );
                try (DatagramSocket unicast = new DatagramSocket()) {
                    unicast.send(resposta);
                }

                System.out.println("[Agente " + idUsuario + "] Respondeu distância para "
                        + msg.getIdUsuario() + ": " + distancia);
            }
        } catch (Exception e) {
            System.err.println("[Agente " + idUsuario + "] Erro no multicast: " + e.getMessage());
        }
    }

    /** Calcula a distância euclidiana considerando apenas colunas coavaliadas */
    private static double euclidianaCoAvaliadas(int[] a, int[] b) {
        double soma = 0;
        int cont = 0;
        for (int i = 0; i < a.length; i++) {
            if (a[i] != 0 && b[i] != 0) {
                soma += Math.pow(a[i] - b[i], 2);
                cont++;
            }
        }
        if (cont == 0) return Double.POSITIVE_INFINITY;
        return Math.sqrt(soma);
    }
}
