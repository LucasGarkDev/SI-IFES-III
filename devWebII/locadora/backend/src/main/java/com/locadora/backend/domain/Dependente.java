/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.domain;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("DEPENDENTE")
public class Dependente extends Cliente {

    @ManyToOne(optional = false)
    @JoinColumn(name = "socio_id", nullable = false)
    private Socio socio;

    // Getters e Setters
    public Socio getSocio() { return socio; }
    public void setSocio(Socio socio) { this.socio = socio; }
}

