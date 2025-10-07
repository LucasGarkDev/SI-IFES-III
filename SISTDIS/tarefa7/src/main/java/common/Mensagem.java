/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package common;

import java.io.Serializable;
import java.util.Arrays;

/**
 * Classe serializável que representa mensagens trocadas
 * entre agentes e servidor
 */
public class Mensagem implements Serializable {
    private static final long serialVersionUID = 1L;

    private TiposMensagem tipo;
    private int idUsuario;              // id do dono da linha
    private int remetenteId;            // id do agente que enviou
    private int[] avaliacoes;           // linha de 20 colunas
    private Double distancia;           // usado em DISTANCIA_RESPOSTA
    private String hostSolicitante;     // IP do solicitante (para unicast)
    private int portaResposta;          // porta UDP ou TCP
    private int[] recomendacoes;        // índices recomendados
    private String hostRespondente;     // Novo campo: IP de quem respondeu

    public Mensagem(TiposMensagem tipo) {
        this.tipo = tipo;
    }

    // Getters e Setters
    public TiposMensagem getTipo() { return tipo; }
    public void setTipo(TiposMensagem tipo) { this.tipo = tipo; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public int getRemetenteId() { return remetenteId; }
    public void setRemetenteId(int remetenteId) { this.remetenteId = remetenteId; }

    public int[] getAvaliacoes() { return avaliacoes; }
    public void setAvaliacoes(int[] avaliacoes) { this.avaliacoes = avaliacoes; }

    public Double getDistancia() { return distancia; }
    public void setDistancia(Double distancia) { this.distancia = distancia; }

    public String getHostSolicitante() { return hostSolicitante; }
    public void setHostSolicitante(String hostSolicitante) { this.hostSolicitante = hostSolicitante; }

    public int getPortaResposta() { return portaResposta; }
    public void setPortaResposta(int portaResposta) { this.portaResposta = portaResposta; }

    public int[] getRecomendacoes() { return recomendacoes; }
    public void setRecomendacoes(int[] recomendacoes) { this.recomendacoes = recomendacoes; }

    public String getHostRespondente() { return hostRespondente; }
    public void setHostRespondente(String hostRespondente) { this.hostRespondente = hostRespondente; }

    @Override
    public String toString() {
        return "Mensagem{" +
                "tipo=" + tipo +
                ", idUsuario=" + idUsuario +
                ", remetenteId=" + remetenteId +
                ", distancia=" + distancia +
                ", hostRespondente='" + hostRespondente + '\'' +
                ", avaliacoes=" + Arrays.toString(avaliacoes) +
                '}';
    }
}
