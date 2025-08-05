/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package aplicacaoudp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;

/**
 *
 * @author lucas
 */
public class MeuServidorUDP {
    private static BaseDeDados bd = null;
    
    public static void main(String[] args) {
        DatagramSocket aSocket = null;
        bd = new BaseDeDados();
        
        try{
            aSocket = new DatagramSocket(6789);
            
            while(true){
            
                byte[] buffer = new byte[600];
                DatagramPacket request = new DatagramPacket(buffer,buffer.length);
                aSocket.receive(request);
                
                String mensagem = new String(request.getData());
                
                bd.insere(mensagem.toUpperCase());
                String resposta = bd.le();
                byte[] todasMsg = resposta.getBytes();
                
                DatagramPacket reply = new DatagramPacket(todasMsg, todasMsg.length, request.getAddress(),request.getPort());
                aSocket.send(reply);
            }
            
        }catch(SocketException e){
            System.out.println("SERVIDOR - Socket: "+e.getMessage());
        }catch(IOException e){
            System.out.println("SERVIDOR - Input Output: "+e.getMessage());
        }finally {
            if(aSocket != null) aSocket.close();
        }
        
    }
    
}
