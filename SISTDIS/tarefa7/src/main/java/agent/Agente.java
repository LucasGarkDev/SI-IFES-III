/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package agent;

import common.*;

import java.net.*;
import java.util.*;

/**
 * Classe principal do agente individual
 * Responsável por interagir com o servidor e outros agentes
 * (via multicast para distância e TCP para recomendações)
 */
public class Agente {

    private final int idUsuario;
    private final int portaPeer; // Porta única por agente
    private int[] minhasAvaliacoes;
    private final MulticastListener listener;
    private final AgentePeerServer peerServer;
    private final Map<Integer, String> peers = new HashMap<>(); // Guarda IPs dos outros agentes

    public Agente(int idUsuario) {
        this.idUsuario = idUsuario;
        this.minhasAvaliacoes = requisitarAvaliacoesServidor();

        // Thread que escuta multicast para responder distâncias
        this.listener = new MulticastListener(idUsuario, minhasAvaliacoes);
        this.listener.start();

        // Porta TCP única por agente (evita "Endereço já em uso")
        this.portaPeer = 9091 + idUsuario;
        this.peerServer = new AgentePeerServer(idUsuario, minhasAvaliacoes, portaPeer);
        this.peerServer.start();
    }

    /** Busca a linha inicial no servidor */
    private int[] requisitarAvaliacoesServidor() {
        try {
            Mensagem req = new Mensagem(TiposMensagem.REQUISITAR_AVALIACOES);
            req.setIdUsuario(idUsuario);
            Mensagem resp = TcpClient.request(Constantes.HOST_SERVIDOR, Constantes.PORTA_TCP_SERVIDOR, req);
            System.out.println("[Agente " + idUsuario + "] Linha recebida do servidor.");
            return resp.getAvaliacoes();
        } catch (Exception e) {
            System.err.println("[Agente " + idUsuario + "] Erro ao buscar linha: " + e.getMessage());
            return new int[Constantes.NUM_ARTISTAS];
        }
    }

    /** Atualiza servidor com notas atuais */
    private void atualizarServidor() {
        try {
            Mensagem req = new Mensagem(TiposMensagem.ATUALIZAR_AVALIACOES);
            req.setIdUsuario(idUsuario);
            req.setAvaliacoes(minhasAvaliacoes);
            TcpClient.request(Constantes.HOST_SERVIDOR, Constantes.PORTA_TCP_SERVIDOR, req);
            listener.atualizarLinha(minhasAvaliacoes); // Atualiza cópia no listener
            System.out.println("[Agente " + idUsuario + "] Linha atualizada no servidor.");
        } catch (Exception e) {
            System.err.println("[Agente " + idUsuario + "] Falha ao atualizar servidor: " + e.getMessage());
        }
    }

    /** Calcula o agente mais similar via broadcast multicast */
    private Optional<Integer> encontrarMaisSimilar(long timeoutMs) {
        try (DatagramSocket socket = new DatagramSocket()) {
            socket.setSoTimeout((int) timeoutMs);
            int portaLocal = socket.getLocalPort();

            Mensagem req = new Mensagem(TiposMensagem.DISTANCIA_REQUISICAO);
            req.setRemetenteId(idUsuario);
            req.setIdUsuario(idUsuario);
            req.setAvaliacoes(minhasAvaliacoes);
            req.setHostSolicitante(getMeuIP());
            req.setPortaResposta(portaLocal);

            // Envia broadcast multicast
            byte[] dados = Bytes.toBytes(req);
            DatagramPacket pacote = new DatagramPacket(
                    dados, dados.length,
                    InetAddress.getByName(Constantes.GRUPO_MULTICAST),
                    Constantes.PORTA_MULTICAST
            );
            try (DatagramSocket envio = new DatagramSocket()) {
                envio.send(pacote);
            }

            Integer melhorId = null;
            double menorDist = Double.POSITIVE_INFINITY;
            byte[] buffer = new byte[8192];
            long inicio = System.currentTimeMillis();

            // Espera respostas (unicast)
            while (System.currentTimeMillis() - inicio < timeoutMs) {
                DatagramPacket resp = new DatagramPacket(buffer, buffer.length);
                try {
                    socket.receive(resp);
                    Object obj = Bytes.fromBytes(resp.getData(), resp.getLength());
                    if (obj instanceof Mensagem msg && msg.getTipo() == TiposMensagem.DISTANCIA_RESPOSTA) {
                        if (msg.getHostRespondente() != null) {
                            peers.put(msg.getRemetenteId(), msg.getHostRespondente());
                        }
                        if (msg.getDistancia() != null && msg.getDistancia() < menorDist) {
                            menorDist = msg.getDistancia();
                            melhorId = msg.getRemetenteId();
                        }
                    }
                } catch (SocketTimeoutException ignore) {
                    break;
                }
            }

            if (melhorId != null) {
                System.out.println("[Agente " + idUsuario + "] Mais similar: " + melhorId + " (dist=" + menorDist + ")");
                return Optional.of(melhorId);
            } else {
                System.out.println("[Agente " + idUsuario + "] Nenhuma resposta recebida.");
                return Optional.empty();
            }
        } catch (Exception e) {
            System.err.println("[Agente " + idUsuario + "] Erro no broadcast: " + e.getMessage());
            return Optional.empty();
        }
    }

