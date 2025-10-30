/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import jakarta.validation.constraints.*;
import java.time.LocalDate;

public class ItemCreateDTO {

    @NotBlank(message = "Número de série é obrigatório")
    private String numSerie;

    @NotNull(message = "Data de aquisição é obrigatória")
    private LocalDate dtAquisicao;

    @NotBlank(message = "Tipo do item é obrigatório")
    private String tipoItem; // FITA, DVD, BLURAY

    @NotNull(message = "Título é obrigatório")
    private Long tituloId;

    // Getters e Setters
    public String getNumSerie() { return numSerie; }
    public void setNumSerie(String numSerie) { this.numSerie = numSerie; }

    public LocalDate getDtAquisicao() { return dtAquisicao; }
    public void setDtAquisicao(LocalDate dtAquisicao) { this.dtAquisicao = dtAquisicao; }

    public String getTipoItem() { return tipoItem; }
    public void setTipoItem(String tipoItem) { this.tipoItem = tipoItem; }

    public Long getTituloId() { return tituloId; }
    public void setTituloId(Long tituloId) { this.tituloId = tituloId; }
}

