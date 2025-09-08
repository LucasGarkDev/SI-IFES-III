package com.locadora.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Positive;

public class ClasseCreateDTO {
    @NotBlank(message = "Nome é obrigatório")
    private String nome;

    private String descricao;

    @Positive(message = "Prazo em dias deve ser positivo")
    private Integer prazoDevolucaoDias;

    @Positive(message = "Preço da diária deve ser positivo (em centavos)")
    private Integer precoDiariaCentavos;

    // getters/setters
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public Integer getPrazoDevolucaoDias() { return prazoDevolucaoDias; }
    public void setPrazoDevolucaoDias(Integer prazoDevolucaoDias) { this.prazoDevolucaoDias = prazoDevolucaoDias; }
    public Integer getPrecoDiariaCentavos() { return precoDiariaCentavos; }
    public void setPrecoDiariaCentavos(Integer precoDiariaCentavos) { this.precoDiariaCentavos = precoDiariaCentavos; }
}
