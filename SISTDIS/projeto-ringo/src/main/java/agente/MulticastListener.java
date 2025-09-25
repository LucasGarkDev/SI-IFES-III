/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package agente;

import protocolo.Mensagem;
import protocolo.TiposMensagem;

import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.*;
import java.util.Arrays;
/**
 *
 * @author lucas
 */
public class MulticastListener extends Thread{
    private static final String GRUPO_MULTICAST = "230.0.0.1";
    private static final int PORTA = 6789;
    private final int[] avaliacoesLocais;
    private final int idUsuario;

    public MulticastListener(int[] avaliacoes, int idUsuario) {
        this.avaliacoesLocais = avaliacoes;
        this.idUsuario = idUsuario;
    }

    @Override
    public void run() {
        try (MulticastSocket socket = new MulticastSocket(PORTA)) {
            InetAddress grupo = InetAddress.getByName(GRUPO_MULTICAST);
            socket.joinGroup(grupo);

            byte[] buffer = new byte[4096];

            while (true) {
                DatagramPacket pacote = new DatagramPacket(buffer, buffer.length);
                socket.receive(pacote);

                // Recuperar a mensagem
                ByteArrayInputStream bais = new ByteArrayInputStream(pacote.getData(), 0, pacote.getLength());
                ObjectInputStream ois = new ObjectInputStream(bais);
                Mensagem mensagem = (Mensagem) ois.readObject();

                if (mensagem.getTipo() == TiposMensagem.DISTANCIA_REQUISICAO) {
                    int[] avaliacoesRemotas = mensagem.getAvaliacoes();
                    int idSolicitante = mensagem.getIdUsuario();
                    InetAddress ipSolicitante = pacote.getAddress();
                    int portaSolicitante = mensagem.getPortaResposta(); // deve estar na mensagem

                    // Calcular distância euclidiana
                    double distancia = calcularDistancia(avaliacoesLocais, avaliacoesRemotas);
                    System.out.println("Agente " + idUsuario + " calculou distância para agente " + idSolicitante + ": " + distancia);

                    // Enviar resposta diretamente para o solicitante
                    try (Socket respostaSocket = new Socket(ipSolicitante, portaSolicitante)) {
                        ObjectOutputStream oos = new ObjectOutputStream(respostaSocket.getOutputStream());

                        Mensagem resposta = new Mensagem(TiposMensagem.DISTANCIA_RESPOSTA);
                        resposta.setIdUsuario(idUsuario);
                        resposta.setDistancia(distancia);

                        oos.writeObject(resposta);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private double calcularDistancia(int[] local, int[] remoto) {
        double soma = 0;
        for (int i = 0; i < local.length; i++) {
            int a = local[i];
            int b = remoto[i];

            // Só considera onde ambos avaliaram (> 0)
            if (a > 0 && b > 0) {
                soma += Math.pow(a - b, 2);
            }
        }
        return Math.sqrt(soma);
    }
}
