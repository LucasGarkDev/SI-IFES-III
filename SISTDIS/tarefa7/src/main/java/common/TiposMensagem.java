/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package common;

/**
 *
 * @author lucas
 */
public enum TiposMensagem {
    // --- Comunicação com o servidor ---
    REQUISITAR_AVALIACOES,   // agente → servidor (pedir linha do usuário)
    ENVIAR_AVALIACOES,       // servidor → agente (resposta com linha)
    ATUALIZAR_AVALIACOES,    // agente → servidor (enviar linha atualizada)

    // --- Comunicação via Multicast (entre agentes) ---
    DISTANCIA_REQUISICAO,    // agente solicitante → todos (broadcast)
    DISTANCIA_RESPOSTA,      // agente respondente → solicitante (unicast)

    // --- Comunicação particular entre dois agentes ---
    RECOMENDACOES_PEDIDO,    // solicitante → similar (pede recomendações)
    RECOMENDACOES_RESPOSTA   // similar → solicitante (envia recomendações)
}