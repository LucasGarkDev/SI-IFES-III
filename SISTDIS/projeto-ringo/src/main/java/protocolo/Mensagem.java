/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package protocolo;

import java.io.Serializable;

/**
 *
 * @author lucas
 */
public class Mensagem implements Serializable {
    private static final long serialVersionUID = 1L;

    private TiposMensagem tipo;
    private int idUsuario;
    private int[] avaliacoes; // vetor de tamanho 20

    private int remetenteId; // usado para multicast
    private double distancia; // usado nas respostas de distância
    private int portaResposta;

    public Mensagem(TiposMensagem tipo) {
        this.tipo = tipo;
    }

    // Getters e Setters
    public TiposMensagem getTipo() {
        return tipo;
    }

    public int getPortaResposta() {
        return portaResposta;
    }

    public void setPortaResposta(int portaResposta) {
        this.portaResposta = portaResposta;
    }
    
    public void setTipo(TiposMensagem tipo) {
        this.tipo = tipo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int[] getAvaliacoes() {
        return avaliacoes;
    }

    public void setAvaliacoes(int[] avaliacoes) {
        this.avaliacoes = avaliacoes;
    }

    public int getRemetenteId() {
        return remetenteId;
    }

    public void setRemetenteId(int remetenteId) {
        this.remetenteId = remetenteId;
    }

    public double getDistancia() {
        return distancia;
    }

    public void setDistancia(double distancia) {
        this.distancia = distancia;
    }
}
