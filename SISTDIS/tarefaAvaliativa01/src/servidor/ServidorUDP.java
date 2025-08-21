/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servidor;

import java.io.PrintWriter;
import java.net.*;
import java.util.*;
import java.util.concurrent.*;
/**
 *
 * @author lucas
 */
public class ServidorUDP {
    private static final int PORTA = 12345;
    private static final int TAMANHO_PACOTE = 1024;

    private static Map<String, InetSocketAddress> usuariosOnline = new ConcurrentHashMap<>();
    private static Map<String, Integer> mensagensPorUsuario = new ConcurrentHashMap<>();
    
    private static final Map<String, Long> ultimaAtividadeUsuarios = new ConcurrentHashMap<>();


    public static void main(String[] args) throws Exception {
        DatagramSocket socket = new DatagramSocket(PORTA);
        System.out.println("Servidor UDP iniciado na porta " + PORTA);
        
        // Timer para detectar usuários inativos (ping > 15s)
        new Timer(true).scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                long agora = System.currentTimeMillis();
                List<String> inativos = new ArrayList<>();

                for (Map.Entry<String, Long> entry : ultimaAtividadeUsuarios.entrySet()) {
                    long ultimoPing = entry.getValue();
                    if ((agora - ultimoPing) > 15000) { // 15 segundos
                        String usuario = entry.getKey();
                        inativos.add(usuario);
                    }
                }

                for (String usuario : inativos) {
                    usuariosOnline.remove(usuario);
                    ultimaAtividadeUsuarios.remove(usuario);
                    System.out.println("Usuário inativo removido: " + usuario);
                }
            }
        }, 0, 10000); // roda a cada 10 segundos

        // Thread para aguardar comando 'exit' e encerrar o servidor
        new Thread(() -> {
            Scanner scanner = new Scanner(System.in);
            while (true) {
                String comando = scanner.nextLine();
                if (comando.equalsIgnoreCase("exit")) {
                    gerarRelatorio();
                    System.out.println("Servidor encerrado pelo usuário.");
                    System.exit(0);
                }
            }
        }).start();

        // Thread principal para escutar pacotes UDP
        byte[] buffer = new byte[TAMANHO_PACOTE];
        while (true) {
            DatagramPacket pacoteRecebido = new DatagramPacket(buffer, buffer.length);
            socket.receive(pacoteRecebido);

            String mensagem = new String(pacoteRecebido.getData(), 0, pacoteRecebido.getLength());
            String ipRemetente = pacoteRecebido.getAddress().getHostAddress();
            int portaRemetente = pacoteRecebido.getPort();

            tratarMensagem(mensagem, new InetSocketAddress(ipRemetente, portaRemetente), socket);
        }
    }


    private static void tratarMensagem(String mensagem, InetSocketAddress remetente, DatagramSocket socket) throws Exception {
        String[] partes = mensagem.split(";", 3); // TIPO;USUARIO;CONTEUDO
        if (partes.length < 2) return;

        String tipo = partes[0];
        String usuario = partes[1];

        switch (tipo) {
            case "MSG":
                String conteudo = partes[2];
                System.out.println(usuario + ": " + conteudo);

                mensagensPorUsuario.put(usuario, mensagensPorUsuario.getOrDefault(usuario, 0) + 1);
                usuariosOnline.put(usuario, remetente); // atualiza endereço do usuário

                // Enviar para todos os usuários online
                for (InetSocketAddress addr : usuariosOnline.values()) {
                    String resposta = "MSG;" + usuario + ";" + conteudo;
                    byte[] dados = resposta.getBytes();
                    DatagramPacket pacote = new DatagramPacket(dados, dados.length, addr);
                    socket.send(pacote);
                }
                break;

            case "PING":
                usuariosOnline.put(usuario, remetente); // continua mantendo endereço
                ultimaAtividadeUsuarios.put(usuario, System.currentTimeMillis()); // atualiza hora do ping
                break;
                
            case "RANK":
                StringBuilder resposta = new StringBuilder("RANK;");
                for (Map.Entry<String, Integer> entry : mensagensPorUsuario.entrySet()) {
                    resposta.append(entry.getKey()).append("=").append(entry.getValue()).append(",");
                }
                // remover última vírgula
                if (resposta.charAt(resposta.length() - 1) == ',') {
                    resposta.deleteCharAt(resposta.length() - 1);
                }
                byte[] respostaBytes = resposta.toString().getBytes();
                DatagramPacket respostaPacote = new DatagramPacket(respostaBytes, respostaBytes.length, remetente);
                socket.send(respostaPacote);
                break;    
               
        }
    }
    
    public static void gerarRelatorio() {
        try (PrintWriter writer = new PrintWriter("relatorio.txt")) {
            writer.println("Relatório de mensagens por usuário:");
            for (Map.Entry<String, Integer> entry : mensagensPorUsuario.entrySet()) {
                writer.println(entry.getKey() + ": " + entry.getValue() + " mensagens");
            }
            System.out.println("Relatório gerado com sucesso em relatorio.txt");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
