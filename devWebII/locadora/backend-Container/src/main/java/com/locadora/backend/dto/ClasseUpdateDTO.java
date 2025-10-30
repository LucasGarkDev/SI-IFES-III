package com.locadora.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.time.LocalDate;

public class ClasseUpdateDTO {

    @NotBlank(message = "Nome é obrigatório")
    private String nome;

    @Positive(message = "Preço deve ser maior que zero")
    private Integer precoDiariaCentavos;

    @NotNull(message = "Data de devolução é obrigatória")
    private LocalDate dataDevolucao;

//    private Boolean ativo;

    // getters/setters
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Integer getPrecoDiariaCentavos() { return precoDiariaCentavos; }
    public void setPrecoDiariaCentavos(Integer precoDiariaCentavos) { this.precoDiariaCentavos = precoDiariaCentavos; }

    public LocalDate getDataDevolucao() { return dataDevolucao; }
    public void setDataDevolucao(LocalDate dataDevolucao) { this.dataDevolucao = dataDevolucao; }

//    public Boolean getAtivo() { return ativo; }
//    public void setAtivo(Boolean ativo) { this.ativo = ativo; }
}