    /** Pede recomendações ao agente similar via TCP */
    private int[] pedirRecomendacoes(String hostSimilar, int idSimilar) {
        try {
            Mensagem req = new Mensagem(TiposMensagem.RECOMENDACOES_PEDIDO);
            req.setAvaliacoes(minhasAvaliacoes);
            int portaDoSimilar = 9091 + idSimilar; // Porta específica do similar
            Mensagem resp = TcpClient.request(hostSimilar, portaDoSimilar, req);
            if (resp != null && resp.getRecomendacoes() != null) {
                return resp.getRecomendacoes();
            }
        } catch (Exception e) {
            System.err.println("[Agente " + idUsuario + "] Erro ao pedir recomendações: " + e.getMessage());
        }
        return new int[0];
    }

    /** IP da máquina local */
    private static String getMeuIP() throws UnknownHostException {
        return InetAddress.getLocalHost().getHostAddress();
    }

    /** Menu principal */
    public void iniciar() {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("\n=== Agente " + idUsuario + " ===");
            System.out.println("1) Ver minhas avaliações");
            System.out.println("2) Atribuir nota (coluna 0-19)");
            System.out.println("3) Atualizar servidor");
            System.out.println("4) Encontrar similar e pedir recomendações");
            System.out.println("0) Sair");
            System.out.print("Escolha: ");

            int op = Integer.parseInt(sc.nextLine());
            if (op == 0) break;

            switch (op) {
                case 1 -> {System.out.println("Minhas Avaliações:");
                        for (int i = 0; i < minhasAvaliacoes.length; i++) {
                            System.out.printf("%2d - %-20s : %d%n", i, Constantes.NOMES_ARTISTAS[i], minhasAvaliacoes[i]);
                        }
                }
                case 2 -> {
                    System.out.print("Artista (0-19): ");
                    int i = Integer.parseInt(sc.nextLine());
                    System.out.print("Nota (0-3): ");
                    int n = Integer.parseInt(sc.nextLine());
                    if (i >= 0 && i < minhasAvaliacoes.length && n >= 0 && n <= 3) {
                        minhasAvaliacoes[i] = n;
                        System.out.println("Nota atribuída.");
                    } else {
                        System.out.println("Valores inválidos.");
                    }
                }
                case 3 -> atualizarServidor();
                case 4 -> {
                    Optional<Integer> similar = encontrarMaisSimilar(3000);
                    similar.ifPresent(id -> {
                        // pega IP automaticamente
                        String ip = peers.get(id);
                        if (ip == null || ip.isBlank()) {
                            System.out.print("IP do agente " + id + " (ex: 127.0.0.1): ");
                            ip = sc.nextLine().trim();
                        }
                        int[] recs = pedirRecomendacoes(ip, id);
                        if (recs.length == 0)
                            System.out.println("Sem recomendações.");
                        else
                            System.out.println("Recomendações recebidas:");
                            for (int i : recs) {
                                System.out.println(" - " + Constantes.NOMES_ARTISTAS[i] + " (índice " + i + ")");
                            }
                    });
                }
                default -> System.out.println("Opção inválida.");
            }
        }
        sc.close();
    }
}
