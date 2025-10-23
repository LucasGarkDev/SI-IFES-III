/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.domain;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "itens", uniqueConstraints = {
        @UniqueConstraint(name = "uk_item_num_serie", columnNames = {"num_serie"})
})
public class Item {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "num_serie", nullable = false, unique = true, length = 50)
    private String numSerie;

    @Column(name = "dt_aquisicao", nullable = false)
    private LocalDate dtAquisicao;

    @Column(name = "tipo_item", nullable = false, length = 20)
    private String tipoItem; // FITA, DVD, BLURAY

    @ManyToOne(optional = false)
    @JoinColumn(name = "titulo_id", nullable = false)
    private Titulo titulo;

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNumSerie() { return numSerie; }
    public void setNumSerie(String numSerie) { this.numSerie = numSerie; }

    public LocalDate getDtAquisicao() { return dtAquisicao; }
    public void setDtAquisicao(LocalDate dtAquisicao) { this.dtAquisicao = dtAquisicao; }

    public String getTipoItem() { return tipoItem; }
    public void setTipoItem(String tipoItem) { this.tipoItem = tipoItem; }

    public Titulo getTitulo() { return titulo; }
    public void setTitulo(Titulo titulo) { this.titulo = titulo; }
}
