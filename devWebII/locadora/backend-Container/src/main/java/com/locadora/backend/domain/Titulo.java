/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.domain;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "titulos", uniqueConstraints = {
        @UniqueConstraint(name = "uk_titulo_nome_ano", columnNames = {"nome", "ano"})
})
public class Titulo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 150)
    private String nome;

    @Column(nullable = false)
    private Integer ano;

    @Column(length = 1000)
    private String sinopse;

    @Column(nullable = false, length = 50)
    private String categoria; // Ação, Drama, Romance, etc.

    @ManyToOne(optional = false)
    @JoinColumn(name = "classe_id", nullable = false)
    private Classe classe;

    @ManyToOne(optional = false)
    @JoinColumn(name = "diretor_id", nullable = false)
    private Diretor diretor;

    @ManyToMany
    @JoinTable(
            name = "titulo_atores",
            joinColumns = @JoinColumn(name = "titulo_id"),
            inverseJoinColumns = @JoinColumn(name = "ator_id")
    )
    private Set<Ator> atores = new HashSet<>();

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Integer getAno() { return ano; }
    public void setAno(Integer ano) { this.ano = ano; }

    public String getSinopse() { return sinopse; }
    public void setSinopse(String sinopse) { this.sinopse = sinopse; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public Classe getClasse() { return classe; }
    public void setClasse(Classe classe) { this.classe = classe; }

    public Diretor getDiretor() { return diretor; }
    public void setDiretor(Diretor diretor) { this.diretor = diretor; }

    public Set<Ator> getAtores() { return atores; }
    public void setAtores(Set<Ator> atores) { this.atores = atores; }
}

