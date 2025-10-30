package com.locadora.backend.dto;

import java.time.LocalDate;

public class ClasseDTO {
    private Long id;
    private String nome;
    private Integer precoDiariaCentavos;
    private LocalDate dataDevolucao;
//    private Boolean ativo;

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public Integer getPrecoDiariaCentavos() { return precoDiariaCentavos; }
    public void setPrecoDiariaCentavos(Integer precoDiariaCentavos) { this.precoDiariaCentavos = precoDiariaCentavos; }
    public LocalDate getDataDevolucao() { return dataDevolucao; }
    public void setDataDevolucao(LocalDate dataDevolucao) { this.dataDevolucao = dataDevolucao; }
//    public Boolean getAtivo() { return ativo; }
//    public void setAtivo(Boolean ativo) { this.ativo = ativo; }
}
