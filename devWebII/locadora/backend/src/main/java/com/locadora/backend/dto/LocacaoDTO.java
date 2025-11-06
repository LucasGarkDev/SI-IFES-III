/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import java.time.LocalDate;

public class LocacaoDTO {
    private Long id;
    private Long clienteId;
    private Long itemId;
    private LocalDate dataLocacao;
    private LocalDate dataPrevistaDevolucao;
    private LocalDate dataEfetivaDevolucao;
    private Integer valorCentavos;
    private Integer multaCentavos;
    private Boolean paga;
    private Boolean cancelada;

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getClienteId() { return clienteId; }
    public void setClienteId(Long clienteId) { this.clienteId = clienteId; }
    public Long getItemId() { return itemId; }
    public void setItemId(Long itemId) { this.itemId = itemId; }
    public LocalDate getDataLocacao() { return dataLocacao; }
    public void setDataLocacao(LocalDate dataLocacao) { this.dataLocacao = dataLocacao; }
    public LocalDate getDataPrevistaDevolucao() { return dataPrevistaDevolucao; }
    public void setDataPrevistaDevolucao(LocalDate dataPrevistaDevolucao) { this.dataPrevistaDevolucao = dataPrevistaDevolucao; }
    public LocalDate getDataEfetivaDevolucao() { return dataEfetivaDevolucao; }
    public void setDataEfetivaDevolucao(LocalDate dataEfetivaDevolucao) { this.dataEfetivaDevolucao = dataEfetivaDevolucao; }
    public Integer getValorCentavos() { return valorCentavos; }
    public void setValorCentavos(Integer valorCentavos) { this.valorCentavos = valorCentavos; }
    public Integer getMultaCentavos() { return multaCentavos; }
    public void setMultaCentavos(Integer multaCentavos) { this.multaCentavos = multaCentavos; }
    public Boolean getPaga() { return paga; }
    public void setPaga(Boolean paga) { this.paga = paga; }
    public Boolean getCancelada() { return cancelada; }
    public void setCancelada(Boolean cancelada) { this.cancelada = cancelada; }
}

