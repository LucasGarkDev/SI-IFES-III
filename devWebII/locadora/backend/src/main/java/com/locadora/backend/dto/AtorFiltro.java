package com.locadora.backend.dto;

public class AtorFiltro {
    private String nome;          // like
    private String nacionalidade; // equals (case-insensitive)
    private Boolean ativo;        // equals

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getNacionalidade() { return nacionalidade; }
    public void setNacionalidade(String nacionalidade) { this.nacionalidade = nacionalidade; }
    public Boolean getAtivo() { return ativo; }
    public void setAtivo(Boolean ativo) { this.ativo = ativo; }
}
