/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cliente;

import java.net.*;
import java.util.Timer;
import java.util.TimerTask;
import javax.swing.DefaultListModel;
import telas.TelaChat;
/**
 *
 * @author lucas
 */
public class ClienteUDP {
    private static final String SERVIDOR_IP = "localhost"; // ou IP do servidor real
    private static final int SERVIDOR_PORTA = 12345;
    private static final int TAMANHO_PACOTE = 1024;
    
    private TelaChat tela;
    private String nomeUsuario;
    private DatagramSocket socket;
    private String servidorIP;

    public ClienteUDP(String nomeUsuario) throws Exception {
        this.nomeUsuario = nomeUsuario;
        this.socket = new DatagramSocket();

        iniciarRecebimento();
        iniciarHeartbeat();
    }
    
    public ClienteUDP(String nomeUsuario, String servidorIP, TelaChat tela) throws Exception {
        this.nomeUsuario = nomeUsuario;
        this.servidorIP = servidorIP;
        this.tela = tela;
        this.socket = new DatagramSocket();
        iniciarRecebimento();
        iniciarHeartbeat();
    }

    public void enviarMensagem(String conteudo) throws Exception {
        String mensagem = "MSG;" + nomeUsuario + ";" + conteudo;
        byte[] dados = mensagem.getBytes();
        DatagramPacket pacote = new DatagramPacket(dados, dados.length, InetAddress.getByName(servidorIP), SERVIDOR_PORTA);
        socket.send(pacote);
    }

    private void iniciarRecebimento() {
        Thread thread = new Thread(() -> {
            try {
                while (true) {
                    byte[] buffer = new byte[TAMANHO_PACOTE];
                    DatagramPacket pacoteRecebido = new DatagramPacket(buffer, buffer.length);
                    socket.receive(pacoteRecebido);

                    String mensagem = new String(pacoteRecebido.getData(), 0, pacoteRecebido.getLength());
                    //System.out.println("Recebido: " + mensagem);

                    String[] partes = mensagem.split(";", 3);

                    if (partes.length == 3 && partes[0].equals("MSG")) {
                        String usuario = partes[1];
                        String conteudo = partes[2];
                        tela.exibirMensagem(usuario + ": " + conteudo);
                    } else if (partes[0].equals("RANK") && partes.length == 2) {
                        String[] usuarios = partes[1].split(",");
                        DefaultListModel<String> modelo = new DefaultListModel<>();
                        for (String u : usuarios) {
                            modelo.addElement(u.replace("=", ": "));
                        }
                        tela.atualizarListaUsuarios(modelo);
                    }else {
                        tela.exibirMensagem(mensagem); // fallback
                    }


                    // Aqui você pode chamar TelaChat.exibirMensagem() ou algo similar
                    // Exemplo: TelaChat.adicionarMensagemNaTela(mensagem);

                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();
    }

    private void iniciarHeartbeat() {
        Timer timer = new Timer(true);
        timer.scheduleAtFixedRate(new TimerTask() {
            public void run() {
                try {
                    String ping = "PING;" + nomeUsuario + ";";
                    byte[] dados = ping.getBytes();
                    DatagramPacket pacote = new DatagramPacket(dados, dados.length, InetAddress.getByName(SERVIDOR_IP), SERVIDOR_PORTA);
                    socket.send(pacote);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }, 0, 5000); // a cada 5 segundos
    }
    
    public void desconectar() {
        try {
            String mensagem = "EXIT;" + nomeUsuario + ";";
            byte[] dados = mensagem.getBytes();
            DatagramPacket pacote = new DatagramPacket(dados, dados.length, InetAddress.getByName(servidorIP), SERVIDOR_PORTA);
            socket.send(pacote);
            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void solicitarRanking() throws Exception {
        String mensagem = "RANK;" + nomeUsuario + ";";
        byte[] dados = mensagem.getBytes();
        DatagramPacket pacote = new DatagramPacket(dados, dados.length, InetAddress.getByName(servidorIP), SERVIDOR_PORTA);
        socket.send(pacote);
    }
}
