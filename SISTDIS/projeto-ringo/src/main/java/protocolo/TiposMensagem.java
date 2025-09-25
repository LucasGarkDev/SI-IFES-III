/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package protocolo;

/**
 *
 * @author lucas
 */
public enum TiposMensagem {
    REQUISITAR_AVALIACOES,   // Agente → Servidor
    ENVIAR_AVALIACOES,       // Servidor → Agente
    ATUALIZAR_AVALIACOES,    // Agente → Servidor

    DISTANCIA_REQUISICAO,    // Agente → Todos os Agentes (via Multicast)
    DISTANCIA_RESPOSTA,      // Agente → Agente solicitante (Unicast)
    
    RECOMENDACOES,           // Agente similar → Agente solicitante
}
