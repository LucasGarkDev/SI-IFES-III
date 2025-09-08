package com.locadora.backend.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "classes", uniqueConstraints = @UniqueConstraint(name = "uk_classe_nome", columnNames = "nome"))
public class Classe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 60)
    private String nome; // ex: "Livre", "12", "Lançamento", "Catálogo"

    @Column(length = 200)
    private String descricao;

    // se usar como política comercial:
    @Column(name = "prazo_devolucao_dias")
    private Integer prazoDevolucaoDias; // ex: 2 para lançamento, 5 catálogo

    @Column(name = "preco_diaria_centavos")
    private Integer precoDiariaCentavos; // guardar em centavos para evitar ponto flutuante

    @Column(nullable = false)
    private Boolean ativo = true;

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
