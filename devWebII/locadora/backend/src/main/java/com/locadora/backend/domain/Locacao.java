/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.domain;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "locacao")
public class Locacao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    private Cliente cliente;

    @ManyToOne(optional = false)
    private Item item;

    private LocalDate dataLocacao;
    private LocalDate dataPrevistaDevolucao;
    private LocalDate dataEfetivaDevolucao;

    private Integer valorCentavos;
    private Integer multaCentavos;

    private boolean paga;
    private boolean cancelada;

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }
    public Item getItem() { return item; }
    public void setItem(Item item) { this.item = item; }
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
    public boolean isPaga() { return paga; }
    public void setPaga(boolean paga) { this.paga = paga; }
    public boolean isCancelada() { return cancelada; }
    public void setCancelada(boolean cancelada) { this.cancelada = cancelada; }
}
