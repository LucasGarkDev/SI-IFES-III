package com.locadora.backend.dto;

public class ClasseDTO {
    private Long id;
    private String nome;
    private String descricao;
    private Integer prazoDevolucaoDias;
    private Integer precoDiariaCentavos;
    private Boolean ativo;

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public Integer getPrazoDevolucaoDias() { return prazoDevolucaoDias; }
    public void setPrazoDevolucaoDias(Integer prazoDevolucaoDias) { this.prazoDevolucaoDias = prazoDevolucaoDias; }
    public Integer getPrecoDiariaCentavos() { return precoDiariaCentavos; }
    public void setPrecoDiariaCentavos(Integer precoDiariaCentavos) { this.precoDiariaCentavos = precoDiariaCentavos; }
    public Boolean getAtivo() { return ativo; }
    public void setAtivo(Boolean ativo) { this.ativo = ativo; }
}
