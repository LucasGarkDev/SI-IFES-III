/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import java.util.List;

public class TituloDetalhesDTO {
    private Long id;
    private String nome;
    private Integer ano;
    private String sinopse;
    private String categoria;

    private String classeNome;
    private Integer valorLocacao; // classe.precoDiariaCentavos

    private String diretorNome;

    private List<String> atores;

    private Integer quantidadeDisponivel; // total de itens do título

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

    public String getClasseNome() {
        return classeNome;
    }

    public void setClasseNome(String classeNome) {
        this.classeNome = classeNome;
    }

    public Integer getValorLocacao() {
        return valorLocacao;
    }

    public void setValorLocacao(Integer valorLocacao) {
        this.valorLocacao = valorLocacao;
    }

    public String getDiretorNome() {
        return diretorNome;
    }

    public void setDiretorNome(String diretorNome) {
        this.diretorNome = diretorNome;
    }

    public List<String> getAtores() {
        return atores;
    }

    public void setAtores(List<String> atores) {
        this.atores = atores;
    }

    public Integer getQuantidadeDisponivel() {
        return quantidadeDisponivel;
    }

    public void setQuantidadeDisponivel(Integer quantidadeDisponivel) {
        this.quantidadeDisponivel = quantidadeDisponivel;
    }
    
    
}
