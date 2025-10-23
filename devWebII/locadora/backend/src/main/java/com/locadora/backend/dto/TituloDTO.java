/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import java.util.List;

public class TituloDTO {
    private Long id;
    private String nome;
    private Integer ano;
    private String sinopse;
    private String categoria;
    private Long classeId;
    private String classeNome;
    private Long diretorId;
    private String diretorNome;
    private List<String> atoresNomes;
    private List<Long> atoresIds;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public String getClasseNome() {
        return classeNome;
    }

    public void setClasseNome(String classeNome) {
        this.classeNome = classeNome;
    }

    public Long getDiretorId() {
        return diretorId;
    }

    public void setDiretorId(Long diretorId) {
        this.diretorId = diretorId;
    }

    public String getDiretorNome() {
        return diretorNome;
    }

    public void setDiretorNome(String diretorNome) {
        this.diretorNome = diretorNome;
    }

    public List<String> getAtoresNomes() {
        return atoresNomes;
    }

    public void setAtoresNomes(List<String> atoresNomes) {
        this.atoresNomes = atoresNomes;
    }

    public List<Long> getAtoresIds() {
        return atoresIds;
    }

    public void setAtoresIds(List<Long> atoresIds) {
        this.atoresIds = atoresIds;
    }

    
}

