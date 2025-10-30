/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import java.time.LocalDate;

public class ItemDTO {
    private Long id;
    private String numSerie;
    private LocalDate dtAquisicao;
    private String tipoItem;
    private Long tituloId;
    private String tituloNome;

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNumSerie() { return numSerie; }
    public void setNumSerie(String numSerie) { this.numSerie = numSerie; }

    public LocalDate getDtAquisicao() { return dtAquisicao; }
    public void setDtAquisicao(LocalDate dtAquisicao) { this.dtAquisicao = dtAquisicao; }

    public String getTipoItem() { return tipoItem; }
    public void setTipoItem(String tipoItem) { this.tipoItem = tipoItem; }

    public Long getTituloId() { return tituloId; }
    public void setTituloId(Long tituloId) { this.tituloId = tituloId; }

    public String getTituloNome() { return tituloNome; }
    public void setTituloNome(String tituloNome) { this.tituloNome = tituloNome; }
}
