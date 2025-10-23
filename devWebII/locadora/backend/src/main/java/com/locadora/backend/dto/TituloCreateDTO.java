/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import jakarta.validation.constraints.*;
import java.util.List;

public class TituloCreateDTO {

    @NotBlank(message = "Nome é obrigatório")
    private String nome;

    @NotNull(message = "Ano é obrigatório")
    @Min(value = 1900, message = "Ano inválido")
    private Integer ano;

    private String sinopse;

    @NotBlank(message = "Categoria é obrigatória")
    private String categoria;

    @NotNull(message = "Classe é obrigatória")
    private Long classeId;

    @NotNull(message = "Diretor é obrigatório")
    private Long diretorId;

    @NotEmpty(message = "Deve haver pelo menos um ator")
    private List<Long> atoresIds;

    // Getters e Setters

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Integer getAno() {
        return ano;
    }

    public void setAno(Integer ano) {
        this.ano = ano;
    }

    public String getSinopse() {
        return sinopse;
    }

    public void setSinopse(String sinopse) {
        this.sinopse = sinopse;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public Long getClasseId() {
        return classeId;
    }

    public void setClasseId(Long classeId) {
        this.classeId = classeId;
    }

    public Long getDiretorId() {
        return diretorId;
    }

    public void setDiretorId(Long diretorId) {
        this.diretorId = diretorId;
    }

    public List<Long> getAtoresIds() {
        return atoresIds;
    }

    public void setAtoresIds(List<Long> atoresIds) {
        this.atoresIds = atoresIds;
    }
    
}

